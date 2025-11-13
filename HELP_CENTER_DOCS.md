# Help Center & Contact Us - Documentation

## 📋 Overview
Fitur Help Center dan Contact Us yang telah dibuat dengan desain Material Design modern dan user-friendly.

## 🎨 Screens yang Dibuat

### 1. **Help Center Screen** (`help_center_screen.dart`)
Screen utama dengan 2 tab:
- **Manual Book Tab**: Berisi panduan penggunaan, terms & conditions
- **Contact Us Tab**: Daftar cara menghubungi support

**Fitur:**
- ✅ Custom gradient header
- ✅ Search bar
- ✅ Tab navigation
- ✅ Expandable content
- ✅ Contact cards dengan icon

### 2. **Contact Us Screen** (`contact_us_screen.dart`)
Screen khusus untuk kontak informasi:
- Customer Service card
- Website card
- WhatsApp card
- Jam operasional info

**Fitur:**
- ✅ Gradient header
- ✅ Icon dengan circular background
- ✅ Clickable cards
- ✅ Additional info section

### 3. **Help Support Screen** (`help_support_screen.dart`)
Screen untuk pusat bantuan dengan FAQ:
- Search functionality
- Category cards
- FAQ dengan ExpansionTile
- Contact support button

**Fitur:**
- ✅ Search bar
- ✅ Category cards dengan icon
- ✅ Expandable FAQ
- ✅ CTA button untuk customer service

## 🚀 Cara Akses

### Dari Home Screen:
1. **Via AppBar Icons:**
   - Icon "?" → Help Center Screen
   - Icon "Support Agent" → Help Support Screen

2. **Via Quick Access Section:**
   - Card "Help Center" → Help Center Screen
   - Card "Contact Us" → Contact Us Screen

## 🎯 UI/UX Features

### Design Elements:
- ✅ **Material Design 3** compliance
- ✅ **Gradient headers** untuk visual menarik
- ✅ **Card-based layout** untuk readability
- ✅ **Circular icon backgrounds** untuk konsistensi
- ✅ **Color-coded categories** untuk identifikasi mudah
- ✅ **Responsive spacing** menggunakan AppSpacing constants

### Interactions:
- ✅ **Ripple effects** pada tap
- ✅ **Smooth transitions** antar screen
- ✅ **Tab navigation** untuk multi-content
- ✅ **Expandable FAQ** untuk info tambahan
- ✅ **Search functionality** (ready for implementation)

## 📱 Screenshots Reference

Desain mengikuti mockup yang diberikan:
1. Help Center dengan Manual Book content
2. Help Center dengan Contact Us tab
3. Help Support dengan FAQ categories

## 🔧 Customization

### Mengubah Konten:

**Terms & Conditions:**
```dart
// Di help_center_screen.dart - _buildManualBookTab()
_buildTermItem(
  number: 1,
  text: 'Your custom term text here',
),
```

**Contact Info:**
```dart
// Di contact_us_screen.dart - _buildContactUsTab()
_buildContactCard(
  icon: Icons.your_icon,
  title: 'Your Title',
  subtitle: 'Your subtitle or contact info',
  description: 'Description text',
  color: AppColors.yourColor,
  onTap: () {
    // Your action
  },
),
```

**FAQ Categories:**
```dart
// Di help_support_screen.dart
_buildCategoryCard(
  icon: Icons.your_icon,
  title: 'Category Title',
  description: 'Category description',
  color: AppColors.yourColor,
  onTap: () {
    // Navigate to category detail
  },
),
```

## 🔗 Integration Tasks

### TODO - Implementasi Fungsionalitas:

1. **Search Functionality:**
   ```dart
   // Implement search logic di onChanged
   onChanged: (value) {
     // Filter content based on search query
   }
   ```

2. **Contact Actions:**
   ```dart
   // WhatsApp
   import 'package:url_launcher/url_launcher.dart';
   final uri = Uri.parse('https://wa.me/628123456789');
   await launchUrl(uri);
   
   // Email
   final emailUri = Uri.parse('mailto:support@example.com');
   await launchUrl(emailUri);
   
   // Website
   final webUri = Uri.parse('https://www.example.com');
   await launchUrl(webUri);
   ```

3. **Dynamic Content:**
   ```dart
   // Load dari API atau local storage
   Future<List<FAQ>> loadFAQs() async {
     // Fetch from API
   }
   ```

## 📦 Dependencies (Optional)

Untuk fitur lengkap, tambahkan:
```yaml
dependencies:
  url_launcher: ^6.2.1  # Untuk open links, WhatsApp, email
  flutter_html: ^3.0.0  # Untuk HTML content di manual book
```

## 🎨 Color Scheme

Menggunakan colors dari `constants.dart`:
- **Primary**: Blue (#2196F3) - Headers, main actions
- **Success**: Green (#4CAF50) - WhatsApp, positive actions
- **Info**: Blue (#2196F3) - Website, informational
- **Accent**: Orange (#FF9800) - CTA buttons

## ✅ Checklist

- [x] Help Center Screen dengan tab navigation
- [x] Contact Us Screen standalone
- [x] Help Support Screen dengan FAQ
- [x] Integration ke Home Screen
- [x] Material Design compliance
- [x] Responsive layout
- [x] Color-coded categories
- [x] Icon-based navigation
- [ ] Implement search functionality
- [ ] Connect contact actions (WhatsApp, email, web)
- [ ] Load dynamic content from API
- [ ] Add analytics tracking

## 🚀 Next Steps

1. **Test UI di berbagai device sizes**
2. **Implement url_launcher untuk contact actions**
3. **Connect ke backend API untuk dynamic content**
4. **Add analytics untuk track user interactions**
5. **Implement deep linking untuk direct access**

---

**Created with ❤️ for Tryout Apps**
*CV. Duta Technology*
