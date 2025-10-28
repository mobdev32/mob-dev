from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from django.contrib import messages

def home(request):
    context = {
        'title': 'Главная страница',
        'description': 'Добро пожаловать в электронный учебник по мобильной разработке'
    }
    return render(request, 'main/home.html', context)

def materials(request):
    context = {
        'title': 'Обучающие материалы',
        'description': 'Изучайте мобильную разработку с нашими материалами'
    }
    return render(request, 'main/materials.html', context)

def tests(request):
    context = {
        'title': 'Тесты',
        'description': 'Проверьте свои знания с помощью тестов'
    }
    return render(request, 'main/tests.html', context)

def contact(request):
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
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, 'Регистрация прошла успешно!')
            return redirect('main:home')
    else:
        form = UserCreationForm()
    return render(request, 'main/register.html', {'form': form})

def logout_view(request):
    logout(request)
    messages.info(request, 'Вы вышли из системы.')
    return redirect('main:home')

@login_required
def profile(request):
    context = {
        'title': 'Профиль',
        'user': request.user
    }
    return render(request, 'main/profile.html', context)
