from django.contrib import admin
from .models import (
    Profile, Category, Material, MaterialFile, Test, Question, Answer,
    TestAttempt, UserAnswer, MaterialProgress, Feedback, Notification
)

@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'role', 'phone', 'created_at']
    list_filter = ['role', 'created_at']
    search_fields = ['user__username', 'user__email', 'phone']

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name', 'slug', 'created_at']
    search_fields = ['name', 'description']
    prepopulated_fields = {'slug': ('name',)}

class MaterialFileInline(admin.TabularInline):
    model = MaterialFile
    extra = 1

@admin.register(Material)
class MaterialAdmin(admin.ModelAdmin):
    list_display = ['title', 'category', 'author', 'difficulty', 'is_published', 'views_count', 'created_at']
    list_filter = ['category', 'difficulty', 'is_published', 'created_at']
    search_fields = ['title', 'description', 'content']
    inlines = [MaterialFileInline]

@admin.register(MaterialFile)
class MaterialFileAdmin(admin.ModelAdmin):
    list_display = ['name', 'material', 'uploaded_at']
    list_filter = ['uploaded_at']
    search_fields = ['name', 'material__title']

class AnswerInline(admin.TabularInline):
    model = Answer
    extra = 4

@admin.register(Question)
class QuestionAdmin(admin.ModelAdmin):
    list_display = ['question_text', 'test', 'question_type', 'points', 'order']
    list_filter = ['test', 'question_type']
    search_fields = ['question_text']
    inlines = [AnswerInline]
    ordering = ['test', 'order']

@admin.register(Answer)
class AnswerAdmin(admin.ModelAdmin):
    list_display = ['answer_text', 'question', 'is_correct', 'order']
    list_filter = ['is_correct', 'question__test']
    search_fields = ['answer_text', 'question__question_text']

@admin.register(Test)
class TestAdmin(admin.ModelAdmin):
    list_display = ['title', 'category', 'author', 'difficulty', 'is_published', 'attempts_count', 'created_at']
    list_filter = ['category', 'difficulty', 'is_published', 'created_at']
    search_fields = ['title', 'description']

class UserAnswerInline(admin.TabularInline):
    model = UserAnswer
    extra = 0
    readonly_fields = ['question', 'selected_answers', 'text_answer', 'is_correct', 'points_earned']

@admin.register(TestAttempt)
class TestAttemptAdmin(admin.ModelAdmin):
    list_display = ['user', 'test', 'score', 'max_score', 'percentage', 'is_passed', 'started_at']
    list_filter = ['is_passed', 'test', 'started_at']
    search_fields = ['user__username', 'test__title']
    inlines = [UserAnswerInline]
    readonly_fields = ['started_at', 'completed_at', 'time_spent']

@admin.register(UserAnswer)
class UserAnswerAdmin(admin.ModelAdmin):
    list_display = ['attempt', 'question', 'is_correct', 'points_earned']
    list_filter = ['is_correct', 'attempt__test']
    search_fields = ['attempt__user__username', 'question__question_text']

@admin.register(MaterialProgress)
class MaterialProgressAdmin(admin.ModelAdmin):
    list_display = ['user', 'material', 'progress_percentage', 'is_completed', 'last_read_at']
    list_filter = ['is_completed', 'last_read_at']
    search_fields = ['user__username', 'material__title']

@admin.register(Feedback)
class FeedbackAdmin(admin.ModelAdmin):
    list_display = ['subject', 'name', 'email', 'status', 'created_at']
    list_filter = ['status', 'created_at']
    search_fields = ['subject', 'name', 'email', 'message']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ['user', 'type', 'title', 'is_read', 'created_at']
    list_filter = ['type', 'is_read', 'created_at']
    search_fields = ['user__username', 'title', 'message']