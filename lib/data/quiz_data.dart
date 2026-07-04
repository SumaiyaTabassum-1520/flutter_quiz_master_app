import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

/// All quiz content lives locally in this file (per assignment note:
/// "Don't use api, handle it locally"). No network calls are made.
class QuizData {
  QuizData._();

  static final List<QuizCategory> categories = [
    QuizCategory(
      id: 'sports',
      name: 'Sports',
      emoji: '🏀',
      icon: Icons.sports_basketball_rounded,
      color: const Color(0xFFE17055),
      questions: const [
        Question(
          questionText: 'Which country won the FIFA World Cup in 2022?',
          options: ['Brazil', 'France', 'Argentina', 'Germany'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'How many players are on a basketball court per team?',
          options: ['4', '5', '6', '7'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'In tennis, what is a score of zero called?',
          options: ['Nil', 'Love', 'Duck', 'Zero'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'Which sport uses terms like "birdie" and "eagle"?',
          options: ['Golf', 'Cricket', 'Badminton', 'Archery'],
          correctIndex: 0,
        ),
        Question(
          questionText: 'How often are the Summer Olympic Games held?',
          options: ['Every 2 years', 'Every 3 years', 'Every 4 years', 'Every 5 years'],
          correctIndex: 2,
        ),
      ],
    ),
    QuizCategory(
      id: 'science',
      name: 'Science',
      emoji: '🔬',
      icon: Icons.science_rounded,
      color: const Color(0xFF00B894),
      questions: const [
        Question(
          questionText: 'What is the chemical symbol for water?',
          options: ['H2O', 'O2', 'CO2', 'HO2'],
          correctIndex: 0,
        ),
        Question(
          questionText: 'Which planet is known as the Red Planet?',
          options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'What gas do plants primarily absorb for photosynthesis?',
          options: ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'What is the powerhouse of the cell?',
          options: ['Nucleus', 'Ribosome', 'Mitochondria', 'Golgi body'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'What force keeps us grounded on Earth?',
          options: ['Magnetism', 'Gravity', 'Friction', 'Tension'],
          correctIndex: 1,
        ),
      ],
    ),
    QuizCategory(
      id: 'technology',
      name: 'Technology',
      emoji: '💻',
      icon: Icons.memory_rounded,
      color: const Color(0xFF0984E3),
      questions: const [
        Question(
          questionText: 'What does "CPU" stand for?',
          options: [
            'Central Processing Unit',
            'Computer Personal Unit',
            'Central Program Utility',
            'Core Processing Unit',
          ],
          correctIndex: 0,
        ),
        Question(
          questionText: 'Which language is primarily used to build Flutter apps?',
          options: ['Java', 'Kotlin', 'Dart', 'Swift'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'What does "HTTP" stand for?',
          options: [
            'HyperText Transfer Protocol',
            'HighText Transmission Process',
            'HyperText Transmission Protocol',
            'HyperTransfer Text Protocol',
          ],
          correctIndex: 0,
        ),
        Question(
          questionText: 'Which company developed the Flutter framework?',
          options: ['Meta', 'Google', 'Microsoft', 'Amazon'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'What does "RAM" stand for?',
          options: [
            'Random Access Memory',
            'Read Access Memory',
            'Random Allocation Module',
            'Rapid Access Memory',
          ],
          correctIndex: 0,
        ),
      ],
    ),
    QuizCategory(
      id: 'history',
      name: 'History',
      emoji: '📜',
      icon: Icons.account_balance_rounded,
      color: const Color(0xFFFDCB6E),
      questions: const [
        Question(
          questionText: 'In which year did World War II end?',
          options: ['1943', '1945', '1947', '1950'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'Who was the first President of the United States?',
          options: ['Thomas Jefferson', 'Abraham Lincoln', 'George Washington', 'John Adams'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'The Great Wall is located in which country?',
          options: ['Japan', 'China', 'India', 'Mongolia'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'Which ancient civilization built the pyramids of Giza?',
          options: ['Romans', 'Greeks', 'Egyptians', 'Mayans'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'Bangladesh gained independence in which year?',
          options: ['1969', '1971', '1975', '1980'],
          correctIndex: 1,
        ),
      ],
    ),
    QuizCategory(
      id: 'gk',
      name: 'General Knowledge',
      emoji: '🧠',
      icon: Icons.psychology_rounded,
      color: const Color(0xFF6C5CE7),
      questions: const [
        Question(
          questionText: 'What is the capital city of Bangladesh?',
          options: ['Chittagong', 'Khulna', 'Dhaka', 'Sylhet'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'Which is the largest ocean on Earth?',
          options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
          correctIndex: 3,
        ),
        Question(
          questionText: 'How many continents are there on Earth?',
          options: ['5', '6', '7', '8'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'Which is the national language of Bangladesh?',
          options: ['English', 'Hindi', 'Bengali', 'Urdu'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'What is the currency of Japan?',
          options: ['Won', 'Yuan', 'Yen', 'Ringgit'],
          correctIndex: 2,
        ),
      ],
    ),
  ];

  static QuizCategory byId(String id) =>
      categories.firstWhere((c) => c.id == id, orElse: () => categories.first);
}
