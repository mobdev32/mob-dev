-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 31, 2025 at 08:59 AM
-- Server version: 8.0.42
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile_dev_textbook`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Категория', 7, 'add_category'),
(26, 'Can change Категория', 7, 'change_category'),
(27, 'Can delete Категория', 7, 'delete_category'),
(28, 'Can view Категория', 7, 'view_category'),
(29, 'Can add Вопрос', 8, 'add_question'),
(30, 'Can change Вопрос', 8, 'change_question'),
(31, 'Can delete Вопрос', 8, 'delete_question'),
(32, 'Can view Вопрос', 8, 'view_question'),
(33, 'Can add Обратная связь', 9, 'add_feedback'),
(34, 'Can change Обратная связь', 9, 'change_feedback'),
(35, 'Can delete Обратная связь', 9, 'delete_feedback'),
(36, 'Can view Обратная связь', 9, 'view_feedback'),
(37, 'Can add Материал', 10, 'add_material'),
(38, 'Can change Материал', 10, 'change_material'),
(39, 'Can delete Материал', 10, 'delete_material'),
(40, 'Can view Материал', 10, 'view_material'),
(41, 'Can add material file', 11, 'add_materialfile'),
(42, 'Can change material file', 11, 'change_materialfile'),
(43, 'Can delete material file', 11, 'delete_materialfile'),
(44, 'Can view material file', 11, 'view_materialfile'),
(45, 'Can add Уведомление', 12, 'add_notification'),
(46, 'Can change Уведомление', 12, 'change_notification'),
(47, 'Can delete Уведомление', 12, 'delete_notification'),
(48, 'Can view Уведомление', 12, 'view_notification'),
(49, 'Can add profile', 13, 'add_profile'),
(50, 'Can change profile', 13, 'change_profile'),
(51, 'Can delete profile', 13, 'delete_profile'),
(52, 'Can view profile', 13, 'view_profile'),
(53, 'Can add Ответ', 14, 'add_answer'),
(54, 'Can change Ответ', 14, 'change_answer'),
(55, 'Can delete Ответ', 14, 'delete_answer'),
(56, 'Can view Ответ', 14, 'view_answer'),
(57, 'Can add Тест', 15, 'add_test'),
(58, 'Can change Тест', 15, 'change_test'),
(59, 'Can delete Тест', 15, 'delete_test'),
(60, 'Can view Тест', 15, 'view_test'),
(61, 'Can add Попытка прохождения теста', 16, 'add_testattempt'),
(62, 'Can change Попытка прохождения теста', 16, 'change_testattempt'),
(63, 'Can delete Попытка прохождения теста', 16, 'delete_testattempt'),
(64, 'Can view Попытка прохождения теста', 16, 'view_testattempt'),
(65, 'Can add Ответ пользователя', 17, 'add_useranswer'),
(66, 'Can change Ответ пользователя', 17, 'change_useranswer'),
(67, 'Can delete Ответ пользователя', 17, 'delete_useranswer'),
(68, 'Can view Ответ пользователя', 17, 'view_useranswer'),
(69, 'Can add Прогресс изучения материала', 18, 'add_materialprogress'),
(70, 'Can change Прогресс изучения материала', 18, 'change_materialprogress'),
(71, 'Can delete Прогресс изучения материала', 18, 'delete_materialprogress'),
(72, 'Can view Прогресс изучения материала', 18, 'view_materialprogress');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(4, 'pbkdf2_sha256$1000000$AjeOzyfqKFMlNJRo0W0jZH$h+krd/dEmKDhx2u3LuQ3Zh9GTjJE1bbg+ogI3zOhDuA=', '2025-10-30 13:41:58.005998', 0, 'dima', 'Dmitriy', 'Krylov', 'dima@example.com', 0, 1, '2025-10-29 09:17:51.924194'),
(5, 'pbkdf2_sha256$1000000$9pRUKJf5BrdMUymGmMnz2S$Mxo+HUSUpZo/40AIt1P9FaMJAmg6QCYqhtu1zJfrk+U=', '2025-10-30 13:42:05.376082', 0, 'vladimir', 'Vladimir', 'Kuznetsov', 'vladimir@example.com', 0, 1, '2025-10-29 09:17:52.574630'),
(6, 'pbkdf2_sha256$1000000$BhZTK3JgnY7KshNpNaPqMm$95kT7CDKHuaQYfWeiRjKVY8kpDmUmWIbDZkjHOzgXOE=', '2025-10-30 13:56:54.425588', 1, 'admin', 'Admin', 'User', 'admin@example.com', 1, 1, '2025-10-29 09:17:53.216255'),
(7, '', NULL, 0, 'teacher', 'Преподаватель', 'Мобильной разработки', 'teacher@witte-university.ru', 1, 1, '2025-10-31 08:40:18.292131');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(14, 'main', 'answer'),
(7, 'main', 'category'),
(9, 'main', 'feedback'),
(10, 'main', 'material'),
(11, 'main', 'materialfile'),
(18, 'main', 'materialprogress'),
(12, 'main', 'notification'),
(13, 'main', 'profile'),
(8, 'main', 'question'),
(15, 'main', 'test'),
(16, 'main', 'testattempt'),
(17, 'main', 'useranswer'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-10-28 10:18:24.713242'),
(2, 'auth', '0001_initial', '2025-10-28 10:18:25.496773'),
(3, 'admin', '0001_initial', '2025-10-28 10:18:25.700511'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-10-28 10:18:25.709249'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-28 10:18:25.717592'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-10-28 10:18:25.868465'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-10-28 10:18:25.955380'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-10-28 10:18:26.081678'),
(9, 'auth', '0004_alter_user_username_opts', '2025-10-28 10:18:26.091842'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-10-28 10:18:26.197828'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-10-28 10:18:26.199822'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-10-28 10:18:26.211868'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-10-28 10:18:26.333671'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-10-28 10:18:26.427847'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-10-28 10:18:26.512516'),
(16, 'auth', '0011_update_proxy_permissions', '2025-10-28 10:18:26.523508'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-10-28 10:18:26.608110'),
(18, 'main', '0001_initial', '2025-10-28 10:18:28.652217'),
(19, 'sessions', '0001_initial', '2025-10-28 10:18:28.703735'),
(20, 'main', '0002_remove_priority_from_feedback', '2025-10-29 09:02:36.090437');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('nr7db93krx9z3drif86vi43jjjofp285', '.eJxVjEEOwiAQRe_C2pChA5S6dO8ZyMCAVA0kpV0Z765NutDtf-_9l_C0rcVvPS1-ZnEWVpx-t0DxkeoO-E711mRsdV3mIHdFHrTLa-P0vBzu30GhXr61JiCXeMjk0ObBgIvAVjsNQWWVgKxC4zBF1sYEmnJGMJOFkRHB6lG8P-BANzo:1vET94:CaKmHd0khHpHZ1TeNMMGQcmQOWAl3k7Cu6AF49iTKWs', '2025-11-13 13:56:54.428666');

-- --------------------------------------------------------

--
-- Table structure for table `main_answer`
--

CREATE TABLE `main_answer` (
  `id` bigint NOT NULL,
  `answer_text` longtext NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `order` int UNSIGNED NOT NULL,
  `question_id` bigint NOT NULL
) ;

--
-- Dumping data for table `main_answer`
--

INSERT INTO `main_answer` (`id`, `answer_text`, `is_correct`, `order`, `question_id`) VALUES
(87, 'Model View Controller', 1, 1, 24),
(88, 'Main Visual Core', 0, 2, 24),
(89, 'Modular Vector Code', 0, 3, 24),
(90, 'Mobile View Channel', 0, 4, 24),
(91, 'MVVM', 1, 1, 25),
(92, 'JPEG', 0, 2, 25),
(93, 'REST', 0, 3, 25),
(94, 'UUID', 0, 4, 25),
(95, 'Обрабатывает логику и передаёт данные View', 1, 1, 26),
(96, 'Рисует интерфейс', 0, 2, 26),
(97, 'Работает с базой', 0, 3, 26),
(98, 'Отвечает за маршрутизацию', 0, 4, 26),
(99, 'Навигация между экранами', 1, 1, 27),
(100, 'Рендерит UI', 0, 2, 27),
(101, 'Работает с сетью', 0, 3, 27),
(102, 'Шифрует данные', 0, 4, 27),
(103, 'Многоуровневое разделение ответственности', 1, 1, 28),
(104, 'Тип базы данных', 0, 2, 28),
(105, 'Язык программирования', 0, 3, 28),
(106, 'Дизайн паттерн', 0, 4, 28),
(107, 'Черновой макет экрана', 1, 1, 29),
(108, 'Готовый дизайн', 0, 2, 29),
(109, 'Код приложения', 0, 3, 29),
(110, 'Логотип', 0, 4, 29),
(111, 'Для понимания целевой аудитории', 1, 1, 30),
(112, 'Для хранения паролей', 0, 2, 30),
(113, 'Для анимации', 0, 3, 30),
(114, 'Для разработки API', 0, 4, 30),
(115, 'User Experience', 1, 1, 31),
(116, 'Ultra eXpress', 0, 2, 31),
(117, 'Unique XML', 0, 3, 31),
(118, 'User XCode', 0, 4, 31),
(119, 'Набор интерфейсных компонентов', 1, 1, 32),
(120, 'База пользователей', 0, 2, 32),
(121, 'Алгоритм навигации', 0, 3, 32),
(122, 'Видеоурок', 0, 4, 32),
(123, 'Простота и понятность', 1, 1, 33),
(124, 'Сложные элементы', 0, 2, 33),
(125, 'Максимум текста', 0, 3, 33),
(126, 'Минимум контрастности', 0, 4, 33),
(127, 'Dart', 1, 1, 34),
(128, 'Swift', 0, 2, 34),
(129, 'Kotlin', 0, 3, 34),
(130, 'Python', 0, 4, 34),
(131, 'Элемент интерфейса', 1, 1, 35),
(132, 'Тип базы данных', 0, 2, 35),
(133, 'Сеть', 0, 3, 35),
(134, 'Движок игры', 0, 4, 35),
(135, 'main.dart', 1, 1, 36),
(136, 'index.js', 0, 2, 36),
(137, 'app.swift', 0, 3, 36),
(138, 'run.kt', 0, 4, 36),
(139, 'pub.dev', 1, 1, 37),
(140, 'npm', 0, 2, 37),
(141, 'cocoa', 0, 3, 37),
(142, 'pip', 0, 4, 37),
(143, 'Быстрое обновление кода без перезапуска', 1, 1, 38),
(144, 'Удаление кэша', 0, 2, 38),
(145, 'Сборка релиза', 0, 3, 38),
(146, 'Обновление IDE', 0, 4, 38),
(147, 'var name', 1, 1, 39),
(148, 'let name', 0, 2, 39),
(149, 'const name', 0, 3, 39),
(150, 'define name', 0, 4, 39),
(151, 'Целое число', 1, 1, 40),
(152, 'Строка', 0, 2, 40),
(153, 'Булево', 0, 3, 40),
(154, 'Массив', 0, 4, 40),
(155, 'Проверяет условие и выходит при неуспехе', 1, 1, 41),
(156, 'Создает цикл', 0, 2, 41),
(157, 'Объявляет класс', 0, 3, 41),
(158, 'Очищает память', 0, 4, 41),
(159, 'Тип, который может быть nil', 1, 1, 42),
(160, 'Метод класса', 0, 2, 42),
(161, 'Поток', 0, 3, 42),
(162, 'Цикл', 0, 4, 42),
(163, 'var arr:[Int] = []', 1, 1, 43),
(164, 'array arr()', 0, 2, 43),
(165, 'list arr()', 0, 3, 43),
(166, 'make arr', 0, 4, 43),
(167, 'Kotlin', 1, 1, 44),
(168, 'Ruby', 0, 2, 44),
(169, 'Go', 0, 3, 44),
(170, 'PHP', 0, 4, 44),
(171, 'Экран приложения', 1, 1, 45),
(172, 'Сеть', 0, 2, 45),
(173, 'Файл ресурсов', 0, 3, 45),
(174, 'Таблица БД', 0, 4, 45),
(175, 'Папка res/', 1, 1, 46),
(176, 'Папка core/', 0, 2, 46),
(177, 'Папка libs/', 0, 3, 46),
(178, 'Папка bin/', 0, 4, 46),
(179, 'С помощью метода onCreate()', 1, 1, 47),
(180, 'Через main.swift', 0, 2, 47),
(181, 'Через start()', 0, 3, 47),
(182, 'Автоматически без точки входа', 0, 4, 47),
(183, 'Разметка интерфейса', 1, 1, 48),
(184, 'Файл логов', 0, 2, 48),
(185, 'База данных', 0, 3, 48),
(186, 'Файл настроек Gradle', 0, 4, 48);

-- --------------------------------------------------------

--
-- Table structure for table `main_category`
--

CREATE TABLE `main_category` (
  `id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `main_category`
