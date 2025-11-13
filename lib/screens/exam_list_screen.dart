import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/constants.dart';
import '../models/exam.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'TPA',
    'Matematika',
    'Bahasa Inggris',
    'Pengetahuan Umum',
  ];

  // Dummy data - nanti bisa diganti dengan data dari API
  final List<Exam> _exams = [
    Exam(
      id: '1',
      title: 'Tryout UTBK 2024 - Sesi 1',
      description: 'Tryout komprehensif untuk persiapan UTBK 2024',
      category: 'TPA',
      duration: 120,
      totalQuestions: 100,
      difficulty: 'Sulit',
      participants: 1234,
      rating: 4.8,
      isFree: false,
      price: 50000,
      thumbnail: '🎓',
    ),
    Exam(
      id: '2',
      title: 'Matematika Dasar - Level 1',
      description: 'Latihan soal matematika dasar untuk pemula',
      category: 'Matematika',
      duration: 60,
      totalQuestions: 50,
      difficulty: 'Mudah',
      participants: 856,
      rating: 4.5,
      isFree: true,
      price: 0,
      thumbnail: '📐',
    ),
    Exam(
      id: '3',
      title: 'TOEFL Preparation Test',
      description: 'Simulasi tes TOEFL lengkap dengan pembahasan',
      category: 'Bahasa Inggris',
      duration: 90,
      totalQuestions: 75,
      difficulty: 'Sedang',
      participants: 2341,
      rating: 4.9,
      isFree: false,
      price: 75000,
      thumbnail: '🇬🇧',
    ),
    Exam(
      id: '4',
      title: 'Pengetahuan Umum Indonesia',
      description: 'Tes pengetahuan umum seputar Indonesia',
      category: 'Pengetahuan Umum',
      duration: 45,
      totalQuestions: 40,
      difficulty: 'Mudah',
      participants: 645,
      rating: 4.3,
      isFree: true,
      price: 0,
      thumbnail: '🇮🇩',
    ),
    Exam(
      id: '5',
      title: 'TPA CPNS 2024',
      description: 'Latihan TPA khusus persiapan CPNS',
      category: 'TPA',
      duration: 100,
      totalQuestions: 80,
      difficulty: 'Sulit',
      participants: 3456,
      rating: 4.7,
      isFree: false,
      price: 65000,
      thumbnail: '📋',
    ),
    Exam(
      id: '6',
      title: 'English Grammar Mastery',
      description: 'Kuasai grammar bahasa Inggris dengan mudah',
      category: 'Bahasa Inggris',
      duration: 50,
      totalQuestions: 60,
      difficulty: 'Sedang',
      participants: 1123,
      rating: 4.6,
      isFree: true,
      price: 0,
      thumbnail: '📚',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Exam> get _filteredExams {
    return _exams.where((exam) {
      final matchesCategory =
          _selectedCategory == 'Semua' || exam.category == _selectedCategory;
      final matchesSearch = exam.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          exam.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildAppBar(),
              _buildSearchBar(),
              _buildCategoryFilter(),
              Expanded(
                child: _buildExamList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Ujian',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${_filteredExams.length} ujian tersedia',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Cari ujian...',
            hintStyle: GoogleFonts.leagueSpartan(
              color: AppColors.textSecondary,
            ),
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
          style: GoogleFonts.leagueSpartan(),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildCategoryChip(category, isSelected),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                  )
                : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
                blurRadius: isSelected ? 15 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              category,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamList() {
    if (_filteredExams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Tidak ada ujian ditemukan',
              style: GoogleFonts.leagueSpartan(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: _filteredExams.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildExamCard(_filteredExams[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExamCard(Exam exam) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamDetailScreen(exam: exam),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamDetailScreen(exam: exam),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildExamThumbnail(exam),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _buildExamInfo(exam),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamThumbnail(Exam exam) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Center(
        child: Text(
          exam.thumbnail,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  Widget _buildExamInfo(Exam exam) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                exam.title,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!exam.isFree)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Rp ${exam.price ~/ 1000}k',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          exam.description,
          style: GoogleFonts.leagueSpartan(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildInfoChip(
              Icons.timer_outlined,
              '${exam.duration} menit',
            ),
            _buildInfoChip(
              Icons.quiz_outlined,
              '${exam.questionCount} soal',
            ),
            _buildInfoChip(
              Icons.signal_cellular_alt,
              exam.difficulty,
              color: _getDifficultyColor(exam.difficulty),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: AppColors.warning,
            ),
            const SizedBox(width: 4),
            Text(
              exam.rating.toString(),
              style: GoogleFonts.leagueSpartan(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              Icons.people_outline,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '${exam.participants} peserta',
              style: GoogleFonts.leagueSpartan(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: (color ?? AppColors.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color ?? AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.leagueSpartan(
              fontSize: 11,
              color: color ?? AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Mudah':
        return AppColors.success;
      case 'Sedang':
        return AppColors.warning;
      case 'Sulit':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }
}
