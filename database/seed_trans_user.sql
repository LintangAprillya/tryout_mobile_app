-- SQL Script untuk Insert Data trans_user
-- File: seed_trans_user.sql
-- Jalankan di phpMyAdmin atau MySQL client

USE tryout_db;

-- Insert sample trans_user data
INSERT INTO trans_user (id_user, id_jenis_soal, status, waktu_mulai, waktu_berakhir, total_benar, total_salah, nilai, created_at, updated_at) VALUES
-- User 1 - Selesai dengan nilai bagus
(1, 1, 'selesai', '2024-11-20 09:00:00', '2024-11-20 10:30:00', 18, 2, 90.0, NOW(), NOW()),
(1, 2, 'selesai', '2024-11-19 14:00:00', '2024-11-19 15:45:00', 16, 4, 80.0, NOW(), NOW()),

-- User 2 - Sedang mengerjakan & Selesai
(2, 3, 'sedang mengerjakan', '2024-11-21 08:30:00', NULL, NULL, NULL, NULL, NOW(), NOW()),
(2, 1, 'selesai', '2024-11-18 10:00:00', '2024-11-18 11:20:00', 14, 6, 70.0, NOW(), NOW()),

-- User 3 - Belum & Selesai
(3, 2, 'belum', NULL, NULL, NULL, NULL, NULL, NOW(), NOW()),
(3, 4, 'selesai', '2024-11-21 07:00:00', '2024-11-21 08:15:00', 19, 1, 95.0, NOW(), NOW()),

-- User 4 - Multiple selesai
(4, 5, 'selesai', '2024-11-20 13:00:00', '2024-11-20 14:30:00', 15, 5, 75.0, NOW(), NOW()),
(4, 6, 'selesai', '2024-11-19 09:00:00', '2024-11-19 10:45:00', 17, 3, 85.0, NOW(), NOW()),

-- User 5 - Sedang mengerjakan & Selesai
(5, 7, 'sedang mengerjakan', '2024-11-21 10:00:00', NULL, NULL, NULL, NULL, NOW(), NOW()),
(5, 3, 'selesai', '2024-11-17 11:00:00', '2024-11-17 12:30:00', 10, 10, 50.0, NOW(), NOW()),

-- Additional diverse data
(1, 5, 'belum', NULL, NULL, NULL, NULL, NULL, NOW(), NOW()),
(2, 4, 'selesai', '2024-11-16 15:00:00', '2024-11-16 16:20:00', 12, 8, 60.0, NOW(), NOW()),
(3, 6, 'selesai', '2024-11-15 08:00:00', '2024-11-15 09:30:00', 18, 2, 90.0, NOW(), NOW()),
(4, 1, 'sedang mengerjakan', '2024-11-21 11:30:00', NULL, NULL, NULL, NULL, NOW(), NOW()),
(5, 2, 'selesai', '2024-11-14 09:00:00', '2024-11-14 10:15:00', 13, 7, 65.0, NOW(), NOW());

-- Verify inserted data
SELECT 
    tu.id_trans_user,
    u.name as user_name,
    js.jenis_soal as jenis_soal_name,
    tu.status,
    tu.total_benar,
    tu.total_salah,
    tu.nilai,
    tu.created_at
FROM trans_user tu
LEFT JOIN users u ON tu.id_user = u.id
LEFT JOIN jenis_soal js ON tu.id_jenis_soal = js.id_jenis_soal
ORDER BY tu.created_at DESC;
