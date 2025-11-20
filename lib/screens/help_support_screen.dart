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
                        'Untuk mendaftar, klik tombol "Daftar" di halaman login. Isi formulir dengan data yang valid (nama lengkap, email, password). Setelah submit, cek email Anda untuk link verifikasi. Klik link tersebut untuk mengaktifkan akun Anda.',
                  ),

                  _buildFAQCard(
                    question: 'Bagaimana cara mengerjakan tryout?',
                    answer:
                        '1. Login ke aplikasi\n2. Pilih kategori tryout yang ingin dikerjakan\n3. Klik "Mulai Tryout"\n4. Baca instruksi dengan teliti\n5. Jawab semua soal sesuai waktu\n6. Klik "Submit" untuk menyelesaikan\n7. Lihat hasil dan pembahasan',
                  ),

                  _buildFAQCard(
                    question: 'Apakah ada batas waktu mengerjakan?',
                    answer:
                        'Ya, setiap tryout memiliki batas waktu sesuai standar ujian. Timer akan berjalan otomatis saat Anda mulai. Jika waktu habis, jawaban akan otomatis tersubmit.',
                  ),

                  _buildFAQCard(
                    question: 'Bagaimana cara melihat hasil tryout?',
                    answer:
                        'Setelah submit, hasil langsung ditampilkan. Anda bisa melihat:\n- Total skor\n- Jumlah benar/salah\n- Pembahasan tiap soal\n- Analisis performa\n- Ranking dibanding peserta lain',
                  ),

                  _buildFAQCard(
                    question: 'Apakah bisa mengerjakan ulang tryout yang sama?',
                    answer:
                        'Untuk tryout gratis, Anda bisa mengulang kapan saja. Untuk tryout berbayar, tergantung paket yang dibeli - ada yang sekali akses, ada yang unlimited hingga tanggal tertentu.',
                  ),

                  _buildFAQCard(
                    question: 'Bagaimana cara reset password?',
                    answer:
                        'Di halaman login, klik "Lupa Password". Masukkan email terdaftar, dan link reset akan dikirim ke email Anda. Klik link tersebut dan buat password baru.',
                  ),

                  _buildFAQCard(
                    question: 'Apakah data tryout saya aman?',
                    answer:
                        'Ya, semua data Anda terenkripsi dan disimpan dengan aman. Kami tidak membagikan data pribadi Anda kepada pihak ketiga tanpa persetujuan.',
                  ),

                  _buildFAQCard(
                    question: 'Bagaimana cara upgrade ke paket premium?',
                    answer:
                        'Masuk ke menu "Paket Tryout", pilih paket premium yang diinginkan, lakukan pembayaran melalui metode yang tersedia, dan akses premium langsung aktif setelah konfirmasi.',
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
