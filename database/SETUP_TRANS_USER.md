# Cara Setup Data Trans User

## 🎯 Langkah-langkah

### 1. Insert Data ke Database

Buka **phpMyAdmin** atau **MySQL client**, lalu:

1. Pilih database `tryout_db`
2. Klik tab **SQL**
3. Copy paste isi file `seed_trans_user.sql`
4. Klik **Go** / **Execute**

**Atau jalankan via command line:**
```bash
mysql -u root -p tryout_db < seed_trans_user.sql
```

### 2. Verifikasi Data

Jalankan query ini untuk cek data:
```sql
SELECT 
    tu.id_trans_user,
    u.name as user_name,
    js.jenis_soal as jenis_soal_name,
    tu.status,
    tu.total_benar,
    tu.total_salah,
    tu.nilai
FROM trans_user tu
LEFT JOIN users u ON tu.id_user = u.id
LEFT JOIN jenis_soal js ON tu.id_jenis_soal = js.id_jenis_soal
ORDER BY tu.created_at DESC;
```

### 3. Pastikan Backend API Running

Jalankan PHP server:
```bash
cd c:\Magang CV. Duta Technology\tryout_api
php -S localhost:8000
```

### 4. Test API Endpoint

Buka browser atau Postman, test:
```
GET http://localhost:8000/api/trans-user.php
```

Atau via curl:
```bash
curl http://localhost:8000/api/trans-user.php
```

**Expected Response:**
```json
[
  {
    "id_trans_user": 1,
    "id_user": 1,
    "id_jenis_soal": 1,
    "status": "selesai",
    "waktu_mulai": "2024-11-20 09:00:00",
    "waktu_berakhir": "2024-11-20 10:30:00",
    "total_benar": 18,
    "total_salah": 2,
    "nilai": 90.0,
    "user_name": "Admin User",
    "jenis_soal_name": "Bahasa Indonesia",
    "created_at": "2024-11-21 12:00:00",
    "updated_at": "2024-11-21 12:00:00"
  }
]
```

### 5. Refresh Flutter App

Di terminal Flutter yang running:
- Press `r` untuk hot reload
- Atau `R` untuk hot restart

### 6. Akses Trans User Page

Di aplikasi:
1. **Dari Dashboard** → Tap menu drawer (☰) → **PENGGUNA** → **Transaksi User**
2. **Atau via Quick Access** → Tap card **Trans User**

## 📊 Sample Data yang Diinsert

Total: **15 transaksi**

### Breakdown by Status:
- ✅ **Selesai**: 10 transaksi
- ⏳ **Sedang mengerjakan**: 3 transaksi  
- 📋 **Belum**: 2 transaksi

### Breakdown by User:
- **User 1**: 3 transaksi (2 selesai, 1 belum)
- **User 2**: 3 transaksi (2 selesai, 1 sedang)
- **User 3**: 2 transaksi (1 selesai, 1 belum)
- **User 4**: 3 transaksi (2 selesai, 1 sedang)
- **User 5**: 3 transaksi (2 selesai, 1 sedang)

### Breakdown by Jenis Soal:
- Bahasa Indonesia: 3 transaksi
- Bahasa Inggris: 3 transaksi
- Matematika: 2 transaksi
- Pengetahuan Umum: 2 transaksi
- Pengetahuan Kuantitatif: 2 transaksi
- Penalaran: 2 transaksi
- Pengetahuan & Penalaran Umum: 1 transaksi

### Nilai Range:
- 🏆 **Sangat Baik (90-100)**: 3 transaksi
- 🎯 **Baik (80-89)**: 2 transaksi
- ✓ **Cukup (70-79)**: 2 transaksi
- ⚠️ **Kurang (60-69)**: 2 transaksi
- ❌ **Sangat Kurang (<60)**: 1 transaksi

## 🔍 Troubleshooting

### Problem: API returns empty array `[]`

