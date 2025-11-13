import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import 'help_center_screen.dart';
import 'contact_us_screen.dart';
import 'help_support_screen.dart';
import 'exam_list_screen.dart';
import 'exam_detail_screen.dart';
import '../models/exam.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _touchedIndex = -1;
  int _currentCarouselIndex = 0;

  // Data iklan ujian premium
  final List<Map<String, dynamic>> _premiumExams = [
    {
      'exam': Exam(
        id: '1',
        title: 'UTBK 2024 Super Intensive',
        description: 'Paket lengkap persiapan UTBK dengan 500+ soal berkualitas',
        category: 'TPA',
        duration: 180,
        totalQuestions: 150,
        difficulty: 'Sulit',
        participants: 5420,
        rating: 4.9,
        isFree: false,
        price: 150000,
        thumbnail: '🎯',
      ),
      'discount': 30,
      'badge': 'BEST SELLER',
      'color': const Color(0xFFFF6B6B),
    },
    {
      'exam': Exam(
        id: '2',
        title: 'CPNS 2024 Bundle Package',
        description: 'Tryout CPNS lengkap dengan SKD + SKB',
        category: 'TPA',
        duration: 120,
        totalQuestions: 110,
        difficulty: 'Sulit',
        participants: 8234,
        rating: 4.8,
        isFree: false,
        price: 200000,
        thumbnail: '📋',
      ),
      'discount': 40,
      'badge': 'HOT SALE',
      'color': const Color(0xFFFFB800),
    },
    {
      'exam': Exam(
        id: '3',
        title: 'TOEFL Mastery Program',
        description: 'Program intensif TOEFL dengan target score 550+',
        category: 'Bahasa Inggris',
        duration: 150,
        totalQuestions: 120,
        difficulty: 'Sedang',
        participants: 3145,
        rating: 4.9,
        isFree: false,
        price: 175000,
        thumbnail: '🇬🇧',
      ),
      'discount': 25,
      'badge': 'TRENDING',
      'color': const Color(0xFF4ECDC4),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Animated SliverAppBar dengan Gradient
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'Selamat Datang! 👋',
                            style: AppTextStyles.heading1.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'Siap untuk mengerjakan tryout hari ini?',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textWhite.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: 'Help Center',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.support_agent_outlined),
                tooltip: 'Pusat Bantuan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Premium Exam Banner Carousel
          SliverToBoxAdapter(
            child: _buildPremiumBanner(),
          ),

          // Content
          SliverToBoxAdapter(
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    const SizedBox(height: AppSpacing.lg),

                    // Statistics Cards
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.assignment_outlined,
                              title: 'Total Tryout',
                              value: '12',
                              color: AppColors.primary,
                              gradientColors: [
                                AppColors.primary,
                                AppColors.primaryDark,
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.check_circle_outline,
                              title: 'Selesai',
                              value: '8',
                              color: AppColors.success,
                              gradientColors: [
                                AppColors.success,
                                AppColors.success.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Performance Chart Section
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Text(
                        'Performa Tryout',
                        style: AppTextStyles.heading2,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: _buildPerformanceChart(),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Available Tryouts Section
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tryout Tersedia',
                            style: AppTextStyles.heading2,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Lihat Semua',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Tryout List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return _buildTryoutCard(
                          title: 'Tryout UTBK 2025 - Sesi ${index + 1}',
                          description: 'Tes Potensi Skolastik dan Literasi',
                          questions: 60,
                          duration: 90,
                          category: 'UTBK',
                          index: index,
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Quick Access Section
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Text(
                        'Akses Cepat',
                        style: AppTextStyles.heading2,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildQuickAccessCard(
                              icon: Icons.help_center_rounded,
                              title: 'Help Center',
                              color: AppColors.primary,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HelpCenterScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _buildQuickAccessCard(
                              icon: Icons.contact_support_rounded,
                              title: 'Contact Us',
                              color: AppColors.success,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactUsScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fadeAnimation,
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Fitur sedang dalam pengembangan',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textWhite),
                ),
                backgroundColor: AppColors.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            );
          },
          icon: const Icon(Icons.play_arrow_rounded),
          label: Text('Mulai Tryout', style: AppTextStyles.button),
          backgroundColor: AppColors.accent,
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required List<Color> gradientColors,
  }) {
    return Hero(
      tag: 'stat_$title',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: AppTextStyles.heading1.copyWith(
                color: Colors.white,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTryoutCard({
    required String title,
    required String description,
    required int questions,
    required int duration,
    required String category,
    required int index,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          elevation: 3,
          shadowColor: AppColors.primary.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: InkWell(
            onTap: () {
              // Navigate to Exam List Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExamListScreen(),
                ),
              );
            },
            onHover: (isHovering) {
              // Hover effect handled by MouseRegion
            },
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    AppColors.primaryLight.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.round),
                      ),
                      child: Text(
                        category,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  title,
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                Divider(color: AppColors.divider.withOpacity(0.5)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.quiz_outlined,
                      label: '$questions soal',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _buildInfoChip(
                      icon: Icons.timer_outlined,
                      label: '$duration menit',
                      color: AppColors.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Card(
      elevation: 4,
      shadowColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColors.primaryLight.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statistik Tryout',
                  style: AppTextStyles.heading3,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.round),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Total: 12',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                _touchedIndex = -1;
                                return;
                              }
                              _touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        sections: _buildPieChartSections(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(
                          color: AppColors.success,
                          label: 'Lulus',
                          value: '8',
                          percentage: '67%',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildLegendItem(
                          color: AppColors.warning,
                          label: 'Sedang',
                          value: '2',
                          percentage: '17%',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildLegendItem(
                          color: AppColors.error,
                          label: 'Kurang',
                          value: '2',
                          percentage: '16%',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Divider(color: AppColors.divider.withOpacity(0.5)),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatChip(
                  icon: Icons.emoji_events_rounded,
                  label: 'Rata-rata',
                  value: '85',
                  color: AppColors.accent,
                ),
                _buildStatChip(
                  icon: Icons.workspace_premium_rounded,
                  label: 'Tertinggi',
                  value: '95',
                  color: AppColors.success,
                ),
                _buildStatChip(
                  icon: Icons.timer_rounded,
                  label: 'Waktu',
                  value: '75m',
                  color: AppColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 65.0 : 55.0;
      final widgetSize = isTouched ? 55.0 : 45.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.success,
            value: 67,
            title: '67%',
            radius: radius,
            titleStyle: AppTextStyles.bodyMedium.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: isTouched
                ? _buildBadge(Icons.check_circle, AppColors.success, widgetSize)
                : null,
            badgePositionPercentageOffset: 1.3,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.warning,
            value: 17,
            title: '17%',
            radius: radius,
            titleStyle: AppTextStyles.bodyMedium.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: isTouched
                ? _buildBadge(Icons.remove_circle, AppColors.warning, widgetSize)
                : null,
            badgePositionPercentageOffset: 1.3,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.error,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: AppTextStyles.bodyMedium.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: isTouched
                ? _buildBadge(Icons.cancel, AppColors.error, widgetSize)
                : null,
            badgePositionPercentageOffset: 1.3,
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildBadge(IconData icon, Color color, double size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: size * 0.6,
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
    required String percentage,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$value ($percentage)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Premium Exam Banner Widget
  Widget _buildPremiumBanner() {
    return Container(
      margin: const EdgeInsets.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.md,
      ),
      child: Column(
        children: [
          // Carousel Slider
          FlutterCarousel(
            items: _premiumExams.map((examData) {
              final exam = examData['exam'] as Exam;
              final discount = examData['discount'] as int;
              final badge = examData['badge'] as String;
              final color = examData['color'] as Color;

              return _buildBannerCard(
                exam: exam,
                discount: discount,
                badge: badge,
                color: color,
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCarouselIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Smooth Page Indicator
          AnimatedSmoothIndicator(
            activeIndex: _currentCarouselIndex,
            count: _premiumExams.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColors.primary,
              dotColor: AppColors.primary.withOpacity(0.3),
              expansionFactor: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard({
    required Exam exam,
    required int discount,
    required String badge,
    required Color color,
  }) {
    final originalPrice = exam.price;
    final discountedPrice = originalPrice - (originalPrice * discount / 100);

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
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withOpacity(0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge & Thumbnail Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            badge,
                            style: AppTextStyles.caption.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            exam.thumbnail,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Title
                    Text(
                      exam.title,
                      style: AppTextStyles.heading3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    // Description
                    Text(
                      exam.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Price & Discount Row
                    Row(
                      children: [
                        // Discounted Price
                        Text(
                          'Rp ${(discountedPrice / 1000).toStringAsFixed(0)}k',
                          style: AppTextStyles.heading3.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        // Original Price (crossed out)
                        Text(
                          'Rp ${(originalPrice / 1000).toStringAsFixed(0)}k',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        // Discount Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '-$discount%',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

