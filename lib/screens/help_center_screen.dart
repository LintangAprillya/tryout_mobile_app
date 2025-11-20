import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
                            'Help Center',
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
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text(
                      'How Can We Help You?',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search,
                              color: Theme.of(context).hintColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Tab Bar
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textWhite,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: 'Manual Book'),
                        Tab(text: 'Contact Us'),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildManualBookTab(),
                _buildContactUsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualBookTab() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            Text(
              'Selamat Datang di Tryout Apps!',
              style: AppTextStyles.heading2.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Aplikasi Tryout Apps adalah platform pembelajaran interaktif yang dirancang untuk membantu Anda mempersiapkan diri menghadapi berbagai ujian dan tes dengan sistem tryout yang komprehensif.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Fitur Utama
            Text(
              'Fitur Utama',
              style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),

            _buildFeatureItem(
              icon: Icons.quiz,
              title: 'Bank Soal Lengkap',
              description: 'Ribuan soal dari berbagai kategori: Literasi Bahasa Indonesia, Literasi Bahasa Inggris, Penalaran Matematika, dan lainnya.',
            ),

            _buildFeatureItem(
              icon: Icons.timer,
              title: 'Timer Real-time',
              description: 'Simulasi ujian dengan batas waktu yang sesuai dengan tes sesungguhnya untuk mengasah manajemen waktu Anda.',
            ),

            _buildFeatureItem(
              icon: Icons.analytics,
              title: 'Analisis Hasil',
              description: 'Lihat skor, pembahasan soal, dan analisis performa untuk mengetahui kekuatan dan area yang perlu ditingkatkan.',
            ),

            _buildFeatureItem(
              icon: Icons.leaderboard,
              title: 'Ranking & Kompetisi',
              description: 'Bandingkan hasil Anda dengan peserta lain dan lihat posisi ranking Anda secara real-time.',
            ),

            const SizedBox(height: AppSpacing.xl),

            // Cara Penggunaan
            Text(
              'Cara Menggunakan Aplikasi',
              style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),

            _buildStepItem(
              number: 1,
              title: 'Registrasi Akun',
              description: 'Daftar menggunakan email dan buat password yang kuat. Verifikasi email Anda untuk mengaktifkan akun.',
            ),

            _buildStepItem(
              number: 2,
              title: 'Pilih Paket Tryout',
              description: 'Browse kategori tryout yang tersedia dan pilih sesuai kebutuhan Anda. Ada paket gratis dan premium.',
            ),

            _buildStepItem(
              number: 3,
              title: 'Mulai Mengerjakan',
              description: 'Klik "Mulai Tryout", baca instruksi dengan teliti, dan kerjakan soal sesuai waktu yang ditentukan.',
            ),

            _buildStepItem(
              number: 4,
              title: 'Submit & Review',
              description: 'Setelah selesai, submit jawaban Anda. Lihat hasil, pembahasan, dan analisis performa untuk belajar dari kesalahan.',
            ),

            const SizedBox(height: AppSpacing.xl),

            // Syarat & Ketentuan
            Text(
              'Syarat & Ketentuan Penggunaan',
              style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),

            _buildTermItem(
              number: 1,
              text: 'Pengguna wajib memberikan informasi yang valid dan akurat saat registrasi. Satu akun hanya untuk satu pengguna dan tidak boleh dibagikan kepada orang lain.',
            ),

            _buildTermItem(
              number: 2,
              text: 'Dilarang melakukan kecurangan dalam bentuk apapun selama mengerjakan tryout, termasuk menggunakan bantuan pihak lain atau perangkat tidak sah. Pelanggaran akan mengakibatkan diskualifikasi.',
            ),

            _buildTermItem(
              number: 3,
              text: 'Konten soal dan materi pembelajaran adalah hak cipta kami. Dilarang menyalin, mendistribusikan, atau menggunakan untuk kepentingan komersial tanpa izin tertulis.',
            ),

            _buildTermItem(
              number: 4,
              text: 'Kami berhak melakukan perubahan pada aplikasi, termasuk fitur, harga paket, dan kebijakan tanpa pemberitahuan sebelumnya. Pengguna akan diinformasikan melalui aplikasi atau email.',
            ),

            _buildTermItem(
              number: 5,
              text: 'Pengguna bertanggung jawab menjaga keamanan akun dan password. Kami tidak bertanggung jawab atas kerugian akibat kelalaian pengguna dalam menjaga kerahasiaan akun.',
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildContactUsTab() {
    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),

            // Info Section
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Jam Operasional',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Senin - Jumat: 08:00 - 17:00 WIB\nSabtu - Minggu: 09:00 - 15:00 WIB',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _buildContactCard(
              icon: Icons.headset_mic_rounded,
              title: 'Customer Service',
              subtitle: 'Hubungi CS kami untuk bantuan',
              detail: '+62 812-3456-7890',
              color: AppColors.primary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Menghubungi Customer Service...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            _buildContactCard(
              icon: Icons.email_rounded,
              title: 'Email Support',
              subtitle: 'Kirim pertanyaan via email',
              detail: 'support@tryoutapps.com',
              color: AppColors.accent,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka Email Client...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            _buildContactCard(
              icon: Icons.language_rounded,
              title: 'Website',
              subtitle: 'Kunjungi website resmi kami',
              detail: 'www.tryoutapps.com',
              color: AppColors.info,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka Website...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            _buildContactCard(
              icon: Icons.chat_bubble_rounded,
              title: 'WhatsApp',
              subtitle: 'Chat langsung via WhatsApp',
              detail: '+62 812-3456-7890',
              color: AppColors.success,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka WhatsApp...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            _buildContactCard(
              icon: Icons.location_on_rounded,
              title: 'Kantor Kami',
              subtitle: 'Kunjungi kantor kami',
              detail: 'Jl. Contoh No. 123, Jakarta Selatan',
              color: AppColors.error,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka Google Maps...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem({required int number, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
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

  Widget _buildStepItem({
    required int number,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
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

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String detail,
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
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
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
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      detail,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
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
}
