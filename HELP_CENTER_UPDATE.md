# Update Help Center & Help Support

## 📋 Overview
Dokumentasi update konten untuk fitur Help Center dan Help Support pada aplikasi Tryout Apps.

## ✅ Changes Made

### 1. Help Center Screen (`help_center_screen.dart`)

#### **Tab 1: Manual Book**
**Konten Baru:**
- **Intro Section**: Selamat datang dan deskripsi aplikasi
- **Fitur Utama** (4 items):
  - Bank Soal Lengkap
  - Timer Real-time
  - Analisis Hasil
  - Ranking & Kompetisi
- **Cara Penggunaan** (4 steps):
  1. Registrasi Akun
  2. Pilih Paket Tryout
  3. Mulai Mengerjakan
  4. Submit & Review
- **Syarat & Ketentuan** (5 items):
  1. Validitas informasi akun
  2. Larangan kecurangan
  3. Hak cipta konten
  4. Hak perubahan kebijakan
  5. Tanggung jawab keamanan akun

**Widget Baru:**
- `_buildFeatureItem()`: Card dengan icon, title, description untuk fitur
- `_buildStepItem()`: Numbered step dengan circle badge untuk panduan
- `_buildTermItem()`: Existing (updated content only)

#### **Tab 2: Contact Us**
**Konten Baru:**
- **Jam Operasional**: Info box dengan jam layanan
  - Senin-Jumat: 08:00-17:00 WIB
  - Sabtu-Minggu: 09:00-15:00 WIB
- **Contact Cards** (5 items):
  1. Customer Service: +62 812-3456-7890
  2. Email Support: support@tryoutapps.com
  3. Website: www.tryoutapps.com
  4. WhatsApp: +62 812-3456-7890
  5. Kantor: Jl. Contoh No. 123, Jakarta Selatan

**Updates:**
- `_buildContactCard()`: Added `detail` parameter untuk menampilkan info kontak lengkap

---

### 2. Help Support Screen (`help_support_screen.dart`)

#### **FAQ Section - Pertanyaan Umum**
Updated dari 3 → 8 FAQ items:

1. **Bagaimana cara mendaftar akun?**
   - Detail proses registrasi dan verifikasi email

2. **Bagaimana cara mengerjakan tryout?**
   - 7 langkah step-by-step dari login sampai lihat hasil

3. **Apakah ada batas waktu mengerjakan?**
   - Info timer dan auto-submit

4. **Bagaimana cara melihat hasil tryout?**
   - Detail info hasil: skor, pembahasan, analisis, ranking

5. **Apakah bisa mengerjakan ulang tryout yang sama?**
   - Perbedaan tryout gratis vs berbayar

6. **Bagaimana cara reset password?**
   - Langkah lupa password via email

7. **Apakah data tryout saya aman?**
   - Jaminan keamanan dan privasi data

8. **Bagaimana cara upgrade ke paket premium?**
   - Proses pembelian paket premium

#### **Existing Features (No Changes)**
- Search bar
- 4 Kategori Bantuan:
  - Akun & Profil
  - Tryout & Ujian
  - Pembayaran
  - Ranking & Skor
- Contact Support button

---

## 🎨 UI Components

### New Components
```dart
_buildFeatureItem({
  required IconData icon,
  required String title,
  required String description,
})
```
- White card dengan shadow
- Icon dalam colored circle box
- Title dan description

```dart
_buildStepItem({
  required int number,
  required String title,
  required String description,
})
```
- Numbered circle badge (primary color)
- Title dengan bold
- Description dengan secondary text

### Updated Components
```dart
_buildContactCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required String detail,  // NEW
  required Color color,
  required VoidCallback onTap,
})
```
- Added `detail` parameter untuk info kontak
- Display 3 lines: title, subtitle, detail (colored)

---

## 📱 User Journey

### Help Center Flow
1. User tap "Help Center" dari home
2. Default tab: **Manual Book**
   - Baca intro dan fitur utama
   - Pahami cara penggunaan (4 steps)
   - Review syarat & ketentuan
3. Switch tab: **Contact Us**
   - Lihat jam operasional
   - Pilih metode kontak (call/email/web/WA/visit)

### Help Support Flow
1. User tap "Help Support" dari home
2. Optional: Search bantuan dengan keyword
3. Browse **Kategori Bantuan** (4 kategori)
4. Scroll down ke **Pertanyaan Umum** (8 FAQ)
5. Expand FAQ yang relevan untuk jawaban detail
6. Jika tidak menemukan: Tap "Hubungi Customer Service"

---

## 🔗 Integration Points

### Kontak Actions (TODO - Implementasi Nanti)
```dart
// Customer Service: tel: link atau in-app call
// Email: mailto: link
// Website: url_launcher ke browser
// WhatsApp: whatsapp:// deep link
// Kantor: geo: link atau Google Maps
```

### Navigasi Kategori (TODO - Implementasi Nanti)
```dart
// Akun & Profil → Detail help page
// Tryout & Ujian → Detail help page
// Pembayaran → Detail help page
// Ranking & Skor → Detail help page
```

---

## 📊 Content Stats

### Help Center
- **Total Sections**: 5 (Intro, Fitur, Cara Pakai, S&K, Kontak)
- **Feature Items**: 4
- **Tutorial Steps**: 4
- **Terms**: 5
- **Contact Methods**: 5

### Help Support
- **Categories**: 4
- **FAQ Items**: 8 (naik dari 3)
- **Avg Answer Length**: ~3-5 sentences

---

## 🚀 Next Steps

### Phase 1: URL Launcher (Priority)
- [ ] Install `url_launcher` package
- [ ] Implement WhatsApp deep link
- [ ] Implement email mailto
- [ ] Implement website URL
- [ ] Implement phone call (optional)

### Phase 2: Detail Pages
- [ ] Create `AccountHelpDetailScreen`
- [ ] Create `ExamHelpDetailScreen`
- [ ] Create `PaymentHelpDetailScreen`
- [ ] Create `RankingHelpDetailScreen`

### Phase 3: Search Functionality
- [ ] Implement search filter untuk FAQ
- [ ] Add search history
- [ ] Suggestion untuk keyword populer

### Phase 4: Content Enhancement
- [ ] Add screenshots untuk tutorial
- [ ] Add video tutorial (embed YouTube)
- [ ] Add PDF download untuk manual lengkap
- [ ] Multilanguage support (EN)

---

## ✨ Testing Checklist

- [x] Manual Book tab menampilkan semua konten
- [x] Contact Us tab menampilkan 5 contact cards
- [x] Help Support menampilkan 8 FAQ
- [ ] Semua FAQ accordion bisa expand/collapse
- [ ] Contact cards show snackbar saat di-tap
- [ ] Responsive di berbagai screen size
- [ ] No overflow pada text panjang
- [ ] Scroll smooth di semua section

---

## 📝 Notes

- Konten info kontak (nomor telpon, email, alamat) masih **placeholder**
- Perlu disesuaikan dengan data real perusahaan
- Action pada contact cards masih dummy (snackbar only)
- Perlu implementasi real action dengan `url_launcher`
- Search bar belum functional (UI only)
- Kategori bantuan belum ada detail page

---

**Created**: $(date)
**Last Updated**: $(date)
**Status**: ✅ Content Complete, ⏳ Actions Pending
