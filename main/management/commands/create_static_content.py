from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from main.models import Category, Material, Test, Question, Answer

class Command(BaseCommand):
    help = 'Создает статический контент для учебника'

    def handle(self, *args, **options):
        self.stdout.write('Создание статического контента...')
        
        admin_user, created = User.objects.get_or_create(
            username='admin',
            defaults={
                'email': 'admin@witte-university.ru',
                'first_name': 'Администратор',
                'last_name': 'Системы',
                'is_staff': True,
                'is_superuser': True
            }
        )
        if created:
            admin_user.set_password('admin123')
            admin_user.save()
            self.stdout.write('Создан пользователь admin с паролем admin123')
        
        teacher_user, created = User.objects.get_or_create(
            username='teacher',
            defaults={
                'email': 'teacher@witte-university.ru',
                'first_name': 'Преподаватель',
                'last_name': 'Мобильной разработки',
                'is_staff': True
            }
        )
        if created:
            teacher_user.set_password('teacher123')
            teacher_user.save()
            self.stdout.write('Создан пользователь teacher с паролем teacher123')
        
        categories_data = [
            {'name': 'Основы', 'slug': 'basics', 'description': 'Основы мобильной разработки'},
            {'name': 'Android', 'slug': 'android', 'description': 'Разработка Android приложений'},
            {'name': 'iOS', 'slug': 'ios', 'description': 'Разработка iOS приложений'},
            {'name': 'React Native', 'slug': 'react-native', 'description': 'Кроссплатформенная разработка с React Native'},
            {'name': 'Flutter', 'slug': 'flutter', 'description': 'Разработка с Flutter'},
        ]
        
        categories = {}
        for cat_data in categories_data:
            category, created = Category.objects.get_or_create(
                slug=cat_data['slug'],
                defaults=cat_data
            )
            categories[cat_data['slug']] = category
            if created:
                self.stdout.write(f'Создана категория: {category.name}')
        
        materials_data = [
            {
                'title': 'Введение в мобильную разработку',
                'content': 'Мобильная разработка — это процесс создания программного обеспечения для мобильных устройств. Включает в себя разработку для Android, iOS и других платформ.',
                'description': 'Основы мобильной разработки, архитектура приложений и современные технологии.',
                'category': categories['basics'],
                'difficulty': 'beginner',
                'reading_time': 15
            },
            {
                'title': 'Android разработка для начинающих',
                'content': 'Android — операционная система для мобильных устройств, разработанная Google. Основные языки программирования: Java и Kotlin.',
                'description': 'Изучение основ разработки Android приложений с использованием Java и Kotlin.',
                'category': categories['android'],
                'difficulty': 'beginner',
                'reading_time': 45
            },
            {
                'title': 'iOS разработка с Swift',
                'content': 'iOS — операционная система для устройств Apple. Swift — современный язык программирования для разработки iOS приложений.',
                'description': 'Основы разработки iOS приложений с использованием языка программирования Swift.',
                'category': categories['ios'],
                'difficulty': 'intermediate',
                'reading_time': 60
            },
            {
                'title': 'React Native для начинающих',
                'content': 'React Native — фреймворк для создания кроссплатформенных мобильных приложений с использованием JavaScript и React.',
                'description': 'Изучение основ React Native для создания кроссплатформенных мобильных приложений.',
                'category': categories['react-native'],
                'difficulty': 'intermediate',
                'reading_time': 90
            },
            {
                'title': 'Flutter - современный подход',
                'content': 'Flutter — фреймворк от Google для создания красивых и быстрых приложений с использованием языка Dart.',
                'description': 'Создание красивых и быстрых приложений с помощью Flutter и языка Dart.',
                'category': categories['flutter'],
                'difficulty': 'advanced',
                'reading_time': 120
            },
            {
                'title': 'Работа с данными в мобильных приложениях',
                'content': 'Изучение способов хранения и обработки данных в мобильных приложениях: локальные базы данных, API, кэширование.',
                'description': 'Изучение способов хранения и обработки данных в мобильных приложениях.',
                'category': categories['basics'],
                'difficulty': 'intermediate',
                'reading_time': 75
            }
        ]
        
        for material_data in materials_data:
            material, created = Material.objects.get_or_create(
                title=material_data['title'],
                defaults={
                    **material_data,
                    'author': teacher_user,
                    'is_published': True
                }
            )
            if created:
                self.stdout.write(f'Создан материал: {material.title}')
        
        tests_data = [
            {
                'title': 'Основы мобильной разработки',
                'description': 'Тест по основам мобильной разработки, архитектуре приложений и современным технологиям.',
                'category': categories['basics'],
                'difficulty': 'beginner',
                'time_limit': 10,
                'passing_score': 70,
                'questions': [
                    {
                        'text': 'Что такое мобильная разработка?',
                        'type': 'single',
                        'points': 1,
                        'answers': [
                            {'text': 'Создание веб-сайтов', 'is_correct': False},
                            {'text': 'Создание программного обеспечения для мобильных устройств', 'is_correct': True},
                            {'text': 'Создание игр для компьютера', 'is_correct': False},
                            {'text': 'Создание баз данных', 'is_correct': False}
                        ]
                    },
                    {
                        'text': 'Какие основные платформы для мобильной разработки?',
                        'type': 'multiple',
                        'points': 2,
                        'answers': [
                            {'text': 'Android', 'is_correct': True},
                            {'text': 'iOS', 'is_correct': True},
                            {'text': 'Windows Phone', 'is_correct': False},
                            {'text': 'BlackBerry', 'is_correct': False}
                        ]
                    }
                ]
            },
            {
                'title': 'Android разработка',
                'description': 'Тест по разработке Android приложений, включая Java, Kotlin и архитектурные паттерны.',
                'category': categories['android'],
                'difficulty': 'intermediate',
                'time_limit': 20,
                'passing_score': 75,
                'questions': [
                    {
                        'text': 'Какой язык программирования используется для Android?',
                        'type': 'multiple',
                        'points': 2,
                        'answers': [
                            {'text': 'Java', 'is_correct': True},
                            {'text': 'Kotlin', 'is_correct': True},
                            {'text': 'Swift', 'is_correct': False},
                            {'text': 'C#', 'is_correct': False}
                        ]
                    }
                ]
            }
        ]
        
        for test_data in tests_data:
            questions_data = test_data.pop('questions')
            test, created = Test.objects.get_or_create(
                title=test_data['title'],
                defaults={
                    **test_data,
                    'author': teacher_user,
                    'is_published': True
                }
            )
            if created:
                self.stdout.write(f'Создан тест: {test.title}')
                
                for i, question_data in enumerate(questions_data):
                    answers_data = question_data.pop('answers')
                    question = Question.objects.create(
                        test=test,
                        question_text=question_data['text'],
                        question_type=question_data['type'],
                        points=question_data['points'],
                        order=i + 1
                    )
                    
                    for j, answer_data in enumerate(answers_data):
                        Answer.objects.create(
                            question=question,
                            answer_text=answer_data['text'],
                            is_correct=answer_data['is_correct'],
                            order=j + 1
                        )
        
        self.stdout.write(
            self.style.SUCCESS('Статический контент успешно создан!')
        )
