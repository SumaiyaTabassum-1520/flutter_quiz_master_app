import 'package:flutter/material.dart';
import 'storage_service.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoaded = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLoaded => _isLoaded;

  Future<void> loadTheme() async {
    final isDark = await StorageService.instance.getIsDarkMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    await StorageService.instance.setIsDarkMode(_themeMode == ThemeMode.dark);
  }
}
