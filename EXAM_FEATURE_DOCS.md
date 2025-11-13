# Dokumentasi Fitur Daftar Ujian & Detail Ujian

## 📝 Overview

Fitur ini memungkinkan user untuk melihat daftar ujian yang tersedia dan detail lengkap setiap ujian sebelum memutuskan untuk mengikutinya.

## 🎯 Fitur Utama

### 1. **Exam List Screen** (`exam_list_screen.dart`)

Layar yang menampilkan daftar semua ujian yang tersedia dengan fitur:

#### ✨ Features:
- **Search Bar**: Cari ujian berdasarkan nama atau deskripsi
- **Category Filter**: Filter ujian berdasarkan kategori
  - Semua
  - TPA
  - Matematika
  - Bahasa Inggris
  - Pengetahuan Umum
- **Exam Cards**: Tampilan card untuk setiap ujian dengan informasi:
  - Thumbnail emoji
  - Judul ujian
  - Deskripsi singkat
  - Durasi ujian (menit)
  - Jumlah soal
  - Tingkat kesulitan (Mudah/Sedang/Sulit)
  - Rating (1-5 bintang)
  - Jumlah peserta
  - Status gratis/berbayar dengan harga

#### 🎨 Design Features:
- **Staggered Animations**: Animasi masuk bertahap untuk setiap card
- **Hover Effects**: Efek hover pada category chips dan exam cards
- **Gradient Background**: Background gradient dari primary color ke putih
- **Material Design**: Mengikuti prinsip Material Design 3
- **Responsive**: Menggunakan ListView dengan padding yang konsisten

#### 📊 Sample Data:
Terdapat 6 ujian sample:
1. Tryout UTBK 2024 - Sesi 1 (TPA) - Berbayar Rp 50k
2. Matematika Dasar - Level 1 - Gratis
3. TOEFL Preparation Test - Berbayar Rp 75k
4. Pengetahuan Umum Indonesia - Gratis
5. TPA CPNS 2024 - Berbayar Rp 65k
6. English Grammar Mastery - Gratis

### 2. **Exam Detail Screen** (`exam_detail_screen.dart`)

Layar detail yang menampilkan informasi lengkap tentang ujian tertentu.

#### ✨ Features:
- **Header Section**:
  - Large thumbnail icon dengan gradient background
  - Judul ujian
  - Category badge
  - 4 Stat cards: Jumlah Soal, Durasi, Peserta, Rating

- **Tab Navigation** dengan 3 tab:
  1. **Deskripsi**:
     - Tentang ujian
     - Info cards (Kesulitan, Harga)
     - Yang akan dipelajari (bullet points)
  
  2. **Materi**:
     - List cakupan materi per bagian
     - Jumlah soal per bagian
     - Status completed/uncompleted
  
  3. **Review**:
     - Overall rating dengan star display
     - List review dari pengguna
     - Avatar, nama, rating, komentar, waktu

- **Bottom Button**:
  - Tombol "Mulai Ujian Sekarang" (gratis)
  - Tombol "Beli & Mulai Ujian" (berbayar dengan harga)
  - Confirmation dialog sebelum mulai

#### 🎨 Design Features:
- **Gradient App Bar**: Gradient dari primary color
- **Fade & Slide Animation**: Animasi saat screen pertama kali muncul
- **Tab Switching**: Smooth transition antar tab dengan AnimatedSwitcher
- **Hover Effects**: Button dengan hover cursor
- **Color Coding**: 
  - Mudah = Hijau (Success)
  - Sedang = Kuning (Warning)
  - Sulit = Merah (Error)

#### 🔄 Navigation Flow:
```
Home Screen 
  → (Klik Tryout Card) → 
Exam List Screen 
  → (Klik Exam Card) → 
Exam Detail Screen 
  → (Klik Mulai Ujian) → 
[Dialog Konfirmasi]
```

## 🏗️ Structure & Architecture

### Model Update (`exam.dart`)

