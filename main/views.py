from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, logout, authenticate, update_session_auth_hash
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from django.contrib import messages
from django.http import JsonResponse
from .models import Material, Test, Feedback, Profile, Category, TestAttempt, UserAnswer, Question, Answer, MaterialProgress
from django.contrib.auth.models import User
from django.utils import timezone
from django.views.decorators.http import require_POST
from django.db.models import Prefetch, Q
from django.urls import reverse

def home(request):
    materials = Material.objects.filter(is_published=True)[:3]
    tests = Test.objects.filter(is_published=True)[:3]
    context = {
        'title': 'Главная страница',
        'description': 'Добро пожаловать в электронный учебник по мобильной разработке',
        'materials': materials,
        'tests': tests
    }
    return render(request, 'main/home.html', context)

def materials(request):
    materials = Material.objects.filter(is_published=True)
    categories = Category.objects.all()
    context = {
        'title': 'Обучающие материалы',
        'description': 'Изучайте мобильную разработку с нашими материалами',
        'materials': materials,
        'categories': categories
    }
    return render(request, 'main/materials.html', context)

def tests(request):
    tests = Test.objects.filter(is_published=True)
    categories = Category.objects.all()
    context = {
        'title': 'Тесты',
        'description': 'Проверьте свои знания с помощью тестов',
        'tests': tests,
        'categories': categories
    }
    return render(request, 'main/tests.html', context)

def contacts(request):
    context = {
        'title': 'Контакты',
        'description': 'Свяжитесь с нами'
    }
    return render(request, 'main/contacts.html', context)