--

INSERT INTO `main_category` (`id`, `name`, `description`, `slug`, `created_at`) VALUES
(1, 'Основы', 'Основы мобильной разработки', 'basics', '2025-10-28 10:26:31.202385'),
(2, 'Android', 'Разработка Android приложений', 'android', '2025-10-28 10:26:31.206376'),
(3, 'iOS', 'Разработка iOS приложений', 'ios', '2025-10-28 10:26:31.212492'),
(4, 'React Native', 'Кроссплатформенная разработка с React Native', 'react-native', '2025-10-28 10:26:31.217537'),
(5, 'Flutter', 'Разработка с Flutter', 'flutter', '2025-10-28 10:26:31.221070');

-- --------------------------------------------------------

--
-- Table structure for table `main_feedback`
--

CREATE TABLE `main_feedback` (
  `id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `status` varchar(12) NOT NULL,
  `admin_response` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `responded_by_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `main_feedback`
--

INSERT INTO `main_feedback` (`id`, `name`, `email`, `subject`, `message`, `status`, `admin_response`, `created_at`, `updated_at`, `responded_by_id`, `user_id`) VALUES
(2, 'Test', 'test@gmail.com', 'technical', 'asdglhjk', 'closed', '', '2025-10-30 10:45:18.931931', '2025-10-30 10:50:28.033426', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `main_material`
--

CREATE TABLE `main_material` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `description` longtext NOT NULL,
  `difficulty` varchar(12) NOT NULL,
  `reading_time` int UNSIGNED NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `views_count` int UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `category_id` bigint NOT NULL
) ;

--
-- Dumping data for table `main_material`
--

INSERT INTO `main_material` (`id`, `title`, `content`, `description`, `difficulty`, `reading_time`, `is_published`, `views_count`, `created_at`, `updated_at`, `author_id`, `category_id`) VALUES
(7, 'Введение в Android Studio', '\n# Введение в Android Studio\n\nAndroid Studio - это официальная интегрированная среда разработки (IDE) для разработки Android-приложений. Она основана на IntelliJ IDEA и предоставляет все необходимые инструменты для создания, тестирования и отладки приложений.\n\n## Основные возможности\n\n- **Визуальный редактор макетов** - позволяет создавать пользовательские интерфейсы с помощью drag-and-drop\n- **Эмулятор Android** - для тестирования приложений на различных устройствах\n- **Профилировщик производительности** - для оптимизации приложений\n- **Интеграция с Git** - для управления версиями кода\n\n## Установка\n\n1. Скачайте Android Studio с официального сайта\n2. Установите JDK 8 или выше\n3. Запустите установщик и следуйте инструкциям\n4. При первом запуске установите Android SDK\n\n## Создание первого проекта\n\n1. Откройте Android Studio\n2. Выберите \"Create New Project\"\n3. Выберите шаблон \"Empty Activity\"\n4. Укажите название проекта и пакет\n5. Нажмите \"Finish\"\n    ', 'Изучите основы работы с Android Studio - основной IDE для разработки Android-приложений', 'beginner', 15, 1, 1, '2025-10-29 09:35:36.596433', '2025-10-29 09:44:39.496429', 6, 2),
(8, 'Основы Swift для iOS', '\n# Основы Swift для iOS\n\nSwift - это современный язык программирования от Apple, специально разработанный для создания приложений для iOS, macOS, watchOS и tvOS.\n\n## Основные особенности Swift\n\n- **Безопасность** - предотвращает ошибки во время компиляции\n- **Производительность** - быстрее Objective-C\n- **Читаемость** - синтаксис близок к естественному языку\n- **Интерактивность** - Playgrounds для быстрого прототипирования\n\n## Переменные и константы\n\n```swift\nvar name = \"Иван\"  // Переменная\nlet age = 25       // Константа\n```\n\n## Функции\n\n```swift\nfunc greet(name: String) -> String {\n    return \"Привет, \\(name)!\"\n}\n```\n\n## Классы и структуры\n\n```swift\nclass Person {\n    var name: String\n    var age: Int\n    \n    init(name: String, age: Int) {\n        self.name = name\n        self.age = age\n    }\n}\n```\n\n## Опциональные типы\n\n```swift\nvar optionalName: String? = \"Иван\"\nif let name = optionalName {\n    print(\"Имя: \\(name)\")\n}\n```\n    ', 'Изучите основы языка Swift для разработки iOS-приложений', 'beginner', 20, 1, 3, '2025-10-29 09:35:36.599638', '2025-10-29 09:43:40.367924', 6, 3),
(9, 'Flutter: Первые шаги', '\n# Flutter: Первые шаги\n\nFlutter - это UI-фреймворк от Google для создания нативных приложений для мобильных, веб и десктопных платформ из единой кодовой базы.\n\n## Преимущества Flutter\n\n- **Единая кодовая база** - один код для всех платформ\n- **Высокая производительность** - компиляция в нативный код\n- **Богатые виджеты** - множество готовых компонентов\n- **Горячая перезагрузка** - мгновенное обновление UI\n\n## Установка Flutter\n\n1. Скачайте Flutter SDK\n2. Распакуйте в папку (например, C:\\\\flutter)\n3. Добавьте путь в переменную PATH\n4. Запустите `flutter doctor` для проверки\n\n## Создание проекта\n\n```bash\nflutter create my_app\ncd my_app\nflutter run\n```\n\n## Основная структура\n\n```dart\nimport \'package:flutter/material.dart\';\n\nvoid main() {\n  runApp(MyApp());\n}\n\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      title: \'Flutter Demo\',\n      home: MyHomePage(),\n    );\n  }\n}\n```\n\n## Виджеты\n\nFlutter использует виджеты для построения UI:\n\n```dart\nclass MyHomePage extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      appBar: AppBar(title: Text(\'Мое приложение\')),\n      body: Center(\n        child: Text(\'Привет, Flutter!\'),\n      ),\n    );\n  }\n}\n```\n    ', 'Начните изучение Flutter - современного фреймворка для кроссплатформенной разработки', 'beginner', 25, 1, 17, '2025-10-29 09:35:36.601782', '2025-10-30 14:01:08.302165', 6, 5),
(10, 'Архитектурные паттерны в мобильной разработке', 'В современной мобильной разработке важно следовать архитектурным паттернам для создания масштабируемых и поддерживаемых приложений.\n\n## Основные архитектурные паттерны:\n\n### MVC (Model-View-Controller)\nТрадиционный паттерн, разделяющий приложение на три компонента:\n- **Model**: Данные и бизнес-логика\n- **View**: Пользовательский интерфейс\n- **Controller**: Посредник между Model и View\n\n### MVP (Model-View-Presenter)\nУлучшенная версия MVC:\n- **Model**: Хранение данных\n- **View**: Пассивный UI компонент\n- **Presenter**: Логика представления\n\n### MVVM (Model-View-ViewModel)\nСовременный паттерн, популярный в Android и iOS:\n- **Model**: Данные и бизнес-логика\n- **View**: UI компоненты\n- **ViewModel**: Связь между View и Model с реактивными данными\n\n### Clean Architecture\nМногослойная архитектура:\n- **Presentation Layer**: UI и ViewModels\n- **Domain Layer**: Бизнес-логика и Use Cases\n- **Data Layer**: Репозитории и источники данных\n\n## Преимущества использования паттернов:\n- Упрощение тестирования\n- Улучшение читаемости кода\n- Разделение ответственности\n- Упрощение поддержки и расширения', 'Изучение основных архитектурных паттернов для создания качественных мобильных приложений.', 'intermediate', 90, 1, 1, '2025-10-31 08:40:18.298509', '2025-10-31 08:41:14.741058', 7, 1),
(11, 'UI/UX дизайн для мобильных приложений', 'Создание удобного и красивого интерфейса — ключевой аспект успешного мобильного приложения.\n\n## Принципы мобильного дизайна:\n\n### 1. Простота и ясность\n- Минималистичный дизайн\n- Четкая навигация\n- Интуитивно понятные элементы\n\n### 2. Адаптивность\n- Разные размеры экранов\n- Портретная и альбомная ориентации\n- Поддержка планшетов\n\n### 3. Производительность\n- Быстрая загрузка\n- Плавные анимации\n- Оптимизация изображений\n\n### 4. Доступность\n- Поддержка крупного шрифта\n- Контрастные цвета\n- Навигация без мыши\n\n## Material Design (Android)\n- Система дизайна от Google\n- Согласованные компоненты\n- Анимации и переходы\n- Темная и светлая темы\n\n## Human Interface Guidelines (iOS)\n- Стандарты Apple для дизайна\n- Нативные паттерны iOS\n- Консистентность интерфейса\n- Использование системных компонентов\n\n## Инструменты дизайна:\n- Figma — популярный редактор\n- Sketch — дизайн для Mac\n- Adobe XD — UI/UX дизайн\n- InVision — прототипирование\n\n## Best Practices:\n- Используйте системные шрифты\n- Следуйте гайдлайнам платформы\n- Тестируйте на реальных устройствах\n- Получайте обратную связь от пользователей', 'Основы создания удобного и красивого пользовательского интерфейса для мобильных приложений.', 'beginner', 60, 1, 1, '2025-10-31 08:40:31.219205', '2025-10-31 08:41:00.390183', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `main_materialfile`
--

CREATE TABLE `main_materialfile` (
  `id` bigint NOT NULL,
  `file` varchar(100) NOT NULL,
  `name` varchar(200) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `material_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `main_materialprogress`
--

CREATE TABLE `main_materialprogress` (
  `id` bigint NOT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `progress_percentage` int UNSIGNED NOT NULL,
  `last_read_at` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `material_id` bigint NOT NULL,
  `user_id` int NOT NULL
) ;

--
-- Dumping data for table `main_materialprogress`
--

INSERT INTO `main_materialprogress` (`id`, `is_completed`, `progress_percentage`, `last_read_at`, `created_at`, `material_id`, `user_id`) VALUES
(1, 1, 100, '2025-10-29 09:49:25.480805', '2025-10-29 09:45:49.498771', 9, 4),
(2, 0, 0, '2025-10-30 12:33:16.413634', '2025-10-30 12:33:16.407805', 9, 6),
(3, 0, 0, '2025-10-30 13:56:21.388261', '2025-10-30 13:56:21.384178', 9, 5),
(4, 0, 0, '2025-10-31 08:41:00.386085', '2025-10-31 08:41:00.381656', 11, 6),
(5, 0, 0, '2025-10-31 08:41:14.735987', '2025-10-31 08:41:14.730685', 10, 6);

-- --------------------------------------------------------

--
-- Table structure for table `main_notification`
--

CREATE TABLE `main_notification` (
  `id` bigint NOT NULL,
  `type` varchar(10) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `related_object_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `main_profile`
--

CREATE TABLE `main_profile` (
  `id` bigint NOT NULL,
  `role` varchar(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `bio` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `main_profile`
--

INSERT INTO `main_profile` (`id`, `role`, `phone`, `avatar`, `bio`, `created_at`, `updated_at`, `user_id`) VALUES
(3, 'student', '', '', '', '2025-10-29 09:17:52.571449', '2025-10-30 09:44:44.806074', 4),
(4, 'teacher', '', '', '', '2025-10-29 09:17:53.215009', '2025-10-30 09:45:35.351655', 5),
(5, 'admin', '', '', '', '2025-10-29 09:17:53.819542', '2025-10-30 12:39:27.571462', 6);

-- --------------------------------------------------------

--
-- Table structure for table `main_question`
--

CREATE TABLE `main_question` (
  `id` bigint NOT NULL,
  `question_text` longtext NOT NULL,
  `question_type` varchar(10) NOT NULL,
  `points` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NOT NULL,
  `test_id` bigint NOT NULL
) ;

--
-- Dumping data for table `main_question`
--

INSERT INTO `main_question` (`id`, `question_text`, `question_type`, `points`, `order`, `test_id`) VALUES
(24, 'Что такое MVC?', 'single', 1, 1, 7),
(25, 'Какой паттерн разделяет бизнес-логику и UI?', 'single', 1, 2, 7),
(26, 'Что делает Presenter в MVP?', 'single', 1, 3, 7),
(27, 'Что делает Router?', 'single', 1, 4, 7),
(28, 'Что такое Clean Architecture?', 'single', 1, 5, 7),
(29, 'Что такое wireframe?', 'single', 1, 1, 8),
(30, 'Для чего используют user persona?', 'single', 1, 2, 8),
(31, 'Что означает UX?', 'single', 1, 3, 8),
(32, 'Что такое UI kit?', 'single', 1, 4, 8),
(33, 'Главный принцип мобильного UI?', 'single', 1, 5, 8),
(34, 'На каком языке пишут под Flutter?', 'single', 1, 1, 9),
(35, 'Что такое widget?', 'single', 1, 2, 9),
(36, 'Какой файл запускает Flutter-приложение?', 'single', 1, 3, 9),
(37, 'Какой менеджер пакетов используется?', 'single', 1, 4, 9),
(38, 'Что такое hot reload?', 'single', 1, 5, 9),
(39, 'Как объявить переменную?', 'single', 1, 1, 10),
(40, 'Что такое тип Int?', 'single', 1, 2, 10),
(41, 'Что делает оператор guard?', 'single', 1, 3, 10),
(42, 'Что такое optional?', 'single', 1, 4, 10),
(43, 'Как создать массив?', 'single', 1, 5, 10),
(44, 'На каком языке можно писать Android-приложения?', 'single', 1, 1, 11),
(45, 'Что такое Activity?', 'single', 1, 2, 11),
(46, 'Где хранят ресурсы?', 'single', 1, 3, 11),
(47, 'Как запускается приложение?', 'single', 1, 4, 11),
(48, 'Что такое XML layout?', 'single', 1, 5, 11);

-- --------------------------------------------------------

--
-- Table structure for table `main_test`
--

CREATE TABLE `main_test` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `difficulty` varchar(12) NOT NULL,
  `time_limit` int UNSIGNED NOT NULL,
  `passing_score` int UNSIGNED NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `attempts_count` int UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `category_id` bigint NOT NULL
) ;

--
-- Dumping data for table `main_test`
--

INSERT INTO `main_test` (`id`, `title`, `description`, `difficulty`, `time_limit`, `passing_score`, `is_published`, `attempts_count`, `created_at`, `updated_at`, `author_id`, `category_id`) VALUES
(7, 'Архитектурные паттерны в мобильной разработке', 'Тест по архитектурным паттернам в мобильной разработке', 'beginner', 15, 70, 1, 0, '2025-10-31 08:47:03.944158', '2025-10-31 08:47:33.590786', 6, 1),
(8, 'UI/UX дизайн для мобильных приложений', 'Тест по UI/UX дизайну для мобильных приложений', 'beginner', 15, 70, 1, 0, '2025-10-31 08:47:58.688183', '2025-10-31 08:48:11.552965', 6, 1),
(9, 'Flutter: Первые шаги', 'Тест по первым шагам Flutter', 'beginner', 15, 70, 1, 0, '2025-10-31 08:48:45.719850', '2025-10-31 08:49:00.107071', 6, 5),
(10, 'Основы Swift для iOS', 'Тест по основам Swift', 'beginner', 15, 70, 1, 0, '2025-10-31 08:49:21.259615', '2025-10-31 08:49:40.119525', 6, 3),
(11, 'Введение в Android Studio', 'Тест по основам Android Studio', 'beginner', 15, 70, 1, 0, '2025-10-31 08:50:01.252377', '2025-10-31 08:50:14.848530', 6, 2);

-- --------------------------------------------------------

--
-- Table structure for table `main_testattempt`
--

CREATE TABLE `main_testattempt` (
  `id` bigint NOT NULL,
  `score` int UNSIGNED NOT NULL,
  `max_score` int UNSIGNED NOT NULL,
  `percentage` double NOT NULL,
  `is_passed` tinyint(1) NOT NULL,
  `started_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `time_spent` int UNSIGNED NOT NULL,
  `test_id` bigint NOT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `main_useranswer`
--

CREATE TABLE `main_useranswer` (
  `id` bigint NOT NULL,
  `text_answer` longtext NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `points_earned` int UNSIGNED NOT NULL,
  `attempt_id` bigint NOT NULL,
  `question_id` bigint NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `main_useranswer_selected_answers`
--

CREATE TABLE `main_useranswer_selected_answers` (
  `id` bigint NOT NULL,
  `useranswer_id` bigint NOT NULL,
  `answer_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `main_answer`
--
ALTER TABLE `main_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_answer_question_id_96405437_fk_main_question_id` (`question_id`);

--
-- Indexes for table `main_category`
--
ALTER TABLE `main_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `main_feedback`
--
ALTER TABLE `main_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_feedback_responded_by_id_7426bd25_fk_auth_user_id` (`responded_by_id`),
  ADD KEY `main_feedback_user_id_4bc6db52_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `main_material`
--
ALTER TABLE `main_material`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_material_author_id_de477d44_fk_auth_user_id` (`author_id`),
  ADD KEY `main_material_category_id_ef4894fd_fk_main_category_id` (`category_id`);

--
-- Indexes for table `main_materialfile`
--
ALTER TABLE `main_materialfile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_materialfile_material_id_dcf44dc7_fk_main_material_id` (`material_id`);

--
-- Indexes for table `main_materialprogress`
--
ALTER TABLE `main_materialprogress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main_materialprogress_user_id_material_id_40505013_uniq` (`user_id`,`material_id`),
  ADD KEY `main_materialprogress_material_id_68eee862_fk_main_material_id` (`material_id`);

--
-- Indexes for table `main_notification`
--
ALTER TABLE `main_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_notification_user_id_8efbf76d_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `main_profile`
--
ALTER TABLE `main_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `main_question`
--
ALTER TABLE `main_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_question_test_id_3ff0a13c_fk_main_test_id` (`test_id`);

--
-- Indexes for table `main_test`
--
ALTER TABLE `main_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_test_author_id_727df691_fk_auth_user_id` (`author_id`),
  ADD KEY `main_test_category_id_f400e060_fk_main_category_id` (`category_id`);

--
-- Indexes for table `main_testattempt`
--
ALTER TABLE `main_testattempt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_testattempt_test_id_4f25a7fd_fk_main_test_id` (`test_id`),
  ADD KEY `main_testattempt_user_id_d0d06a38_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `main_useranswer`
--
ALTER TABLE `main_useranswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_useranswer_attempt_id_3a35983b_fk_main_testattempt_id` (`attempt_id`),
  ADD KEY `main_useranswer_question_id_09dbd9d3_fk_main_question_id` (`question_id`);

--
-- Indexes for table `main_useranswer_selected_answers`
--
ALTER TABLE `main_useranswer_selected_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main_useranswer_selected_useranswer_id_answer_id_07fab992_uniq` (`useranswer_id`,`answer_id`),
  ADD KEY `main_useranswer_sele_answer_id_e5692980_fk_main_answ` (`answer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `main_answer`
--
ALTER TABLE `main_answer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_category`
--
ALTER TABLE `main_category`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `main_feedback`
--
ALTER TABLE `main_feedback`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `main_material`
--
ALTER TABLE `main_material`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_materialfile`
--
ALTER TABLE `main_materialfile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_materialprogress`
--
ALTER TABLE `main_materialprogress`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_notification`
--
ALTER TABLE `main_notification`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_profile`
--
ALTER TABLE `main_profile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `main_question`
--
ALTER TABLE `main_question`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_test`
--
ALTER TABLE `main_test`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_testattempt`
--
ALTER TABLE `main_testattempt`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_useranswer`
--
ALTER TABLE `main_useranswer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_useranswer_selected_answers`
--
ALTER TABLE `main_useranswer_selected_answers`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_answer`
--
ALTER TABLE `main_answer`
  ADD CONSTRAINT `main_answer_question_id_96405437_fk_main_question_id` FOREIGN KEY (`question_id`) REFERENCES `main_question` (`id`);

--
-- Constraints for table `main_feedback`
--
ALTER TABLE `main_feedback`
  ADD CONSTRAINT `main_feedback_responded_by_id_7426bd25_fk_auth_user_id` FOREIGN KEY (`responded_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `main_feedback_user_id_4bc6db52_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_material`
--
ALTER TABLE `main_material`
  ADD CONSTRAINT `main_material_author_id_de477d44_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `main_material_category_id_ef4894fd_fk_main_category_id` FOREIGN KEY (`category_id`) REFERENCES `main_category` (`id`);

--
-- Constraints for table `main_materialfile`
--
ALTER TABLE `main_materialfile`
  ADD CONSTRAINT `main_materialfile_material_id_dcf44dc7_fk_main_material_id` FOREIGN KEY (`material_id`) REFERENCES `main_material` (`id`);

--
-- Constraints for table `main_materialprogress`
--
ALTER TABLE `main_materialprogress`
  ADD CONSTRAINT `main_materialprogress_material_id_68eee862_fk_main_material_id` FOREIGN KEY (`material_id`) REFERENCES `main_material` (`id`),
  ADD CONSTRAINT `main_materialprogress_user_id_e03ad2a8_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_notification`
--
ALTER TABLE `main_notification`
  ADD CONSTRAINT `main_notification_user_id_8efbf76d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_profile`
--
ALTER TABLE `main_profile`
  ADD CONSTRAINT `main_profile_user_id_b40d720a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_question`
--
ALTER TABLE `main_question`
  ADD CONSTRAINT `main_question_test_id_3ff0a13c_fk_main_test_id` FOREIGN KEY (`test_id`) REFERENCES `main_test` (`id`);

--
-- Constraints for table `main_test`
--
ALTER TABLE `main_test`
  ADD CONSTRAINT `main_test_author_id_727df691_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `main_test_category_id_f400e060_fk_main_category_id` FOREIGN KEY (`category_id`) REFERENCES `main_category` (`id`);

--
-- Constraints for table `main_testattempt`
--
ALTER TABLE `main_testattempt`
  ADD CONSTRAINT `main_testattempt_test_id_4f25a7fd_fk_main_test_id` FOREIGN KEY (`test_id`) REFERENCES `main_test` (`id`),
  ADD CONSTRAINT `main_testattempt_user_id_d0d06a38_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `main_useranswer`
--
ALTER TABLE `main_useranswer`
  ADD CONSTRAINT `main_useranswer_attempt_id_3a35983b_fk_main_testattempt_id` FOREIGN KEY (`attempt_id`) REFERENCES `main_testattempt` (`id`),
  ADD CONSTRAINT `main_useranswer_question_id_09dbd9d3_fk_main_question_id` FOREIGN KEY (`question_id`) REFERENCES `main_question` (`id`);

--
-- Constraints for table `main_useranswer_selected_answers`
--
ALTER TABLE `main_useranswer_selected_answers`
  ADD CONSTRAINT `main_useranswer_sele_answer_id_e5692980_fk_main_answ` FOREIGN KEY (`answer_id`) REFERENCES `main_answer` (`id`),
  ADD CONSTRAINT `main_useranswer_sele_useranswer_id_31ed71de_fk_main_user` FOREIGN KEY (`useranswer_id`) REFERENCES `main_useranswer` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
