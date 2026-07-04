import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_data.dart';
import '../models/quiz_result.dart';
import '../services/storage_service.dart';
import '../services/theme_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatefulWidget {
  final ThemeController themeController;

  const HomeScreen({super.key, required this.themeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalAttempts = 0;
  String _highestScore = '--';
  String _lastScore = '--';
  List<QuizResult> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final storage = StorageService.instance;
    final attempts = await storage.getTotalAttempts();
    final highest = await storage.getHighestScoreLabel();
    final last = await storage.getLastScoreLabel();
    final history = await storage.getHistory();
    if (!mounted) return;
    setState(() {
      _totalAttempts = attempts;
      _highestScore = highest ?? '--';
      _lastScore = last ?? '--';
      _history = history;
      _loading = false;
    });
  }

  Future<void> _openCategory(String categoryId) async {
    await context.push('/quiz/$categoryId');
    // Refresh stats when returning from a quiz (result screen -> back to home).
    _loadStats();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Master'),
        actions: [
          AnimatedBuilder(
            animation: widget.themeController,
            builder: (context, _) {
              final isDark = widget.themeController.isDarkMode;
              return IconButton(
                tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                icon: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
                onPressed: () => widget.themeController.toggleTheme(),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStats,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                children: [
                  // Welcome section
                  Text(
                    'Welcome to Quiz Master!',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Test your knowledge and improve your learning skills.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Statistics section
                  Text('Your Statistics', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'Total Attempts',
                          value: '$_totalAttempts',
                          icon: Icons.repeat_rounded,
                          color: const Color(0xFF6C5CE7),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Highest Score',
                          value: _highestScore,
                          icon: Icons.emoji_events_rounded,
                          color: const Color(0xFFFDCB6E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Last Score',
                          value: _lastScore,
                          icon: Icons.history_rounded,
                          color: const Color(0xFF00B894),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Categories section
                  Text('Categories', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...QuizData.categories.map(
                    (cat) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CategoryCard(
                        category: cat,
                        onTap: () => _openCategory(cat.id),
                      ),
                    ),
                  ),

                  // History section
                  const SizedBox(height: 16),
                  Text('Quiz History', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  if (_history.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'No quizzes played yet. Pick a category above to get started!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: List.generate(_history.length, (i) {
                          final r = _history[i];
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      theme.colorScheme.primary.withOpacity(0.12),
                                  child: Text(
                                    '${r.correctAnswers}/${r.totalQuestions}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                title: Text(r.categoryName),
                                subtitle: Text(
                                  '${r.percentage.toStringAsFixed(0)}% • ${_formatDate(r.playedAt)}',
                                ),
                              ),
                              if (i != _history.length - 1)
                                Divider(
                                  height: 1,
                                  indent: 16,
                                  endIndent: 16,
                                  color: theme.dividerColor.withOpacity(0.2),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
