# 🎓 Tryout Apps - Aplikasi Mobile Ujian Online

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.24.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.5.1-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Proprietary-red)
![Status](https://img.shields.io/badge/Status-Active%20Development-success)

**Aplikasi mobile tryout/ujian online yang modern dan interaktif**  
Dibangun dengan Flutter untuk platform Android, iOS, dan Web

[Fitur](#-fitur-utama) • [Instalasi](#-instalasi) • [Screenshots](#-screenshots) • [Dokumentasi](#-dokumentasi)

</div>

---

## 📖 Tentang Project

Tryout Apps adalah aplikasi mobile yang dirancang untuk memudahkan siswa dalam mengerjakan tryout dan ujian online. Aplikasi ini menyediakan berbagai fitur menarik seperti:

- ✅ Soal pilihan ganda dan isian
- ⏱️ Timer countdown real-time
- 📊 Analisis hasil ujian dengan chart
- 🎨 UI/UX modern dengan Material Design 3
- 📱 Responsive design untuk semua ukuran layar
- 🎯 Banner carousel untuk promosi ujian premium

## ✨ Fitur Utama

### 🏠 Home Screen
- **Banner Carousel Premium**: Auto-playing banner dengan 3 ujian premium
- **Performance Chart**: Doughnut chart untuk statistik tryout
- **Statistics Cards**: Total tryout, selesai, dengan animasi staggered
- **Quick Access**: Card navigasi ke berbagai fitur
- **Gradient Header**: Design modern dengan SliverAppBar

### 📝 Exam Features
- **Dua Tipe Soal**:
  - 🔘 **Pilihan Ganda** (Multiple Choice) dengan 4 opsi
  - ✍️ **Isian** (Fill in Blank) dengan text input
- **Timer Countdown**: HH:MM:SS dengan warning warna merah
- **Progress Tracking**: Bar progress dengan persentase
- **Question Navigator**: Grid navigasi dengan color coding
- **Mark for Review**: Flag soal untuk ditinjau ulang
- **Auto-save**: Jawaban tersimpan otomatis

### 📊 Result & Review
- **Score Card**: Nilai besar dengan grade A-E
- **Statistics Grid**: Benar, salah, poin, waktu pengerjaan
- **Color Coding**: Hijau (80+), Kuning (60-79), Merah (0-59)
- **Review Screen**: Pembahasan lengkap setiap soal
- **Share Results**: Bagikan hasil ke social media

### 🎨 UI/UX Features
- **Smooth Animations**: Staggered, fade, slide animations
- **Hover Effects**: Interactive hover untuk web
- **Material Design 3**: Design system terkini
- **League Spartan Font**: Typography modern dari Google Fonts
- **Primary Color**: #2260FF (Figma-aligned)

### 🔍 Help Center
- **Tab Navigation**: Manual Book & Contact Us
- **FAQ System**: Pertanyaan umum dengan kategori
- **Contact Cards**: Hubungi via WhatsApp, Email, Phone
- **Search Function**: Cari topik bantuan

## 🚀 Tech Stack

| Kategori | Technology |
|----------|-----------|
| **Framework** | Flutter 3.24.1 |
| **Language** | Dart 3.5.1 |
| **State Management** | Provider 6.1.1 |
| **Local Database** | SQLite (sqflite 2.3.0) |
| **HTTP Client** | http 1.1.0 |
| **Charts** | fl_chart 0.68.0 |
| **Carousel** | flutter_carousel_widget 2.2.0 |
| **Animations** | flutter_staggered_animations 1.1.1 |
| **Fonts** | google_fonts 6.1.0 |
| **Storage** | shared_preferences 2.2.2 |

## 📋 Prerequisites

Sebelum memulai, pastikan Anda sudah menginstall:

### 1. Flutter SDK (3.0+)
```bash
flutter --version
```

### 2. IDE/Editor
- **VS Code** dengan extensions:
  - Dart
  - Flutter
  - Flutter Widget Snippets (opsional)
- Atau **Android Studio** dengan Flutter plugin

### 3. Platform SDK
- **Android SDK** untuk Android development
- **Xcode** untuk iOS (hanya di macOS)
- **Chrome** untuk web development

## 🛠️ Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/tryout_apps.git
cd tryout_apps
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Cek Environment

```bash
flutter doctor -v
```

Pastikan semua checklist hijau (atau kuning untuk opsional).

### 4. Run Aplikasi

#### Web (Recommended untuk development):
```bash
flutter run -d chrome
```

#### Android:
```bash
flutter run -d <device-id>
```

#### Windows:
```bash
flutter run -d windows
```

## 📁 Struktur Project

```
tryout_apps/
├── .github/
│   └── copilot-instructions.md      # AI coding instructions
├── .vscode/
│   ├── launch.json                  # Debug configurations
│   └── tasks.json                   # Flutter tasks
├── lib/
│   ├── main.dart                    # App entry point
│   ├── screens/                     # UI Screens
│   │   ├── home_screen.dart         # Home dengan banner & chart
│   │   ├── exam_list_screen.dart    # Daftar ujian
│   │   ├── exam_detail_screen.dart  # Detail ujian
│   │   ├── exam_screen.dart         # Mengerjakan ujian
│   │   ├── exam_result_screen.dart  # Hasil ujian
│   │   ├── help_center_screen.dart  # Pusat bantuan
│   │   ├── contact_us_screen.dart   # Kontak
│   │   └── help_support_screen.dart # FAQ
│   ├── widgets/                     # Reusable widgets
│   ├── models/                      # Data models
│   │   ├── question.dart            # Question model
│   │   ├── exam.dart                # Exam model
│   │   ├── user.dart                # User model
│   │   └── exam_result.dart         # Result model
│   ├── services/                    # Business logic
│   ├── providers/                   # State management
│   └── utils/
│       └── constants.dart           # App constants & theming
├── assets/
│   ├── images/                      # Image assets
│   ├── icons/                       # Icon assets
│   └── fonts/                       # Font files
├── test/                            # Unit & widget tests
├── android/                         # Android platform code
├── ios/                             # iOS platform code
├── web/                             # Web platform code
├── windows/                         # Windows platform code
├── pubspec.yaml                     # Dependencies
├── README.md                        # This file
├── QUICKSTART.md                    # Quick start guide
├── BANNER_FEATURE_DOCS.md           # Banner documentation
├── EXAM_FEATURE_DOCS.md             # Exam list documentation
├── EXAM_EXECUTION_DOCS.md           # Exam execution docs
├── HELP_CENTER_DOCS.md              # Help center docs
└── ANDROID_SETUP.md                 # Android setup guide
```

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # HTTP & API
  http: ^1.1.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  
  # UI/UX
  google_fonts: ^6.1.0
  animations: ^2.0.11
  flutter_staggered_animations: ^1.1.1
  flutter_carousel_widget: ^2.2.0
  smooth_page_indicator: ^1.1.0
  
  # Charts
  fl_chart: ^0.68.0
  
  # Utilities
  intl: ^0.18.1
  cupertino_icons: ^1.0.8
```

## 🎯 Roadmap

### ✅ Phase 1 - Foundation (COMPLETED)
- [x] Project setup & structure
- [x] Home screen dengan gradient header
- [x] Help Center dengan tab navigation
- [x] Contact Us screen
- [x] FAQ Support system
- [x] Material Design 3 theming
- [x] League Spartan font integration

### ✅ Phase 2 - UI Enhancement (COMPLETED)
- [x] Banner carousel premium exams
- [x] Doughnut chart untuk performance
- [x] Staggered animations
- [x] Hover effects untuk web
- [x] Smooth page indicators

### ✅ Phase 3 - Exam System (COMPLETED)
- [x] Exam list screen dengan search & filter
- [x] Exam detail dengan 3 tabs
- [x] Exam execution screen
- [x] Multiple choice questions
- [x] Fill in blank questions
- [x] Timer countdown
- [x] Question navigator
- [x] Result screen dengan grade
- [x] Review screen dengan pembahasan

### 🔄 Phase 4 - Backend Integration (IN PROGRESS)
- [ ] REST API integration
- [ ] Authentication (Login/Register)
- [ ] Real user data
- [ ] Real exam data from API
- [ ] Cloud storage untuk media
- [ ] Push notifications

### 📋 Phase 5 - Advanced Features (PLANNED)
- [ ] User profile & settings
- [ ] Exam history & analytics
- [ ] Leaderboard
- [ ] Discussion forum
- [ ] Video explanations
- [ ] Offline mode
- [ ] Payment gateway integration
- [ ] Certificate generation

## 🧪 Testing

### Run Tests
```bash
# All tests
flutter test

# Specific test file
flutter test test/models/question_test.dart

# With coverage
flutter test --coverage

# Integration tests
flutter test integration_test/
```

### Test Structure
```
test/
├── models/
│   ├── question_test.dart
│   ├── exam_test.dart
│   └── user_test.dart
├── services/
│   ├── api_service_test.dart
│   └── database_service_test.dart
└── widgets/
    └── widget_test.dart
```

## 🏗️ Build untuk Production

### Android

#### Debug APK
```bash
flutter build apk --debug
```

#### Release APK
```bash
flutter build apk --release
```

#### Split APK (Recommended)
```bash
flutter build apk --split-per-abi --release
```

Output: `build/app/outputs/flutter-apk/`

#### App Bundle (Google Play)
```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/`

### iOS (macOS only)

```bash
flutter build ios --release
```

Buka `ios/Runner.xcworkspace` di Xcode untuk archive.

### Web

```bash
flutter build web --release
```

Output: `build/web/`

Deploy ke hosting seperti Firebase Hosting, Netlify, atau Vercel.

## 📸 Screenshots

### Home Screen
- Banner carousel dengan 3 premium exams
- Doughnut chart performance
- Statistics cards
- Quick access cards

### Exam List
- Search bar
- Category filter (Semua, TPA, Matematika, dll)
- Exam cards dengan info lengkap
- Rating & participants

### Exam Execution
- Timer countdown
- Progress bar
- Multiple choice questions
- Fill in blank input
- Question navigator grid
- Mark for review

### Result Screen
- Large score display
- Grade (A-E) dengan color coding
- Statistics (Benar, Salah, Poin, Waktu)
- Review button

## 📚 Dokumentasi

Dokumentasi lengkap tersedia di folder root:

| File | Deskripsi |
|------|-----------|
| `QUICKSTART.md` | Panduan cepat memulai |
| `BANNER_FEATURE_DOCS.md` | Dokumentasi banner carousel |
| `EXAM_FEATURE_DOCS.md` | Dokumentasi exam list & detail |
| `EXAM_EXECUTION_DOCS.md` | Dokumentasi exam execution |
| `HELP_CENTER_DOCS.md` | Dokumentasi help center |
| `ANDROID_SETUP.md` | Setup Android development |

## 🐛 Troubleshooting

### Error: "Flutter SDK not found"
```bash
# Set Flutter di PATH environment variable
# Atau gunakan full path
C:\path\to\flutter\bin\flutter doctor
```

### Error: "Android licenses not accepted"
```bash
flutter doctor --android-licenses
```

### Error: "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: "Package not found"
```bash
flutter pub cache repair
flutter pub get
```

### Error: "Cocoapods not installed" (macOS)
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
```

## 🔧 Configuration

### App Name
Edit di:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `lib/utils/constants.dart`

### App Icon
Gunakan [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons):

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
```

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Package Name
Edit di:
- `android/app/build.gradle` (applicationId)
- `ios/Runner.xcodeproj` (Bundle Identifier)

## 🚀 Deployment

### Google Play Store
1. Build App Bundle: `flutter build appbundle --release`
2. Upload ke Google Play Console
3. Isi form aplikasi & screenshots
4. Submit untuk review

### Apple App Store
1. Build iOS: `flutter build ios --release`
2. Archive di Xcode
3. Upload ke App Store Connect
4. Submit untuk review

### Web Hosting
1. Build web: `flutter build web --release`
2. Deploy `build/web/` ke:
   - Firebase Hosting
   - Netlify
   - Vercel
   - GitHub Pages

## 📊 Performance

### Optimizations
- ✅ Lazy loading untuk images
- ✅ Efficient list rendering (ListView.builder)
- ✅ Minimal rebuilds dengan setState scope
- ✅ Image caching
- ✅ Code splitting

### Benchmarks
- Cold start: < 2s
- Hot reload: < 500ms
- Frame rate: 60 FPS
- Bundle size: ~15 MB (release)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📝 Coding Standards

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable names
- Add comments for complex logic
- Separate UI from business logic
- Use const constructors when possible
- Implement proper error handling

## 🔐 Security

- Never commit API keys or secrets
- Use environment variables untuk sensitive data
- Implement proper authentication
- Encrypt local database
- Validate user input
- Use HTTPS untuk API calls

## 📄 License

Copyright © 2024-2025 **CV. Duta Technology**. All rights reserved.

This project is proprietary software. Unauthorized copying, distribution, or modification is strictly prohibited.

## 👥 Team

**CV. Duta Technology**
- 📧 Email: contact@dutatech.com
- 🌐 Website: www.dutatech.com
- 📱 WhatsApp: +62 xxx xxxx xxxx

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) - Framework
- [Google Fonts](https://fonts.google.com) - Typography
- [Material Design](https://m3.material.io) - Design System
- [Pub.dev](https://pub.dev) - Package ecosystem

## 📞 Support

Jika ada pertanyaan atau butuh bantuan:

- 📧 Email: support@dutatech.com
- 💬 WhatsApp: +62 xxx xxxx xxxx
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/tryout_apps/issues)
- 📖 Docs: [Project Wiki](https://github.com/yourusername/tryout_apps/wiki)

---

<div align="center">

**Made with ❤️ by CV. Duta Technology**

⭐ Star this repo if you like it!

</div>
