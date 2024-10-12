import 'package:flutter/material.dart';
import 'package:recruitment_test_website/core/services/routes/routes.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/congratulation_page.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/quiz_page.dart';
import 'package:recruitment_test_website/features/recruitment_sessions/presentation/pages/recruitment_session_page.dart';

class RouteGenerator {
  static void get controller {}

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.recruitment:
        return MaterialPageRoute(
          builder: (_) => const RecruitmentSessionsPage(),
        );
      case Routes.quiz:
        final Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => QuizPage(
            duration: arguments['duration'] as int,
            sessionId: arguments['sessionId'] as String,
            userId: arguments['userId'] as String,
          ),
        );

      case Routes.congratulation:
        return MaterialPageRoute(
          builder: (_) => const CongratulationPage(),
        );

      default:
        return null;
    }
  }
}
