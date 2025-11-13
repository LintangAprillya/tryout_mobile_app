import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../models/question.dart';
import '../models/exam.dart';
import 'exam_result_screen.dart';

class ExamScreen extends StatefulWidget {
  final Exam exam;

  const ExamScreen({
    super.key,
    required this.exam,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int _currentQuestionIndex = 0;
  late Timer _timer;
  late int _remainingSeconds;
  final Map<int, dynamic> _answers = {}; // int index -> String/int answer
  final Map<int, bool> _isMarkedForReview = {};

  // Sample questions - nanti bisa dari API
  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.exam.duration * 60; // Convert to seconds
    _initializeQuestions();
    _startTimer();
  }

  void _initializeQuestions() {
    // Sample questions dengan tipe berbeda
    _questions = [
      Question(
        id: '1',
        examId: widget.exam.id,
        text: 'Berapakah hasil dari 15 × 8 + 12?',
        type: QuestionType.multipleChoice,
        options: ['120', '132', '142', '152'],
        correctAnswer: '132',
        points: 10,
      ),
      Question(
        id: '2',
        examId: widget.exam.id,
        text: 'Ibu kota Indonesia adalah...',
        type: QuestionType.fillInBlank,
        correctAnswer: 'Jakarta',
        points: 10,
      ),
      Question(
        id: '3',
        examId: widget.exam.id,
        text: 'Manakah yang termasuk bahasa pemrograman?',
        type: QuestionType.multipleChoice,
        options: ['Microsoft Word', 'Python', 'Google Chrome', 'Windows'],
        correctAnswer: 'Python',
        points: 10,
      ),
      Question(
        id: '4',
        examId: widget.exam.id,
        text: 'Berapa jumlah provinsi di Indonesia saat ini?',
        type: QuestionType.fillInBlank,
        correctAnswer: '38',
        points: 10,
      ),
      Question(
        id: '5',
        examId: widget.exam.id,
        text: 'Siapa presiden pertama Indonesia?',
        type: QuestionType.fillInBlank,
        correctAnswer: 'Soekarno',
        points: 10,
      ),
      Question(
        id: '6',
        examId: widget.exam.id,
        text: 'Apa kepanjangan dari CPU?',
        type: QuestionType.multipleChoice,
        options: [
          'Central Processing Unit',
          'Computer Personal Unit',
          'Central Program Unit',
          'Computer Processing Unit'
        ],
        correctAnswer: 'Central Processing Unit',
        points: 10,
      ),
      Question(
        id: '7',
        examId: widget.exam.id,
        text: 'Rumus luas lingkaran adalah πr². Jika jari-jari lingkaran adalah 7 cm, berapakah luasnya? (π = 22/7)',
        type: QuestionType.fillInBlank,
        correctAnswer: '154',
        points: 15,
      ),
      Question(
        id: '8',
        examId: widget.exam.id,
        text: 'Bahasa pemrograman apa yang digunakan untuk membuat aplikasi Android?',
        type: QuestionType.multipleChoice,
        options: ['Swift', 'Kotlin', 'Ruby', 'PHP'],
        correctAnswer: 'Kotlin',
        points: 10,
      ),
    ];
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _submitExam();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _saveAnswer(dynamic answer) {
    setState(() {
      _answers[_currentQuestionIndex] = answer;
    });
  }

  void _toggleMarkForReview() {
    setState(() {
      _isMarkedForReview[_currentQuestionIndex] =
          !(_isMarkedForReview[_currentQuestionIndex] ?? false);
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _goToQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
      Navigator.pop(context); // Close question navigator
    });
  }

  void _submitExam() {
    _timer.cancel();
    
    // Calculate score
    int correctAnswers = 0;
    int totalPoints = 0;
    int earnedPoints = 0;

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      totalPoints += question.points;
      
      if (_answers.containsKey(i)) {
        final userAnswer = _answers[i].toString().trim().toLowerCase();
        final correctAnswer = question.correctAnswer.toLowerCase();
        
        if (userAnswer == correctAnswer) {
          correctAnswers++;
          earnedPoints += question.points;
        }
      }
    }

    final score = (earnedPoints / totalPoints * 100).round();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExamResultScreen(
          exam: widget.exam,
          score: score,
          correctAnswers: correctAnswers,
          totalQuestions: _questions.length,
          totalPoints: earnedPoints,
          maxPoints: totalPoints,
          timeTaken: widget.exam.duration * 60 - _remainingSeconds,
          answers: _answers,
          questions: _questions,
        ),
      ),
    );
  }

  void _showSubmitDialog() {
    final answeredCount = _answers.length;
    final unansweredCount = _questions.length - answeredCount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        title: Text(
          'Submit Ujian?',
          style: GoogleFonts.leagueSpartan(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Anda yakin ingin submit ujian?',
              style: GoogleFonts.leagueSpartan(),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Column(
                children: [
                  _buildStatRow('Terjawab', '$answeredCount soal', AppColors.success),
                  if (unansweredCount > 0) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _buildStatRow('Belum dijawab', '$unansweredCount soal', AppColors.error),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  _buildStatRow('Waktu tersisa', _formatTime(_remainingSeconds), AppColors.warning),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: GoogleFonts.leagueSpartan(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitExam();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.leagueSpartan(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmDialog();
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                _buildProgressBar(progress),
                Expanded(
                  child: _buildQuestionCard(currentQuestion),
                ),
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    final isTimeRunningOut = _remainingSeconds < 300; // Less than 5 minutes

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _showExitConfirmDialog,
            icon: const Icon(Icons.close),
            color: AppColors.error,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.exam.title,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Soal ${_currentQuestionIndex + 1} dari ${_questions.length}',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isTimeRunningOut
                  ? AppColors.error.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: isTimeRunningOut ? AppColors.error : AppColors.primary,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 18,
                  color: isTimeRunningOut ? AppColors.error : AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatTime(_remainingSeconds),
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isTimeRunningOut ? AppColors.error : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.round),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress: ${(progress * 100).toInt()}%',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${_answers.length} terjawab',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 12,
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: question.type == QuestionType.multipleChoice
                          ? AppColors.primary.withOpacity(0.1)
                          : AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      question.type == QuestionType.multipleChoice
                          ? 'Pilihan Ganda'
                          : 'Isian',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: question.type == QuestionType.multipleChoice
                            ? AppColors.primary
                            : AppColors.success,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${question.points} poin',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // Question text
              Text(
                question.text,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Answer options
              question.type == QuestionType.multipleChoice
                  ? _buildMultipleChoiceOptions(question)
                  : _buildFillInBlankInput(question),
              const SizedBox(height: AppSpacing.lg),
              // Mark for review button
              OutlinedButton.icon(
                onPressed: _toggleMarkForReview,
                icon: Icon(
                  _isMarkedForReview[_currentQuestionIndex] ?? false
                      ? Icons.flag
                      : Icons.flag_outlined,
                  size: 20,
                ),
                label: Text(
                  _isMarkedForReview[_currentQuestionIndex] ?? false
                      ? 'Ditandai untuk Review'
                      : 'Tandai untuk Review',
                  style: GoogleFonts.leagueSpartan(),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _isMarkedForReview[_currentQuestionIndex] ?? false
                      ? AppColors.warning
                      : AppColors.textSecondary,
                  side: BorderSide(
                    color: _isMarkedForReview[_currentQuestionIndex] ?? false
                        ? AppColors.warning
                        : AppColors.textSecondary.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceOptions(Question question) {
    return Column(
      children: question.options!.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = _answers[_currentQuestionIndex] == option;
        final optionLabel = String.fromCharCode(65 + index); // A, B, C, D

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _saveAnswer(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.divider,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          optionLabel,
                          style: GoogleFonts.leagueSpartan(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        option,
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFillInBlankInput(Question question) {
    final currentAnswer = _answers[_currentQuestionIndex]?.toString() ?? '';
    final controller = TextEditingController(text: currentAnswer);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      controller: controller,
      onChanged: _saveAnswer,
      style: GoogleFonts.leagueSpartan(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: 'Tulis jawaban Anda di sini...',
        hintStyle: GoogleFonts.leagueSpartan(
          color: AppColors.textHint,
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        suffixIcon: currentAnswer.isNotEmpty
            ? Icon(Icons.check_circle, color: AppColors.success)
            : null,
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Question Navigator Button
          OutlinedButton.icon(
            onPressed: _showQuestionNavigator,
            icon: const Icon(Icons.grid_view, size: 20),
            label: Text(
              'Nomor',
              style: GoogleFonts.leagueSpartan(),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Previous Button
          if (_currentQuestionIndex > 0)
            IconButton(
              onPressed: _previousQuestion,
              icon: const Icon(Icons.arrow_back),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.background,
              ),
            ),
          const Spacer(),
          // Next/Submit Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _currentQuestionIndex < _questions.length - 1
                  ? _nextQuestion
                  : _showSubmitDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentQuestionIndex < _questions.length - 1
                    ? AppColors.primary
                    : AppColors.success,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentQuestionIndex < _questions.length - 1
                        ? 'Selanjutnya'
                        : 'Submit Ujian',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    _currentQuestionIndex < _questions.length - 1
                        ? Icons.arrow_forward
                        : Icons.check,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuestionNavigator() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Navigasi Soal',
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem(AppColors.success, 'Terjawab'),
                      _buildLegendItem(AppColors.warning, 'Ditandai'),
                      _buildLegendItem(AppColors.divider, 'Belum'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(AppSpacing.md),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1,
                ),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final isAnswered = _answers.containsKey(index);
                  final isMarked = _isMarkedForReview[index] ?? false;
                  final isCurrent = index == _currentQuestionIndex;

                  Color backgroundColor;
                  Color textColor;
                  
                  if (isCurrent) {
                    backgroundColor = AppColors.primary;
                    textColor = Colors.white;
                  } else if (isMarked) {
                    backgroundColor = AppColors.warning.withOpacity(0.1);
                    textColor = AppColors.warning;
                  } else if (isAnswered) {
                    backgroundColor = AppColors.success.withOpacity(0.1);
                    textColor = AppColors.success;
                  } else {
                    backgroundColor = AppColors.background;
                    textColor = AppColors.textSecondary;
                  }

                  return GestureDetector(
                    onTap: () => _goToQuestion(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: isCurrent ? AppColors.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showExitConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        title: Text(
          'Keluar dari Ujian?',
          style: GoogleFonts.leagueSpartan(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Jawaban Anda akan hilang jika keluar sekarang. Anda yakin?',
          style: GoogleFonts.leagueSpartan(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: GoogleFonts.leagueSpartan(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit exam
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
            child: Text(
              'Keluar',
              style: GoogleFonts.leagueSpartan(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
