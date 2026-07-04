import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../services/theme_controller.dart';

/// Declarative routing table for the app, built with GoRouter.
///
/// Routes:
///   /                 -> HomeScreen (Dashboard)
///   /quiz/:categoryId -> QuizScreen for the selected category
///   /result           -> ResultScreen (expects an `extra` map with the
///                        quiz outcome; pushed via context.pushReplacement)
GoRouter buildAppRouter(ThemeController themeController) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(themeController: themeController),
      ),
      GoRoute(
        path: '/quiz/:categoryId',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          return QuizScreen(categoryId: categoryId);
        },
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? const {};
          return ResultScreen(
            categoryId: data['categoryId'] as String? ?? '',
            categoryName: data['categoryName'] as String? ?? 'Quiz',
            total: data['total'] as int? ?? 0,
            correct: data['correct'] as int? ?? 0,
          );
        },
      ),
    ],
  );
}