Model `Exam` diperluas dengan field tambahan:
```dart
class Exam {
  final String id;
  final String title;
  final String description;
  final int duration;
  final int totalQuestions;
  final String? category;
  final String difficulty;
  final int participants;
  final double rating;
  final bool isFree;
  final int price;
  final String thumbnail;
  
  // Getter untuk backward compatibility
  int get questionCount => totalQuestions;
}
```

### Constants Update (`constants.dart`)

Ditambahkan:
```dart
static const Color border = Color(0xFFE0E0E0);
```

## 🎨 UI/UX Design Principles

### Color Scheme:
- **Primary**: #2260FF (Figma Blue)
- **Success**: Green (#4CAF50) - untuk "Mudah"
- **Warning**: Yellow (#FFC107) - untuk "Sedang"
- **Error**: Red (#F44336) - untuk "Sulit"

### Typography:
- **Font Family**: League Spartan (Google Fonts)
- **Heading**: Bold weight
- **Body**: Normal weight
- **Button**: Semi-bold weight

### Spacing & Radius:
- Menggunakan `AppSpacing` dan `AppRadius` dari constants
- Konsisten padding dan margin
- Border radius untuk card: `AppRadius.xl` (16px)

### Animations:
1. **Staggered List Animation**:
   - Duration: 375ms
   - Vertical offset: 50px
   - Fade in effect

2. **Slide & Fade Animation**:
   - Duration: 800ms
   - Vertical offset: 0.3
   - Ease out curve

3. **Hover Animation**:
   - Duration: 200ms
   - Smooth transition

## 🚀 Usage Example

### Navigasi dari Home Screen:

```dart
// Di home_screen.dart, pada _buildTryoutCard onTap:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ExamListScreen(),
  ),
);
```

### Navigasi ke Detail Screen:

```dart
// Di exam_list_screen.dart, pada exam card onTap:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ExamDetailScreen(exam: exam),
  ),
);
```

## 📱 Responsive Design

- **Mobile First**: Didesain untuk mobile, tapi juga bagus di web
- **Flexible Layout**: Menggunakan Expanded dan Flexible widgets
- **Safe Area**: Menggunakan SafeArea untuk notch compatibility
- **Scrollable**: Semua konten dapat di-scroll

## 🔮 Future Enhancements

1. **Backend Integration**:
   - Fetch exam list dari API
   - Real-time participant count
   - User reviews dari database

2. **Payment Integration**:
   - Gateway pembayaran untuk ujian berbayar
   - E-wallet integration
   - Voucher/discount system

3. **Exam Execution**:
   - Timer countdown
   - Question navigation
   - Answer submission
   - Result calculation

4. **User Features**:
   - Bookmark favorite exams
   - Share exam to social media
   - Rate and review after completion
   - Progress tracking

## 📊 Performance Considerations

- **Lazy Loading**: ListView.builder untuk efficient rendering
- **Cached Images**: (akan diimplementasi untuk real images)
- **Debounce Search**: Search dengan debounce untuk reduce API calls
- **State Management**: Siap untuk Provider/Bloc integration

## 🐛 Known Limitations

1. Data masih hardcoded (6 sample exams)
2. Payment flow belum diimplementasi
3. Exam execution screen belum dibuat
4. No actual user authentication yet

## 📚 Dependencies Used

```yaml
dependencies:
  flutter_staggered_animations: ^1.1.1  # Untuk staggered animations
  google_fonts: ^6.1.0                  # League Spartan font
  fl_chart: ^0.68.0                     # Chart visualization
```

## 🎯 Testing Checklist

- [ ] Search functionality
- [ ] Category filter
- [ ] Card navigation
- [ ] Tab switching in detail
- [ ] Start exam dialog
- [ ] Back navigation
- [ ] Animations smooth
- [ ] Hover effects working
- [ ] Responsive on different screen sizes

---

**Created**: November 2024
**Last Updated**: November 2024
**Version**: 1.0.0
