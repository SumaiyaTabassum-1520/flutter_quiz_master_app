class QuizResult {
  final String categoryName;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime playedAt;

  QuizResult({
    required this.categoryName,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.playedAt,
  });

  int get wrongAnswers => totalQuestions - correctAnswers;

  double get percentage =>
      totalQuestions == 0 ? 0 : (correctAnswers / totalQuestions) * 100;

  String get scoreLabel => '$correctAnswers/$totalQuestions';

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'playedAt': playedAt.toIso8601String(),
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        categoryName: json['categoryName'] as String,
        totalQuestions: json['totalQuestions'] as int,
        correctAnswers: json['correctAnswers'] as int,
        playedAt: DateTime.parse(json['playedAt'] as String),
      );
}
