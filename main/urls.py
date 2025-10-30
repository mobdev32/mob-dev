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
    path('contacts/', views.contacts, name='contacts'),
    path('feedback/', views.feedback, name='feedback'),
    path('login/', views.login_view, name='login'),
    path('register/', views.register_view, name='register'),
    path('logout/', views.logout_view, name='logout'),
    path('profile/', views.profile, name='profile'),
    path('profile/settings/', views.profile_settings, name='profile_settings'),
    # Teacher area
    path('teacher/feedbacks/', views.teacher_feedback_list, name='teacher_feedback_list'),
    path('teacher/feedbacks/<int:feedback_id>/', views.teacher_feedback_detail, name='teacher_feedback_detail'),
    path('teacher/feedbacks/<int:feedback_id>/update/', views.teacher_feedback_update, name='teacher_feedback_update'),
    path('teacher/students/', views.teacher_students, name='teacher_students'),
    path('teacher/students/<int:user_id>/', views.teacher_student_detail, name='teacher_student_detail'),
    path('teacher/', views.teacher_home, name='teacher_home'),
    path('teacher', views.teacher_home),
]
