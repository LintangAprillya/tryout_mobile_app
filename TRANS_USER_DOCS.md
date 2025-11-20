# Dokumentasi Fitur Transaksi User

## 📋 Overview
Halaman **Trans User Screen** adalah fitur untuk mengelola dan memantau transaksi ujian yang dilakukan oleh pengguna. Admin dapat melihat detail transaksi, status pengerjaan, nilai, dan riwayat lengkap dari setiap user.

## 🎯 Fitur Utama

### 1. **Daftar Transaksi**
- Menampilkan semua transaksi user dalam bentuk card
- Informasi lengkap: nama user, jenis soal, status, nilai
- Sorting otomatis berdasarkan tanggal terbaru

### 2. **Search & Filter**
- **Search Bar**: Cari berdasarkan nama user atau jenis soal
- **Status Filter**: Filter berdasarkan status transaksi
  - Semua
  - selesai
  - belum
  - sedang mengerjakan

### 3. **Statistics Dashboard**
- **Total**: Total semua transaksi
- **Selesai**: Transaksi dengan status selesai
- **Proses**: Transaksi sedang mengerjakan

### 4. **Detail Transaksi**
- Dialog popup dengan informasi lengkap:
  - ID Transaksi
  - Nama User & Jenis Soal
  - Status pengerjaan
  - Waktu mulai & berakhir
  - Total benar & salah
  - Nilai akhir
  - Timestamp created & updated

### 5. **Actions**
- **View Detail**: Lihat detail lengkap transaksi
- **Delete**: Hapus transaksi (dengan konfirmasi)
- **Refresh**: Reload data terbaru

## 🎨 UI Components

### Transaction Card
```
┌─────────────────────────────────────────┐
│ 👤 [Nama User]          [Status Badge]  │
│    Jenis Soal                           │
├─────────────────────────────────────────┤
│  ✓ Benar  ✗ Salah  ⭐ Nilai            │
│  📅 Tanggal & Waktu                     │
│                    [Detail] [Hapus]     │
└─────────────────────────────────────────┘
```

### Status Badges
- **selesai** → Green badge with check icon
- **sedang mengerjakan** → Yellow badge with pending icon
- **belum** → Gray badge with schedule icon

### Stat Cards
- Gradient background dengan shadow
- Icon, value, dan label
- Color-coded (Primary, Success, Warning)

## 📊 Data Model

### TransUser
```dart
class TransUser {
  final int idTransUser;
  final int idUser;
  final int idJenisSoal;
  final String status;
  final DateTime? waktuMulai;
  final DateTime? waktuBerakhir;
  final int? totalBenar;
  final int? totalSalah;
  final double? nilai;
  final String? userName;
  final String? jenisSoalName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
```

## 🔌 API Integration

### Endpoints Used
```dart
// Get all transactions
Future<List<TransUser>> getTransactions()

// Get by user ID
Future<List<TransUser>> getTransactionsByUser(int userId)

// Get by jenis soal ID
Future<List<TransUser>> getTransactionsByJenisSoal(int jenisSoalId)

// Delete transaction (TODO)
Future<void> deleteTransaction(int id)
```

## 🚀 Cara Akses

### 1. Dari Dashboard - Drawer Menu
```
Admin Dashboard → Drawer → PENGGUNA → Transaksi User
```

### 2. Dari Dashboard - Quick Access
```
Admin Dashboard → Menu Cepat → Trans User Card
```

## 📱 Fitur Responsif

### Search Real-time
- Filter langsung saat mengetik
- Debounce untuk performa optimal
- Case-insensitive search

### Status Filter
- FilterChip dengan visual feedback
- Multi-select capability
- Instant filtering

### Pull to Refresh
- Swipe down untuk refresh data
- Loading indicator saat fetch
- Auto-reload setelah delete

## 🎨 Color Scheme

### Status Colors
```dart
selesai           → AppColors.success (Green)
sedang mengerjakan → AppColors.warning (Orange)
belum             → AppColors.textSecondary (Gray)
```

### Card Colors
```dart
Total Stats   → AppColors.primary (Blue)
Selesai Stats → AppColors.success (Green)
Proses Stats  → AppColors.warning (Orange)
```

## 🔍 Empty State

Ketika tidak ada data:
```
📦 Icon inbox
"Tidak ada transaksi"
"Data transaksi akan muncul di sini"
```

## 📐 Layout Structure

```
TransUserScreen
├── AppBar (Title + Refresh)
├── Search & Filter Container
│   ├── Search TextField
│   └── Status Filter Chips
├── Statistics Cards Row
│   ├── Total Card
│   ├── Selesai Card
│   └── Proses Card
└── Transaction List (Scrollable)
    └── Transaction Cards
        ├── User Avatar & Info
        ├── Status Badge
        ├── Stats (Benar, Salah, Nilai)
        ├── Timestamp
        └── Action Buttons
```

## 🎯 User Flows

### View Transaction Detail
```
1. Tap pada Transaction Card
2. Dialog muncul dengan detail lengkap
3. Scroll untuk lihat semua info
4. Tap "Tutup" untuk kembali
```

### Delete Transaction
```
1. Tap tombol "Hapus" pada card
2. Konfirmasi dialog muncul
3. Tap "Hapus" untuk confirm
4. Data di-delete
5. List di-refresh otomatis
6. Snackbar notifikasi sukses
```

