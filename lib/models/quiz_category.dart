import 'package:flutter/material.dart';
import 'question.dart';

class QuizCategory {
  final String id;
  final String name;
  final String emoji;
  final IconData icon;
  final Color color;
  final List<Question> questions;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.emoji,
    required this.icon,
    required this.color,
    required this.questions,
  });

  int get questionCount => questions.length;
}
