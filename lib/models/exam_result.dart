class ExamResult {
  final int id;
  final int examId;
  final int userId;
  final int score;
  final int correctAnswers;
  final int wrongAnswers;
  final int unanswered;
  final DateTime completedAt;
  final int timeTaken; // in seconds
  
  ExamResult({
    required this.id,
    required this.examId,
    required this.userId,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unanswered,
    required this.completedAt,
    required this.timeTaken,
  });
  
  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      id: json['id'] as int,
      examId: json['exam_id'] as int,
      userId: json['user_id'] as int,
      score: json['score'] as int,
      correctAnswers: json['correct_answers'] as int,
      wrongAnswers: json['wrong_answers'] as int,
      unanswered: json['unanswered'] as int,
      completedAt: DateTime.parse(json['completed_at'] as String),
      timeTaken: json['time_taken'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_id': examId,
      'user_id': userId,
      'score': score,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'unanswered': unanswered,
      'completed_at': completedAt.toIso8601String(),
      'time_taken': timeTaken,
    };
  }
  
  double get percentage {
    final total = correctAnswers + wrongAnswers + unanswered;
    if (total == 0) return 0;
    return (correctAnswers / total) * 100;
  }
}
