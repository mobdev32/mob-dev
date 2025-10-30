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


@login_required
def teacher_feedback_list(request):
    if not _require_teacher(request.user):
        messages.error(request, 'Доступ только для преподавателей.')
        return redirect('main:home')

    feedback_qs = Feedback.objects.all().select_related('user', 'responded_by')

    status_filter = request.GET.get('status')
    if status_filter:
        feedback_qs = feedback_qs.filter(status=status_filter)

    context = {
        'title': 'Обращения студентов',
        'feedback_list': feedback_qs,
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

    new_status = request.POST.get('status')
    admin_response = request.POST.get('admin_response', '')

    changed = False
    if new_status and new_status in dict(Feedback.STATUS_CHOICES):
        feedback.status = new_status
        changed = True
    if admin_response is not None:
        feedback.admin_response = admin_response
        changed = True

    if changed:
        feedback.responded_by = request.user
        feedback.save()

    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'success': True})
    messages.success(request, 'Обращение обновлено.')
    return redirect('main:teacher_feedback_list')


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
