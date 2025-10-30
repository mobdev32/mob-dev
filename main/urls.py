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
    path('about/', views.about, name='about'),
    path('faq/', views.faq, name='faq'),
    path('stack/', views.stack, name='stack'),
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
    # Admin custom panel
    path('admin-panel/', views.admin_dashboard, name='admin_dashboard'),
    path('admin-panel/users/', views.admin_users, name='admin_users'),
    path('admin-panel/users/<int:user_id>/role/', views.admin_update_user_role, name='admin_update_user_role'),
    path('admin-panel/materials/new/', views.admin_material_create, name='admin_material_create'),
    path('admin-panel/materials/<int:material_id>/edit/', views.admin_material_edit, name='admin_material_edit'),
    path('admin-panel/materials/', views.admin_materials, name='admin_materials'),
    path('admin-panel/tests/new/', views.admin_test_create, name='admin_test_create'),
    path('admin-panel/tests/', views.admin_tests, name='admin_tests'),
    path('admin-panel/tests/<int:test_id>/edit/', views.admin_test_edit, name='admin_test_edit'),
    path('admin-panel/tests/<int:test_id>/questions/', views.admin_test_questions, name='admin_test_questions'),
    path('admin-panel/tests/<int:test_id>/questions/<int:question_id>/edit/', views.admin_question_edit, name='admin_question_edit'),
    path('admin-panel/feedbacks/', views.admin_feedbacks, name='admin_feedbacks'),
]