**Solution:**
1. Cek apakah data sudah masuk ke database:
   ```sql
   SELECT COUNT(*) FROM trans_user;
   ```
2. Cek struktur tabel `trans_user`
3. Pastikan foreign key `id_user` dan `id_jenis_soal` valid

### Problem: API endpoint 404 Not Found

**Solution:**
1. Pastikan file `trans-user.php` ada di folder `tryout_api/api/`
2. Restart PHP server:
   ```bash
   php -S localhost:8000
   ```
3. Cek base URL di `api_service.dart`:
   ```dart
   final String baseUrl = 'http://localhost:8000/api';
   ```

### Problem: Flutter shows "Error: Failed to load transactions"

**Solution:**
1. Cek API response di browser dulu
2. Cek model `TransUser` apakah sesuai dengan response
3. Lihat console Flutter untuk detail error
4. Pastikan internet permission sudah diset (untuk web/Android)

### Problem: Data tidak muncul di list

**Solution:**
1. Cek filter status - ubah ke "Semua"
2. Cek search bar - kosongkan jika ada text
3. Pull to refresh (swipe down)
4. Restart aplikasi

## 📝 SQL Query Reference

### Count Total Transactions
```sql
SELECT COUNT(*) FROM trans_user;
```

### Count by Status
```sql
SELECT status, COUNT(*) as total 
FROM trans_user 
GROUP BY status;
```

### Average Score per Jenis Soal
```sql
SELECT 
    js.jenis_soal,
    ROUND(AVG(tu.nilai), 2) as avg_nilai,
    COUNT(*) as total_trans
FROM trans_user tu
JOIN jenis_soal js ON tu.id_jenis_soal = js.id_jenis_soal
WHERE tu.nilai IS NOT NULL
GROUP BY js.jenis_soal
ORDER BY avg_nilai DESC;
```

### Top Performers
```sql
SELECT 
    u.name,
    COUNT(*) as total_tryout,
    ROUND(AVG(tu.nilai), 2) as avg_nilai
FROM trans_user tu
JOIN users u ON tu.id_user = u.id
WHERE tu.nilai IS NOT NULL
GROUP BY u.name
ORDER BY avg_nilai DESC;
```

### Recent Activity
```sql
SELECT 
    u.name,
    js.jenis_soal,
    tu.status,
    tu.nilai,
    tu.created_at
FROM trans_user tu
JOIN users u ON tu.id_user = u.id
JOIN jenis_soal js ON tu.id_jenis_soal = js.id_jenis_soal
ORDER BY tu.created_at DESC
LIMIT 10;
```

## ✅ Checklist

- [ ] Database `tryout_db` ready
- [ ] Tabel `trans_user` exists
- [ ] Tabel `users` has data (id 1-5)
- [ ] Tabel `jenis_soal` has data (id 1-7)
- [ ] SQL file executed successfully
- [ ] Data verified in phpMyAdmin
- [ ] PHP server running on port 8000
- [ ] API endpoint accessible
- [ ] Flutter app running
- [ ] Trans User page accessible
- [ ] Data displayed correctly

## 🎉 Expected Result

Setelah semua langkah dilakukan, di **Trans User Screen** akan muncul:

### Statistics Cards
- **Total**: 15
- **Selesai**: 10
- **Proses**: 3

### Transaction List
15 cards dengan informasi:
- User name
- Jenis soal
- Status badge (colored)
- Benar, Salah, Nilai
- Timestamp

### Features Working
- ✅ Search by user name
- ✅ Search by jenis soal
- ✅ Filter by status
- ✅ View detail dialog
- ✅ Pull to refresh
- ✅ Scroll list

---

**File Location:**
- SQL: `database/seed_trans_user.sql`
- PHP: `database/seed_trans_user.php` (alternative)
- API: `tryout_api/api/trans-user.php`
- Screen: `lib/screens/admin/trans_user_screen.dart`
