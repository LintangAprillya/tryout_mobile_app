# 🚀 Quick Start Guide - Tryout Apps

## Setup Cepat (5 Menit)

### 1. Verifikasi Flutter Installation
```powershell
flutter doctor -v
```

Pastikan semua ✓ hijau. Jika ada masalah:
- Android toolchain: Install Android Studio + Android SDK
- VS Code: Install ekstensi Dart & Flutter

### 2. Install Dependencies
```powershell
flutter pub get
```

### 3. Setup Device/Emulator

**Opsi A: Android Emulator**
```powershell
# List emulator yang tersedia
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>
```

**Opsi B: Physical Device**
- Aktifkan USB Debugging di HP Android
- Sambungkan ke komputer via USB
- Verifikasi: `flutter devices`

### 4. Run Aplikasi
```powershell
# Run di device default
flutter run

# Atau gunakan VS Code
# Tekan F5 atau Ctrl+Shift+D lalu pilih "Flutter: Debug"
```

## ⚡ Perintah Penting

```powershell
# Clean build cache (jika ada masalah)
flutter clean
flutter pub get

# Hot reload (saat app running)
# Tekan 'r' di terminal

# Hot restart (reload penuh)
# Tekan 'R' di terminal

# Quit app
# Tekan 'q' di terminal

# Build APK untuk testing
flutter build apk --debug

# Build APK production
flutter build apk --release
```

## 📱 Test di Multiple Devices

```powershell
# List semua device
flutter devices

# Run di device tertentu
flutter run -d <device-id>

# Run di semua device sekaligus
flutter run -d all
```

## 🔧 VS Code Shortcuts

- `F5` - Start debugging
- `Shift+F5` - Stop debugging
- `Ctrl+F5` - Run without debugging
- `Shift+Ctrl+P` → "Flutter: Hot Reload" - Manual hot reload
- `Shift+Ctrl+P` → "Flutter: Hot Restart" - Manual hot restart

## 📂 File Penting yang Perlu Diketahui

- `lib/main.dart` - Entry point aplikasi
- `lib/screens/home_screen.dart` - Home screen UI
- `lib/utils/constants.dart` - Constants & theming
- `lib/models/` - Data models
- `pubspec.yaml` - Dependencies & assets
- `.vscode/launch.json` - Debug configurations
- `.vscode/tasks.json` - Build tasks

## 🎯 Langkah Selanjutnya

1. **Jalankan aplikasi** untuk lihat tampilan home screen
2. **Customize constants** di `lib/utils/constants.dart`
3. **Buat screen baru** di folder `lib/screens/`
4. **Implementasi fitur** sesuai roadmap di README.md

## ⚠️ Troubleshooting Cepat

### Error: "No devices found"
- Pastikan emulator sudah running
- Atau HP sudah tersambung dengan USB debugging aktif

### Error: "Gradle build failed"
```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Error: "Waiting for another flutter command to release the startup lock"
```powershell
# Kill proses Flutter yang stuck
taskkill /F /IM dart.exe /T
# Atau restart VS Code
```

### App tidak update saat hot reload
- Coba hot restart (tekan 'R' atau Shift+Ctrl+P → "Flutter: Hot Restart")
- Atau stop dan run ulang

## 💡 Tips Produktivitas

1. **Gunakan Hot Reload** - Save file otomatis reload UI
2. **Widget Inspector** - Shift+Ctrl+P → "Flutter: Open DevTools"
3. **Code Snippets** - Ketik `stless` atau `stful` untuk boilerplate
4. **Format Code** - Shift+Alt+F atau enable format on save

## 📞 Butuh Bantuan?

- 📖 Baca README.md untuk dokumentasi lengkap
- 💬 Tanya Copilot untuk bantuan coding
- 🔍 Check `.github/copilot-instructions.md` untuk context project

---

**Selamat coding! 🚀**

*CV. Duta Technology*