def feedback(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        subject = request.POST.get('subject')
        message = request.POST.get('message')
        
        if name and email and subject and message:
            Feedback.objects.create(
                name=name,
                email=email,
                subject=subject,
                message=message,
                user=request.user if request.user.is_authenticated else None
            )
            messages.success(request, 'Ваше сообщение успешно отправлено! Мы свяжемся с вами в ближайшее время.')
            return redirect('main:feedback')
        else:
            messages.error(request, 'Пожалуйста, заполните все обязательные поля.')
    
    context = {
        'title': 'Обратная связь',
        'description': 'Оставьте отзыв или задайте вопрос'
    }
    return render(request, 'main/feedback.html', context)

def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            messages.success(request, 'Вы успешно вошли в систему!')
            return redirect('main:home')
        else:
            messages.error(request, 'Неверное имя пользователя или пароль.')
    return render(request, 'main/login.html')

def register_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password1 = request.POST['password1']
        password2 = request.POST['password2']
        role = request.POST.get('role', 'student')
        
        if password1 == password2:
            if User.objects.filter(username=username).exists():
                messages.error(request, 'Пользователь с таким именем уже существует.')
            elif User.objects.filter(email=email).exists():
                messages.error(request, 'Пользователь с таким email уже существует.')
            else:
                user = User.objects.create_user(
                    username=username,
                    email=email,
                    password=password1
                )
                Profile.objects.create(user=user, role=role)
                login(request, user)
                messages.success(request, 'Регистрация прошла успешно!')
                return redirect('main:home')
        else:
            messages.error(request, 'Пароли не совпадают.')
    return render(request, 'main/register.html')

def logout_view(request):
    logout(request)
    messages.info(request, 'Вы вышли из системы.')
    return redirect('main:home')

@login_required
def profile(request):
    try:
        user_profile = request.user.profile
    except Profile.DoesNotExist:
        user_profile = Profile.objects.create(user=request.user, role='student')
    
    # Calculate actual progress
    total_materials = Material.objects.filter(is_published=True).count()
    completed_materials = MaterialProgress.objects.filter(
        user=request.user, 
        is_completed=True
    ).count()
    
    total_tests = Test.objects.filter(is_published=True).count()
    passed_tests = TestAttempt.objects.filter(
        user=request.user, 
        is_passed=True
    ).values('test').distinct().count()
    
    context = {
        'title': 'Профиль',
        'user': request.user,
        'profile': user_profile,
        'total_materials': total_materials,
        'completed_materials': completed_materials,
        'total_tests': total_tests,
        'passed_tests': passed_tests,
        'materials_progress': (completed_materials / total_materials * 100) if total_materials > 0 else 0,
        'tests_progress': (passed_tests / total_tests * 100) if total_tests > 0 else 0,
    }
    return render(request, 'main/profile.html', context)

def material_detail(request, material_id):
    material = get_object_or_404(Material, id=material_id, is_published=True)
    progress = None
    
    if request.user.is_authenticated:
        progress, created = MaterialProgress.objects.get_or_create(
            user=request.user,
            material=material,
            defaults={'progress_percentage': 0}
        )
        if created:
            progress.last_read_at = timezone.now()
            progress.save()
        
        if request.method == 'POST':
            import json
            data = json.loads(request.body)
            if data.get('action') == 'mark_completed':
                progress.progress_percentage = 100
                progress.is_completed = True
                progress.save()
                return JsonResponse({'success': True})
    
    material.views_count += 1
    material.save()
    
    context = {
        'title': material.title,
        'material': material,
        'progress': progress
    }
    return render(request, 'main/material_detail.html', context)

@login_required
def test_detail(request, test_id):
    test = get_object_or_404(Test, id=test_id, is_published=True)
    
    if request.method == 'POST':
        questions = Question.objects.filter(test=test).order_by('order')
        score = 0
        max_score = 0
        
        for question in questions:
            max_score += question.points
            
            if question.question_type == 'single':
                answer_id = request.POST.get(f'question_{question.id}')
                if answer_id:
                    answer = Answer.objects.get(id=answer_id)
                    if answer.is_correct:
                        score += question.points
            elif question.question_type == 'multiple':
                answer_ids = request.POST.getlist(f'question_{question.id}')
                correct_answers = Answer.objects.filter(question=question, is_correct=True)
                user_answers = Answer.objects.filter(id__in=answer_ids)
                
                if len(correct_answers) == len(user_answers) and all(a.is_correct for a in user_answers):
                    score += question.points
            elif question.question_type == 'text':
                text_answer = request.POST.get(f'question_{question.id}')
                if text_answer and text_answer.strip():
                    score += question.points * 0.5
        
        percentage = (score / max_score * 100) if max_score > 0 else 0
        is_passed = percentage >= test.passing_score
        
        attempt = TestAttempt.objects.create(
            user=request.user,
            test=test,
            score=score,
            max_score=max_score,
            percentage=percentage,
            is_passed=is_passed,
            completed_at=timezone.now()
        )
        
        test.attempts_count += 1
        test.save()
        
        messages.success(request, f'Тест завершен! Результат: {percentage:.1f}%')
        return redirect('main:test_result', attempt_id=attempt.id)
    
    questions = Question.objects.filter(test=test).order_by('order')
    context = {
        'title': test.title,
        'test': test,
        'questions': questions
    }
    return render(request, 'main/test_detail.html', context)

@login_required
def test_result(request, attempt_id):
    attempt = get_object_or_404(TestAttempt, id=attempt_id, user=request.user)
    
    context = {
        'title': f'Результат теста: {attempt.test.title}',
        'attempt': attempt
    }
    return render(request, 'main/test_result.html', context)

@login_required
def profile_settings(request):
    if request.method == 'POST':
        if 'change_password' in request.POST:
            form = PasswordChangeForm(request.user, request.POST)
            if form.is_valid():
                user = form.save()
                update_session_auth_hash(request, user)
                messages.success(request, 'Пароль успешно изменен!')
                return redirect('main:profile_settings')
            else:
                messages.error(request, 'Ошибка при изменении пароля.')
        elif 'update_profile' in request.POST:
            first_name = request.POST.get('first_name', '')
            last_name = request.POST.get('last_name', '')
            email = request.POST.get('email', '')
            phone = request.POST.get('phone', '')
            bio = request.POST.get('bio', '')
            
            user = request.user
            user.first_name = first_name
            user.last_name = last_name
            user.email = email
            user.save()
            
            profile = request.user.profile
            profile.phone = phone
            profile.bio = bio
            profile.save()
            
            messages.success(request, 'Профиль успешно обновлен!')
            return redirect('main:profile_settings')
    
    password_form = PasswordChangeForm(request.user)
    profile = request.user.profile
    
    context = {
        'title': 'Настройки профиля',
        'password_form': password_form,
        'profile': profile
    }
    return render(request, 'main/profile_settings.html', context)

# -------------------- Teacher area --------------------

def _require_teacher(user):
    if not getattr(user, 'is_authenticated', False):
        return False
    # Allow staff as well to reduce lockout during setup
    if getattr(user, 'is_staff', False):
        return True
    profile = getattr(user, 'profile', None)
    if not profile:
        return False
    role_value = (getattr(profile, 'role', '') or '').strip().lower()
    role_display = (getattr(profile, 'get_role_display', lambda: '')() or '').strip().lower()
    return role_value == 'teacher' or role_display == 'преподаватель'


def _require_admin(user):
    if not getattr(user, 'is_authenticated', False):
        return False
    # treat Django staff as admin for this panel
    if getattr(user, 'is_staff', False):
        return True
    profile = getattr(user, 'profile', None)
    if not profile:
        return False
    role_value = (getattr(profile, 'role', '') or '').strip().lower()
    role_display = (getattr(profile, 'get_role_display', lambda: '')() or '').strip().lower()
    return role_value == 'admin' or role_display == 'администратор'


@login_required
def teacher_feedback_list(request):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')

    feedback_qs = Feedback.objects.all().select_related('user', 'responded_by')

    # Default: show only new feedbacks
    status_filter = request.GET.get('status', 'new')
    mine = request.GET.get('mine') == '1'
    if status_filter:
        feedback_qs = feedback_qs.filter(status=status_filter)
    if mine:
        feedback_qs = feedback_qs.filter(responded_by=request.user)

    context = {
        'title': 'Обращения студентов',
        'feedback_list': feedback_qs,
        'status_filter': status_filter,
        'mine': mine,
    }
    return render(request, 'main/teacher/feedback_list.html', context)


@login_required
def teacher_home(request):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')
    return redirect('main:teacher_feedback_list')


@login_required
@require_POST
def teacher_feedback_update(request, feedback_id):
    if not _require_teacher(request.user):
        return JsonResponse({'success': False, 'error': 'forbidden'}, status=403)

    feedback = get_object_or_404(Feedback, id=feedback_id)

    action = request.POST.get('action')
    admin_response = request.POST.get('admin_response', '')

    if action == 'start':
        feedback.status = 'in_progress'
        feedback.responded_by = request.user
        feedback.save()
        messages.success(request, 'Обращение взято в работу.')
    elif action == 'close':
        if admin_response is not None:
            feedback.admin_response = admin_response
        feedback.status = 'closed'
        if not feedback.responded_by:
            feedback.responded_by = request.user
        feedback.save()
        messages.success(request, 'Обращение закрыто.')
    else:
        # Generic update (status/comment change)
        new_status = request.POST.get('status')
        changed = False
        if admin_response is not None and admin_response != feedback.admin_response:
            feedback.admin_response = admin_response
            changed = True
        if new_status in {'new', 'in_progress', 'closed'} and new_status != feedback.status:
            feedback.status = new_status
            changed = True
        if changed:
            if not feedback.responded_by:
                feedback.responded_by = request.user
            feedback.save()
            messages.success(request, 'Обращение обновлено.')

    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'success': True})
    # Prefer redirecting to detail if provided
    next_url = request.POST.get('next') or reverse('main:teacher_feedback_detail', args=[feedback.id])
    return redirect(next_url)


