import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pusat Bantuan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari bantuan...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),

            // FAQ Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori Bantuan',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  _buildCategoryCard(
                    context: context,
                    icon: Icons.account_circle_outlined,
                    title: 'Akun & Profil',
                    description: 'Pengaturan akun, password, profil',
                    color: AppColors.primary,
                    onTap: () {
                      // TODO: Navigate to account help
                    },
                  ),

                  _buildCategoryCard(
                    context: context,
                    icon: Icons.assignment_outlined,
                    title: 'Tryout & Ujian',
                    description: 'Cara mengerjakan, submit, lihat hasil',
                    color: AppColors.accent,
                    onTap: () {
                      // TODO: Navigate to exam help
                    },
                  ),

                  _buildCategoryCard(
                    context: context,
                    icon: Icons.payment_outlined,
                    title: 'Pembayaran',
                    description: 'Metode bayar, konfirmasi, riwayat',
                    color: AppColors.success,
                    onTap: () {
                      // TODO: Navigate to payment help
                    },
                  ),

                  _buildCategoryCard(
                    context: context,
                    icon: Icons.leaderboard_outlined,
                    title: 'Ranking & Skor',
                    description: 'Cara melihat ranking dan analisis',
                    color: AppColors.info,
                    onTap: () {
                      // TODO: Navigate to ranking help
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Quick Help Section
                  Text(
                    'Pertanyaan Umum',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  _buildFAQCard(
                    question: 'Bagaimana cara mendaftar akun?',
                    answer:
                        'Klik tombol Daftar di halaman login, lalu isi formulir dengan data yang valid. Verifikasi email Anda untuk mengaktifkan akun.',
                  ),

                  _buildFAQCard(
                    question: 'Bagaimana cara mengerjakan tryout?',
                    answer:
                        'Pilih tryout yang tersedia, klik Mulai Tryout, jawab semua soal, lalu klik Submit untuk melihat hasil.',
                  ),

                  _buildFAQCard(
                    question: 'Apakah bisa mengerjakan tryout secara offline?',
                    answer:
                        'Ya, Anda bisa download soal terlebih dahulu dan mengerjakan secara offline. Hasil akan tersinkronisasi saat online.',
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),

            // Contact Support Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: AppColors.background,
              child: Column(
                children: [
                  Text(
                    'Tidak menemukan jawaban?',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to contact support
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Membuka Contact Support...')),
                      );
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Hubungi Customer Service'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
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

  Widget _buildCategoryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQCard({
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                answer,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
