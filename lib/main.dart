import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_info_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/my_classes_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/materials_list_screen.dart';
import 'screens/material_detail_screen.dart';
import 'screens/class_detail_screen.dart';
import 'screens/assignment_submission_screen.dart';
import 'screens/assignments_quizzes_list_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/quiz_results_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/grades_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/announcements_list_screen.dart';
import 'screens/announcement_detail_screen.dart';
import 'screens/video_player_screen.dart';

void main() {
  runApp(const LMSApp());
}

class LMSApp extends StatelessWidget {
  const LMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F), // Red
          primary: const Color(0xFFD32F2F),
          secondary: Colors.white,
          surface: Colors.grey[50]!,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login-info': (context) => const LoginInfoScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/my-classes': (context) => const MyClassesScreen(),
        '/grades': (context) => const GradesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/assignment-submission': (context) =>
            const AssignmentSubmissionScreen(),
        '/assignments-quizzes': (context) =>
            const AssignmentsQuizzesListScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/announcements': (context) => const AnnouncementsListScreen(),
        '/announcement-detail': (context) => const AnnouncementDetailScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/class-detail') {
          final args = settings.arguments as String?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => ClassDetailScreen(courseId: args),
            );
          }
        }

        if (settings.name == '/course-detail') {
          final courseId = settings.arguments as String?;
          if (courseId != null) {
            return MaterialPageRoute(
              builder: (context) => CourseDetailScreen(courseId: courseId),
            );
          }
        }

        if (settings.name == '/materials-list') {
          final args = settings.arguments as Map<String, String>?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => MaterialsListScreen(
                courseId: args['courseId']!,
                moduleId: args['moduleId']!,
              ),
            );
          }
        }

        if (settings.name == '/material-detail') {
          final materialId = settings.arguments as String?;
          if (materialId != null) {
            return MaterialPageRoute(
              builder: (context) =>
                  MaterialDetailScreen(materialId: materialId),
            );
          }
        }

        if (settings.name == '/assignment-submission') {
          final assignmentId = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) =>
                AssignmentSubmissionScreen(assignmentId: assignmentId),
          );
        }

        if (settings.name == '/quiz-results') {
          final quizId = settings.arguments as String?;
          if (quizId != null) {
            return MaterialPageRoute(
              builder: (context) => QuizResultsScreen(quizId: quizId),
            );
          }
        }

        if (settings.name == '/video-player') {
          final videoId = settings.arguments as String?;
          if (videoId != null) {
            return MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoId: videoId),
            );
          }
        }

        return null;
      },
    );
  }
}