@login_required
def teacher_feedback_detail(request, feedback_id):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')

    fb = get_object_or_404(Feedback.objects.select_related('user', 'responded_by'), id=feedback_id)
    context = {
        'title': f'Обращение: {fb.subject}',
        'fb': fb,
    }
    return render(request, 'main/teacher/feedback_detail.html', context)


@login_required
def teacher_students(request):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')

    query = request.GET.get('q', '').strip()
    students = User.objects.filter(profile__role='student')
    if query:
        students = students.filter(
            Q(username__icontains=query)
            | Q(first_name__icontains=query)
            | Q(last_name__icontains=query)
            | Q(email__icontains=query)
        )
    students = students.order_by('username')
    context = {
        'title': 'Студенты',
        'students': students,
        'query': query,
    }
    return render(request, 'main/teacher/students.html', context)


@login_required
def teacher_student_detail(request, user_id):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')

    student = get_object_or_404(User, id=user_id, profile__role='student')
    materials_progress = (
        MaterialProgress.objects
        .filter(user=student)
        .select_related('material')
        .order_by('-last_read_at')
    )
    attempts = (
        TestAttempt.objects
        .filter(user=student)
        .select_related('test')
        .order_by('-started_at')
    )

    context = {
        'title': f'Студент: {student.get_username()}',
        'student': student,
        'materials_progress': materials_progress,
        'attempts': attempts,
    }
    return render(request, 'main/teacher/student_detail.html', context)

