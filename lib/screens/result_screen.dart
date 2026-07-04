import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/quiz_result.dart';
import '../services/storage_service.dart';

class ResultScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final int total;
  final int correct;

  const ResultScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.total,
    required this.correct,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final QuizResult result;

  @override
  void initState() {
    super.initState();
    result = QuizResult(
      categoryName: widget.categoryName,
      totalQuestions: widget.total,
      correctAnswers: widget.correct,
      playedAt: DateTime.now(),
    );
    // Persist the result as soon as this screen is shown.
    StorageService.instance.recordQuizResult(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = result.percentage;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              _ScoreRing(percentage: percentage, scoreLabel: result.scoreLabel),
              const SizedBox(height: 8),
              Text(
                _resultMessage(percentage),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _metricRow(theme, 'Total Questions', '${result.totalQuestions}'),
                    const Divider(height: 24),
                    _metricRow(theme, 'Correct Answers', '${result.correctAnswers}',
                        color: const Color(0xFF00B894)),
                    const Divider(height: 24),
                    _metricRow(theme, 'Wrong Answers', '${result.wrongAnswers}',
                        color: const Color(0xFFE17055)),
                    const Divider(height: 24),
                    _metricRow(theme, 'Final Score', result.scoreLabel),
                    const Divider(height: 24),
                    _metricRow(theme, 'Percentage', '${percentage.toStringAsFixed(0)}%'),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pushReplacement('/quiz/${widget.categoryId}'),
                  child: const Text('Play Again'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Back To Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _resultMessage(double percentage) {
    if (percentage == 100) return 'Perfect score! 🏆';
    if (percentage >= 80) return 'Excellent work! 🎉';
    if (percentage >= 50) return 'Good effort! Keep practicing 👍';
    return "Don't give up, try again! 💪";
  }

  Widget _metricRow(ThemeData theme, String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _ScoreRing extends StatelessWidget {
  final double percentage;
  final String scoreLabel;

  const _ScoreRing({required this.percentage, required this.scoreLabel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 12,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(scoreLabel, style: theme.textTheme.headlineSmall),
              Text('${percentage.toStringAsFixed(0)}%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
