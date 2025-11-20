# Admin Dashboard - Help Center Navigation

## 📍 Cara Akses Help Center dari Admin Dashboard

### Option 1: Via Drawer (Side Menu)
1. Buka **Admin Dashboard**
2. Tap icon menu (☰) di kiri atas
3. Scroll ke section **BANTUAN**
4. Pilih:
   - **Panduan Aplikasi** → Buka Help Center Screen
   - **Help Desk** → Buka Help Support Screen

### Option 2: Via Quick Access Menu
1. Buka **Admin Dashboard**
2. Scroll ke section **Menu Cepat**
3. Tap card:
   - **Panduan** (icon help_center, warna orange)
   - **Help Desk** (icon support_agent, warna purple)

---

## 🔧 Technical Implementation

### File Updated
**`lib/screens/admin/admin_dashboard_screen.dart`**

### Changes Made

#### 1. Import Statements
```dart
import '../help_center_screen.dart';
import '../help_support_screen.dart';
```

#### 2. Drawer Navigation - Panduan Aplikasi
```dart
_buildDrawerItem(
  icon: Icons.help_center,
  title: 'Panduan Aplikasi',
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HelpCenterScreen()),
    );
  },
),
```

#### 3. Drawer Navigation - Help Desk
```dart
_buildDrawerItem(
  icon: Icons.support_agent,
  title: 'Help Desk',
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HelpSupportScreen()),
    );
  },
),
```

#### 4. Quick Access Card - Panduan
```dart
_buildQuickAccessCard(
  icon: Icons.help_center,
  title: 'Panduan',
  color: AppColors.warning,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HelpCenterScreen()),
    );
  },
),
```

#### 5. Quick Access Card - Help Desk
```dart
_buildQuickAccessCard(
  icon: Icons.support_agent,
  title: 'Help Desk',
  color: Colors.purple,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HelpSupportScreen()),
    );
  },
),
```

---

## 🎨 UI Layout

### Drawer Menu Structure
```
┌─────────────────────────┐
│ Admin Tryout            │
│ admin@tryout.com        │
├─────────────────────────┤
│ 📊 Dashboard            │
├─────────────────────────┤
│ SOAL                    │
│ ❓ Kelola Soal         │
│ 📁 Jenis Soal          │
│ ✅ Trans User          │
├─────────────────────────┤
│ PENGGUNA                │
│ 👥 Daftar Pengguna     │
│ 🎖️ Tipe Pengguna       │
├─────────────────────────┤
│ BANTUAN ← NEW!          │
│ ℹ️ Panduan Aplikasi    │ ← Navigate to Help Center
│ 💬 Help Desk           │ ← Navigate to Help Support
├─────────────────────────┤
│ ⚙️ Pengaturan          │
│ 🚪 Keluar              │
└─────────────────────────┘
```

### Quick Access Grid (3 columns)
```
┌─────────┬─────────┬─────────┐
│ Kelola  │ Jenis   │ Peng-   │
│  Soal   │  Soal   │  guna   │
├─────────┼─────────┼─────────┤
│ Trans   │ Panduan │  Help   │
│  User   │    ℹ️   │  Desk   │
│         │  NEW!   │  💬NEW! │
└─────────┴─────────┴─────────┘
```

---

## 🧪 Testing Checklist

### Drawer Navigation
- [ ] Tap menu icon → drawer opens
- [ ] Scroll ke section BANTUAN
- [ ] Tap "Panduan Aplikasi" → opens Help Center
- [ ] Back button returns to dashboard
- [ ] Tap "Help Desk" → opens Help Support
- [ ] Back button returns to dashboard
- [ ] Drawer closes after navigation

### Quick Access Cards
- [ ] Scroll dashboard ke "Menu Cepat"
- [ ] Tap "Panduan" card → opens Help Center
- [ ] Verify orange color card
- [ ] Back to dashboard
- [ ] Tap "Help Desk" card → opens Help Support
- [ ] Verify purple color card
- [ ] Back to dashboard

### Help Center Screen
- [ ] Default tab: Manual Book displayed
- [ ] Tab bisa switch ke Contact Us
- [ ] All content readable
- [ ] Contact cards functional (show snackbar)

### Help Support Screen
- [ ] 4 Kategori cards displayed
- [ ] 8 FAQ items displayed
- [ ] FAQ accordion expand/collapse works
- [ ] Contact Support button functional

---

## 📱 User Flow

### Admin → Help Center
```
Admin Dashboard
    ↓ (tap drawer menu)
Drawer Opens
    ↓ (scroll to BANTUAN)
See: Panduan Aplikasi & Help Desk
    ↓ (tap Panduan Aplikasi)
Help Center Screen (Tab: Manual Book)
    ↓ (optional: switch tab)
Contact Us Tab
    ↓ (tap back button)
Return to Admin Dashboard
```

### Admin → Help Support
```
Admin Dashboard
    ↓ (tap Panduan/Help Desk card)
Quick Access Navigation
    ↓ (tap Help Desk)
Help Support Screen
    ↓ (browse FAQ or Categories)
Find Answer
    ↓ (tap back button)
Return to Admin Dashboard
```

---

## 🔄 Navigation Pattern

**Pattern Used**: `Navigator.push()` with `MaterialPageRoute`

**Benefits**:
- ✅ Simple stack navigation
- ✅ Back button automatically handled
- ✅ Maintains dashboard state
- ✅ Clean navigation history

**Alternative (Future Enhancement)**:
- Named routes: `/admin/help-center`
- Deep linking support
- Navigation with arguments

---

## 💡 Future Enhancements

### Phase 1: Search Integration
- [ ] Add search bar di Help Center
- [ ] Search across FAQ content
- [ ] Recent searches

### Phase 2: Admin-Specific Help
- [ ] Create admin tutorial pages
- [ ] How to manage soal
- [ ] How to manage users
- [ ] Dashboard analytics guide

### Phase 3: Context-Sensitive Help
- [ ] Show relevant help based on current admin page
- [ ] Floating help button on complex screens
- [ ] Tooltips for first-time users

### Phase 4: Analytics
- [ ] Track most viewed help topics
- [ ] Track search queries
- [ ] Identify missing documentation

---

## 📊 Testing Results

| Feature | Status | Notes |
|---------|--------|-------|
| Drawer → Panduan | ✅ Ready | Opens Help Center |
| Drawer → Help Desk | ✅ Ready | Opens Help Support |
| Quick Access → Panduan | ✅ Ready | Orange card |
| Quick Access → Help Desk | ✅ Ready | Purple card |
| Back Navigation | ✅ Ready | Returns to dashboard |
| Help Center Content | ✅ Ready | All content visible |
| Help Support FAQ | ✅ Ready | 8 FAQ items |

---

**Created**: November 21, 2025
**Status**: ✅ Complete & Ready for Testing