# -------------------- Admin custom panel --------------------

@login_required
def admin_dashboard(request):
    if not _require_admin(request.user):
        messages.error(request, 'Доступ только для администраторов.')
        return redirect('main:home')

    total_users = User.objects.count()
    total_students = User.objects.filter(profile__role='student').count()
    total_teachers = User.objects.filter(profile__role='teacher').count()
    total_materials = Material.objects.count()
    total_tests = Test.objects.count()
    new_feedbacks = Feedback.objects.filter(status='new').count()

    context = {
        'title': 'Админ панель',
        'total_users': total_users,
        'total_students': total_students,
        'total_teachers': total_teachers,
        'total_materials': total_materials,
        'total_tests': total_tests,
        'new_feedbacks': new_feedbacks,
    }
    return render(request, 'main/admin/dashboard.html', context)


@login_required
def admin_users(request):
    if not _require_admin(request.user):
        messages.error(request, 'Доступ только для администраторов.')
        return redirect('main:home')

    query = request.GET.get('q', '').strip()
    users = User.objects.all().select_related('profile')
    if query:
        users = users.filter(
            Q(username__icontains=query)
            | Q(first_name__icontains=query)
            | Q(last_name__icontains=query)
            | Q(email__icontains=query)
        )
    users = users.order_by('username')
    context = {
        'title': 'Пользователи',
        'users': users,
        'query': query,
    }
    return render(request, 'main/admin/users.html', context)


@login_required
@require_POST
def admin_update_user_role(request, user_id):
    if not _require_admin(request.user):
        return JsonResponse({'success': False, 'error': 'forbidden'}, status=403)
    target = get_object_or_404(User, id=user_id)
    new_role = (request.POST.get('role') or '').strip()
    if new_role not in dict(Profile.ROLE_CHOICES):
        messages.error(request, 'Неверная роль.')
        return redirect('main:admin_users')
    profile, _ = Profile.objects.get_or_create(user=target)
    profile.role = new_role
    profile.save()
    messages.success(request, f'Роль пользователя {target.username} обновлена.')
    return redirect('main:admin_users')


@login_required
def admin_material_create(request):
    if not _require_admin(request.user):
        messages.error(request, 'Доступ только для администраторов.')
        return redirect('main:home')

    if request.method == 'POST':
        title = request.POST.get('title', '').strip()
        content = request.POST.get('content', '').strip()
        description = request.POST.get('description', '').strip()
        category_id = request.POST.get('category')
        difficulty = request.POST.get('difficulty', 'beginner')
        is_published = request.POST.get('is_published') == 'on'
        if title and content and category_id:
            category = get_object_or_404(Category, id=category_id)
            Material.objects.create(
                title=title,
                content=content,
                description=description,
                category=category,
                author=request.user,
                difficulty=difficulty,
                is_published=is_published,
            )
            messages.success(request, 'Материал создан.')
            return redirect('main:admin_dashboard')
        messages.error(request, 'Заполните обязательные поля.')

    context = {
        'title': 'Новый материал',
        'categories': Category.objects.all(),
        'difficulties': Material.DIFFICULTY_CHOICES,
    }
    return render(request, 'main/admin/material_create.html', context)


@login_required
def admin_test_create(request):
    if not _require_admin(request.user):
        messages.error(request, 'Доступ только для администраторов.')
        return redirect('main:home')

    if request.method == 'POST':
        title = request.POST.get('title', '').strip()
        description = request.POST.get('description', '').strip()
        category_id = request.POST.get('category')
        difficulty = request.POST.get('difficulty', 'beginner')
        time_limit = int(request.POST.get('time_limit') or 0)
        passing_score = int(request.POST.get('passing_score') or 70)
        is_published = request.POST.get('is_published') == 'on'
        if title and category_id:
            category = get_object_or_404(Category, id=category_id)
            Test.objects.create(
                title=title,
                description=description,
                category=category,
                author=request.user,
                difficulty=difficulty,
                time_limit=time_limit,
                passing_score=passing_score,
                is_published=is_published,
            )
            messages.success(request, 'Тест создан.')
            return redirect('main:admin_dashboard')
        messages.error(request, 'Заполните обязательные поля.')

    context = {
        'title': 'Новый тест',
        'categories': Category.objects.all(),
        'difficulties': Test.DIFFICULTY_CHOICES,
    }
    return render(request, 'main/admin/test_create.html', context)