### Search & Filter
```
1. Ketik nama/jenis soal di search bar
2. Hasil langsung ter-filter
3. Tap status chip untuk filter lebih lanjut
4. Kombinasi search + status filter bekerja
```

## 🔧 Technical Details

### State Management
- **Local State**: `setState()` untuk UI updates
- **Loading State**: `_isLoading` boolean
- **Data State**: 
  - `_allTransactions`: Raw data dari API
  - `_filteredTransactions`: Data setelah filtering

### Performance Optimization
- ListView.builder untuk efficient rendering
- Lazy loading dengan pagination (TODO)
- Debounce search untuk reduce API calls
- Local filtering (tidak hit API setiap filter)

### Error Handling
```dart
try {
  await _apiService.getTransactions();
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
  );
}
```

## 📦 Dependencies

```yaml
dependencies:
  intl: ^0.18.0  # Date formatting
  http: ^1.1.0   # API calls (via ApiService)
```

## 🎭 Animations

### Card Entrance
- Staggered fade-in effect
- Subtle scale animation

### Filter Chips
- Ripple effect on tap
- Color transition on select
- Checkmark animation

### Dialog
- Fade + scale entrance
- Smooth slide from bottom

## 🔐 Validations

### Before Delete
- Confirmation dialog required
- Cannot be undone warning

### Empty Data
- Show empty state
- Provide helpful message

## 🚧 TODO / Future Enhancements

### Phase 1: API Integration
- [ ] Implement delete transaction API
- [ ] Add edit transaction capability
- [ ] Implement pagination for large datasets
- [ ] Add export to Excel/PDF

### Phase 2: Advanced Filtering
- [ ] Date range filter (from - to)
- [ ] Multiple status selection
- [ ] Sort by: nama, tanggal, nilai
- [ ] Advanced search (by ID, email, etc.)

### Phase 3: Analytics
- [ ] Transaction trend chart
- [ ] Average score per jenis soal
- [ ] Completion rate graph
- [ ] Time-based statistics

### Phase 4: Bulk Actions
- [ ] Select multiple transactions
- [ ] Bulk delete
- [ ] Bulk export
- [ ] Bulk status update

### Phase 5: Real-time Updates
- [ ] WebSocket integration
- [ ] Live transaction updates
- [ ] Push notifications for new transactions
- [ ] Real-time status changes

## 🧪 Testing Checklist

### UI Testing
- [ ] All cards render correctly
- [ ] Search bar functional
- [ ] Filter chips work properly
- [ ] Stat cards show correct counts
- [ ] Empty state appears when no data
- [ ] Loading state shows spinner

### Functionality Testing
- [ ] API fetch successful
- [ ] Search filters correctly
- [ ] Status filter works
- [ ] Detail dialog opens
- [ ] Delete confirmation works
- [ ] Refresh reloads data

### Responsive Testing
- [ ] Works on small screens
- [ ] Works on large screens
- [ ] Horizontal scroll if needed
- [ ] Touch targets appropriate size

### Error Testing
- [ ] API error handled gracefully
- [ ] No crash on empty response
- [ ] Null safety implemented
- [ ] Network timeout handled

## 📝 Code Structure

### Main Widget
```dart
TransUserScreen (StatefulWidget)
├── _TransUserScreenState
│   ├── Variables
│   │   ├── _apiService
│   │   ├── _allTransactions
│   │   ├── _filteredTransactions
│   │   ├── _isLoading
│   │   ├── _searchQuery
│   │   └── _selectedStatus
│   ├── Methods
│   │   ├── _loadTransactions()
│   │   ├── _applyFilters()
│   │   ├── _showTransactionDetail()
│   │   └── _deleteTransaction()
│   └── Build Methods
│       ├── build()
│       ├── _buildStatCard()
│       ├── _buildTransactionCard()
│       ├── _buildInfoItem()
│       └── _buildEmptyState()
└── Helper Widgets
    └── _TransactionDetailDialog
```

## 🎓 Best Practices Applied

✅ **Clean Architecture**: Separation of concerns (UI, Logic, Data)
✅ **Null Safety**: Proper null handling throughout
✅ **Error Handling**: Try-catch blocks with user feedback
✅ **Performance**: Efficient list rendering with ListView.builder
✅ **UX**: Loading states, empty states, error states
✅ **Accessibility**: Semantic labels, touch targets
✅ **Code Quality**: Named parameters, const constructors
✅ **Documentation**: Comments for complex logic

## 📊 Sample Data Structure

```json
{
  "id_trans_user": 1,
  "id_user": 5,
  "id_jenis_soal": 2,
  "status": "selesai",
  "waktu_mulai": "2024-11-21 10:00:00",
  "waktu_berakhir": "2024-11-21 12:00:00",
  "total_benar": 45,
  "total_salah": 15,
  "nilai": 85.5,
  "user_name": "John Doe",
  "jenis_soal_name": "Matematika",
  "created_at": "2024-11-21 09:55:00",
  "updated_at": "2024-11-21 12:05:00"
}
```

## 🔗 Related Files

- **Model**: `lib/models/trans_user.dart`
- **Service**: `lib/services/api_service.dart`
- **Screen**: `lib/screens/admin/trans_user_screen.dart`
- **Dashboard**: `lib/screens/admin/admin_dashboard_screen.dart`
- **Constants**: `lib/utils/constants.dart`

---

**Created**: November 21, 2024  
**Last Updated**: November 21, 2024  
**Version**: 1.0.0  
**Status**: ✅ Complete & Ready for Testing
