from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from django.http import JsonResponse
from .models import Material, Test, Feedback, Profile, Category
from django.contrib.auth.models import User

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

def contact(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        subject = request.POST.get('subject')
        priority = request.POST.get('priority', 'medium')
        message = request.POST.get('message')
        
        if name and email and subject and message:
            Feedback.objects.create(
                name=name,
                email=email,
                subject=subject,
                priority=priority,
                message=message,
                user=request.user if request.user.is_authenticated else None
            )
            messages.success(request, 'Ваше сообщение успешно отправлено! Мы свяжемся с вами в ближайшее время.')
            return redirect('main:contact')
        else:
            messages.error(request, 'Пожалуйста, заполните все обязательные поля.')
    
    context = {
        'title': 'Контакты',
        'description': 'Свяжитесь с нами'
    }
    return render(request, 'main/contact.html', context)

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
    
    context = {
        'title': 'Профиль',
        'user': request.user,
        'profile': user_profile
    }
    return render(request, 'main/profile.html', context)
