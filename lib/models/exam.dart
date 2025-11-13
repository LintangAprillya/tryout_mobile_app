class Exam {
  final String id;
  final String title;
  final String description;
  final int duration; // in minutes
  final int totalQuestions;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? category;
  final String difficulty;
  final int participants;
  final double rating;
  final bool isFree;
  final int price;
  final String thumbnail;
  
  Exam({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.totalQuestions,
    this.startDate,
    this.endDate,
    this.category,
    this.difficulty = 'Sedang',
    this.participants = 0,
    this.rating = 0.0,
    this.isFree = true,
    this.price = 0,
    this.thumbnail = '📝',
  });

  // Getter untuk compatibility dengan screen baru
  int get questionCount => totalQuestions;
  
  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as int,
      totalQuestions: json['total_questions'] as int,
      startDate: json['start_date'] != null 
          ? DateTime.parse(json['start_date'] as String) 
          : null,
      endDate: json['end_date'] != null 
          ? DateTime.parse(json['end_date'] as String) 
          : null,
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String? ?? 'Sedang',
      participants: json['participants'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isFree: json['is_free'] as bool? ?? true,
      price: json['price'] as int? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '📝',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'total_questions': totalQuestions,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'category': category,
      'difficulty': difficulty,
      'participants': participants,
      'rating': rating,
      'is_free': isFree,
      'price': price,
      'thumbnail': thumbnail,
    };
  }
  
  bool get isActive {
    final now = DateTime.now();
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    return true;
  }
}
