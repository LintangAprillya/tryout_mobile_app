import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header dengan gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // AppBar
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: AppColors.textWhite),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhite,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48), // Balance the back button
                      ],
                    ),
                  ),

                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Text(
                      'How Can We Help You?',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),

          // Contact Options
          Expanded(
            child: Container(
              color: AppColors.background,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),

                    _buildContactCard(
                      context: context,
                      icon: Icons.headset_mic_rounded,
                      title: 'Customer Service',
                      subtitle: 'Hubungi customer service kami',
                      description: '24/7 siap membantu Anda',
                      color: AppColors.primary,
                      onTap: () {
                        // TODO: Open customer service
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Membuka Customer Service...')),
                        );
                      },
                    ),

                    _buildContactCard(
                      context: context,
                      icon: Icons.language_rounded,
                      title: 'Website',
                      subtitle: 'www.dutatechnology.com',
                      description: 'Kunjungi website resmi kami',
                      color: AppColors.info,
                      onTap: () {
                        // TODO: Open website
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Membuka Website...')),
                        );
                      },
                    ),

                    _buildContactCard(
                      context: context,
                      icon: Icons.chat_bubble_rounded,
                      title: 'Whatsapp',
                      subtitle: '+62 812-3456-7890',
                      description: 'Chat langsung via WhatsApp',
                      color: AppColors.success,
                      onTap: () {
                        // TODO: Open WhatsApp
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Membuka WhatsApp...')),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Additional Info Card
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            const Text(
                              'Jam Operasional',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Senin - Jumat: 08:00 - 17:00 WIB\nSabtu: 08:00 - 12:00 WIB\nMinggu & Hari Libur: Tutup',
                              style: AppTextStyles.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 36,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      description,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
