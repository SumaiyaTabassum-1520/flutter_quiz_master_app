import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes/app_router.dart';
import 'services/theme_controller.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuizMasterApp());
}

class QuizMasterApp extends StatefulWidget {
  const QuizMasterApp({super.key});

  @override
  State<QuizMasterApp> createState() => _QuizMasterAppState();
}

class _QuizMasterAppState extends State<QuizMasterApp> {
  final ThemeController _themeController = ThemeController();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildAppRouter(_themeController);
    _themeController.loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Quiz Master',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _themeController.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
