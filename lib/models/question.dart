// Enum untuk tipe soal
enum QuestionType {
  multipleChoice,
  fillInBlank,
}

class Question {
  final String id;
  final String examId;
  final String text;
  final QuestionType type;
  final List<String>? options; // Untuk pilihan ganda
  final String correctAnswer; // Jawaban yang benar
  final String? explanation;
  final String? imageUrl;
  final int points;
  
  Question({
    required this.id,
    required this.examId,
    required this.text,
    required this.type,
    this.options,
    required this.correctAnswer,
    this.explanation,
    this.imageUrl,
    this.points = 10,
  });
  
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      examId: json['exam_id'].toString(),
      text: json['text'] as String,
      type: json['type'] == 'fill_in_blank' 
          ? QuestionType.fillInBlank 
          : QuestionType.multipleChoice,
      options: json['options'] != null 
          ? (json['options'] as List).cast<String>() 
          : null,
      correctAnswer: json['correct_answer'] as String,
      explanation: json['explanation'] as String?,
      imageUrl: json['image_url'] as String?,
      points: json['points'] as int? ?? 10,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_id': examId,
      'text': text,
      'type': type == QuestionType.fillInBlank ? 'fill_in_blank' : 'multiple_choice',
      'options': options,
      'correct_answer': correctAnswer,
      'explanation': explanation,
      'image_url': imageUrl,
      'points': points,
    };
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exam_id': examId,
      'text': text,
      'type': type == QuestionType.fillInBlank ? 'fill_in_blank' : 'multiple_choice',
      'options': options?.join('|||'), // Store as delimited string
      'correct_answer': correctAnswer,
      'explanation': explanation,
      'image_url': imageUrl,
      'points': points,
    };
  }
  
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'].toString(),
      examId: map['exam_id'].toString(),
      text: map['text'] as String,
      type: map['type'] == 'fill_in_blank' 
          ? QuestionType.fillInBlank 
          : QuestionType.multipleChoice,
      options: map['options'] != null 
          ? (map['options'] as String).split('|||') 
          : null,
      correctAnswer: map['correct_answer'] as String,
      explanation: map['explanation'] as String?,
      imageUrl: map['image_url'] as String?,
      points: map['points'] as int? ?? 10,
    );
  }
  
  // Backward compatibility getters
  String get questionText => text;
  int get correctAnswerIndex => options?.indexOf(correctAnswer) ?? -1;
}

