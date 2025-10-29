from django.urls import path
from . import views

app_name = 'main'

urlpatterns = [
    path('', views.home, name='home'),
    path('materials/', views.materials, name='materials'),
    path('materials/<int:material_id>/', views.material_detail, name='material_detail'),
    path('tests/', views.tests, name='tests'),
    path('tests/<int:test_id>/', views.test_detail, name='test_detail'),
    path('tests/result/<int:attempt_id>/', views.test_result, name='test_result'),
    path('contact/', views.contact, name='contact'),
    path('login/', views.login_view, name='login'),
    path('register/', views.register_view, name='register'),
    path('logout/', views.logout_view, name='logout'),
    path('profile/', views.profile, name='profile'),
]
