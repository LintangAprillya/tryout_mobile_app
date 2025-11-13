# 📱 Panduan Lengkap - Menjalankan di Android

## 🎯 **3 Cara Menjalankan Aplikasi di Android**

---

## **Cara 1: Android Emulator (RECOMMENDED - Tidak Perlu HP)** ⭐

### Langkah-langkah:

#### 1. Buka Android Studio
- Start Menu → Android Studio
- Atau cari di Windows Search

#### 2. Buka Device Manager
- Klik **Tools** → **Device Manager**
- Atau klik icon **Phone dengan Android** di toolbar kanan

#### 3. Create Virtual Device (Jika Belum Ada)
- Klik **Create Device**
- Pilih **Phone** → **Pixel 6** (atau model lain)
- Klik **Next**
- Pilih **System Image**: **R (API Level 30)** atau **S (API Level 31)**
- Klik **Next** → **Finish**

#### 4. Start Emulator
- Klik tombol **Play ▶** di samping emulator
- Tunggu emulator booting (2-3 menit pertama kali)

#### 5. Jalankan Aplikasi
```powershell
# Cek apakah emulator sudah terdeteksi
flutter devices

# Jalankan aplikasi
flutter run
```

**Atau di VS Code:**
- Tekan `F5`
- Pilih emulator dari dropdown

---

## **Cara 2: Build APK dan Install ke HP** 📦

### Keuntungan:
- Tidak perlu sambung USB
- Bisa install di HP siapapun
- Performance native

### Langkah-langkah:

#### 1. Build APK Debug
```powershell
flutter build apk --debug
```

**Lokasi APK:**
```
C:\Magang CV. Duta Technology\tryout_apps\build\app\outputs\flutter-apk\app-debug.apk
```

#### 2. Transfer ke HP Android
**Opsi A: Via USB Cable**
- Sambungkan HP ke PC
- Copy file `app-debug.apk` ke folder Download HP
- Buka File Manager di HP → Download
- Tap `app-debug.apk` → Install

**Opsi B: Via WhatsApp/Telegram**
- Kirim file APK ke HP Anda via WA/Telegram
- Download di HP
- Tap file → Install

**Opsi C: Via Google Drive/Dropbox**
- Upload APK ke Drive
- Download di HP
- Install

#### 3. Install APK di HP
- Buka file `app-debug.apk`
- Jika muncul "Install blocked", tap **Settings**
- Aktifkan "Allow from this source"
- Tap **Install**
- Tap **Open** untuk menjalankan

---

## **Cara 3: Sambung HP via USB (Untuk Development)** 🔌

### Jika HP Belum Terdeteksi, Coba Ini:

#### Langkah 1: Install Universal ADB Driver
```powershell
# Download driver dari:
# https://adb.clockworkmod.com/
```

**Atau gunakan driver HP Anda:**
- Samsung: Samsung USB Driver
- Xiaomi: Mi PC Suite
- Oppo: Oppo PC Suite
- Vivo: Vivo PC Suite

#### Langkah 2: Enable USB Debugging (Ulang)
1. **Settings** → **About Phone**
2. Tap **Build Number** 7x → Developer mode aktif
3. **Settings** → **Developer Options**
4. Aktifkan:
   - ✅ USB Debugging
   - ✅ Install via USB
   - ✅ USB debugging (Security settings) - jika ada

#### Langkah 3: Ganti USB Cable/Port
- Coba kabel USB lain
- Coba port USB lain di PC
- Pastikan kabel bisa transfer data (bukan charging only)

#### Langkah 4: Pilih USB Mode yang Benar
Saat sambung USB, di notifikasi HP:
- Tap "USB for charging"
- Pilih **File Transfer** atau **MTP**

#### Langkah 5: Revoke USB Debugging (Reset)
Di HP:
- **Developer Options** → **Revoke USB debugging authorizations**
- Cabut dan sambung lagi USB
- Harus muncul popup "Allow USB debugging?" → **OK**

#### Langkah 6: Restart ADB
```powershell
# Kill ADB server
adb kill-server

# Start ADB server
adb start-server

# Cek devices
adb devices

# Cek Flutter
flutter devices
```

---

## **🚀 Quick Start - Pilihan Tercepat**

### **A. Jika Punya Android Studio → Gunakan Emulator**
```powershell
# 1. Buka Android Studio → Device Manager → Start emulator
# 2. Tunggu booting
# 3. Run di terminal:
flutter run
```

### **B. Jika Tidak Punya Emulator → Build APK**
```powershell
# 1. Build APK
flutter build apk --debug

# 2. File ada di:
# build/app/outputs/flutter-apk/app-debug.apk

# 3. Kirim ke HP via WA/email
# 4. Install di HP
```

### **C. Jika Mau Development Langsung di HP**
```powershell
# 1. Install driver HP
# 2. Enable USB debugging
# 3. Sambung USB → pilih File Transfer
# 4. adb devices (pastikan muncul)
# 5. flutter run
```

---

## **🎯 Rekomendasi Saya:**

### **Untuk Testing Cepat:**
1. ✅ **Build APK** (paling mudah, tidak ribet)
2. ✅ **Android Emulator** (jika mau development terus)

### **Untuk Development:**
1. ✅ **Android Emulator** (paling stabil, hot reload lancar)
2. ⚠️ **Physical Device** (bagus tapi setup ribet)

---

## **📝 Checklist - Build APK Method**

```powershell
# Step 1: Accept licenses
flutter doctor --android-licenses
# Tekan 'y' untuk semua

# Step 2: Build APK debug
flutter build apk --debug

# Step 3: Lokasi file
# C:\Magang CV. Duta Technology\tryout_apps\build\app\outputs\flutter-apk\app-debug.apk

# Step 4: Transfer ke HP (pilih salah satu)
# - Via USB cable
# - Via WhatsApp
# - Via Google Drive
# - Via Email

# Step 5: Install di HP
# - Buka file manager
# - Tap app-debug.apk
# - Install
# - Open
```

---

## **⚡ Super Quick - Build & Install Sekarang!**

**Jalankan command ini sekarang:**

```powershell
# Build APK (tunggu 2-3 menit)
flutter build apk --debug

# Setelah selesai, buka folder ini:
explorer "C:\Magang CV. Duta Technology\tryout_apps\build\app\outputs\flutter-apk"

# File app-debug.apk sudah siap!
# Kirim ke HP Anda via WA/Drive, lalu install
```

---

## **🆘 Masih Bermasalah?**

### **Error: Android licenses not accepted**
```powershell
flutter doctor --android-licenses
# Tekan 'y' untuk semua license
```

### **Error: SDK not found**
```powershell
# Buka Android Studio
# File → Settings → Appearance & Behavior → System Settings → Android SDK
# Centang Android 11.0 (R) atau 12.0 (S)
# Apply → OK
```

### **Emulator Lemot**
- Pastikan Virtualization aktif di BIOS
- Buka Task Manager → Performance → CPU → Virtualization: Enabled
- Jika disabled, restart PC → masuk BIOS → enable VT-x/AMD-V

---

## **💡 Tips**

1. **Emulator** lebih cepat untuk development (hot reload instant)
2. **APK** lebih praktis untuk testing/demo ke orang lain
3. **Physical device** paling akurat untuk test performance

---

**Mau saya bantu yang mana?**
1. Setup Android Emulator?
2. Build APK sekarang?
3. Troubleshoot USB connection?
