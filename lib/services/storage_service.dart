import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_result.dart';

/// Centralized local-storage layer built on top of SharedPreferences.
///
/// Handles:
///  - Theme mode persistence
///  - Aggregate statistics (total attempts, highest score, last score)
///  - Last 10 quiz results (history), newest first
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  static const _keyThemeIsDark = 'theme_is_dark';
  static const _keyTotalAttempts = 'stat_total_attempts';
  static const _keyHighestScore = 'stat_highest_score'; // stored as percentage*10 for easy compare
  static const _keyHighestScoreLabel = 'stat_highest_score_label';
  static const _keyLastScoreLabel = 'stat_last_score_label';
  static const _keyHistory = 'quiz_history'; // JSON-encoded list of QuizResult
  static const int _maxHistory = 10;

  // ---------------- Theme ----------------

  Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyThemeIsDark) ?? false;
  }

  Future<void> setIsDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeIsDark, isDark);
  }

  // ---------------- Statistics ----------------

  Future<int> getTotalAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalAttempts) ?? 0;
  }

  Future<String?> getHighestScoreLabel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyHighestScoreLabel);
  }

  Future<String?> getLastScoreLabel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastScoreLabel);
  }

  /// Call this once a quiz finishes. Updates attempts, highest score,
  /// last score, and prepends the result to the history list.
  Future<void> recordQuizResult(QuizResult result) async {
    final prefs = await SharedPreferences.getInstance();

    // Total attempts
    final attempts = (prefs.getInt(_keyTotalAttempts) ?? 0) + 1;
    await prefs.setInt(_keyTotalAttempts, attempts);

    // Last score
    await prefs.setString(_keyLastScoreLabel, result.scoreLabel);

    // Highest score — compare by percentage stored as int*10 to avoid float precision issues.
    final newScoreValue = (result.percentage * 10).round();
    final currentHighest = prefs.getInt(_keyHighestScore) ?? -1;
    if (newScoreValue > currentHighest) {
      await prefs.setInt(_keyHighestScore, newScoreValue);
      await prefs.setString(_keyHighestScoreLabel, result.scoreLabel);
    }

    // History (newest first, capped at _maxHistory)
    final history = await getHistory();
    history.insert(0, result);
    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }
    final encoded = jsonEncode(history.map((r) => r.toJson()).toList());
    await prefs.setString(_keyHistory, encoded);
  }

  Future<List<QuizResult>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyHistory);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => QuizResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Useful for testing / a "reset progress" feature.
  Future<void> clearAllStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTotalAttempts);
    await prefs.remove(_keyHighestScore);
    await prefs.remove(_keyHighestScoreLabel);
    await prefs.remove(_keyLastScoreLabel);
    await prefs.remove(_keyHistory);
  }
}
