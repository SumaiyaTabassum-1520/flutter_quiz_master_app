import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_data.dart';
import '../models/quiz_category.dart';
import '../widgets/option_tile.dart';

class QuizScreen extends StatefulWidget {
  final String categoryId;

  const QuizScreen({super.key, required this.categoryId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizCategory category;
  int _currentIndex = 0;
  int? _selectedOption;
  int _correctCount = 0;

  static const _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    category = QuizData.byId(widget.categoryId);
  }

  bool get _isLastQuestion => _currentIndex == category.questions.length - 1;

  void _selectOption(int index) {
    setState(() => _selectedOption = index);
  }

  void _goNext() {
    final question = category.questions[_currentIndex];
    if (_selectedOption != null && question.isCorrect(_selectedOption!)) {
      _correctCount++;
    }

    if (_isLastQuestion) {
      // Navigate to result screen, replacing the quiz screen so the user
      // can't go "back" into a finished quiz.
      context.pushReplacement(
        '/result',
        extra: {
          'categoryId': category.id,
          'categoryName': category.name,
          'total': category.questions.length,
          'correct': _correctCount,
        },
      );
    } else {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = category.questions[_currentIndex];
    final progress = (_currentIndex + 1) / category.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.name}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question counter
              Text(
                'Question ${_currentIndex + 1} of ${category.questions.length}',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Progress indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                ),
              ),
              const SizedBox(height: 24),

              // Question card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  question.questionText,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 19),
                ),
              ),
              const SizedBox(height: 20),

              // Options
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    return OptionTile(
                      label: _optionLabels[i],
                      optionText: question.options[i],
                      isSelected: _selectedOption == i,
                      onTap: () => _selectOption(i),
                    );
                  },
                ),
              ),

              // Navigation button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedOption == null ? null : _goNext,
                  child: Text(_isLastQuestion ? 'Finish' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
