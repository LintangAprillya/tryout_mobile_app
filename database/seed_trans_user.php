<?php
/**
 * Seed Data untuk Tabel trans_user
 * File: seed_trans_user.php
 * 
 * CARA PAKAI:
 * 1. Pastikan database tryout_db sudah ada
 * 2. Jalankan: php seed_trans_user.php
 * 3. Atau akses via browser: http://localhost:8000/seed_trans_user.php
 */

// Database configuration
$host = 'localhost';
$dbname = 'tryout_db';
$username = 'root';
$password = '';

try {
    // Create PDO connection
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== SEED TRANS USER DATA ===\n\n";
    echo "Connected to database successfully.\n\n";
    
    // Cek apakah sudah ada data
    $stmt = $conn->query("SELECT COUNT(*) FROM trans_user");
    $existingCount = $stmt->fetchColumn();
    
    if ($existingCount > 0) {
        echo "Warning: Found $existingCount existing records in trans_user table.\n";
        echo "Do you want to add more sample data? (This will not delete existing data)\n";
    }
    
    // Sample transactions data
    $transactions = [
        // User 1 - Selesai dengan nilai bagus
        [
            'id_user' => 1,
            'id_jenis_soal' => 1, // Bahasa Indonesia
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-20 09:00:00',
            'waktu_berakhir' => '2024-11-20 10:30:00',
            'total_benar' => 18,
            'total_salah' => 2,
            'nilai' => 90.0
        ],
        [
            'id_user' => 1,
            'id_jenis_soal' => 2, // Bahasa Inggris
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-19 14:00:00',
            'waktu_berakhir' => '2024-11-19 15:45:00',
            'total_benar' => 16,
            'total_salah' => 4,
            'nilai' => 80.0
        ],
        
        // User 2 - Sedang mengerjakan
        [
            'id_user' => 2,
            'id_jenis_soal' => 3, // Matematika
            'status' => 'sedang mengerjakan',
            'waktu_mulai' => '2024-11-21 08:30:00',
            'waktu_berakhir' => null,
            'total_benar' => null,
            'total_salah' => null,
            'nilai' => null
        ],
        
        // User 2 - Selesai dengan nilai sedang
        [
            'id_user' => 2,
            'id_jenis_soal' => 1, // Bahasa Indonesia
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-18 10:00:00',
            'waktu_berakhir' => '2024-11-18 11:20:00',
            'total_benar' => 14,
            'total_salah' => 6,
            'nilai' => 70.0
        ],
        
        // User 3 - Belum dikerjakan
        [
            'id_user' => 3,
            'id_jenis_soal' => 2, // Bahasa Inggris
            'status' => 'belum',
            'waktu_mulai' => null,
            'waktu_berakhir' => null,
            'total_benar' => null,
            'total_salah' => null,
            'nilai' => null
        ],
        
        // User 3 - Selesai dengan nilai tinggi
        [
            'id_user' => 3,
            'id_jenis_soal' => 4, // Pengetahuan Umum
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-21 07:00:00',
            'waktu_berakhir' => '2024-11-21 08:15:00',
            'total_benar' => 19,
            'total_salah' => 1,
            'nilai' => 95.0
        ],
        
        // User 4 - Multiple selesai
        [
            'id_user' => 4,
            'id_jenis_soal' => 5, // Pengetahuan Kuantitatif
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-20 13:00:00',
            'waktu_berakhir' => '2024-11-20 14:30:00',
            'total_benar' => 15,
            'total_salah' => 5,
            'nilai' => 75.0
        ],
        [
            'id_user' => 4,
            'id_jenis_soal' => 6, // Penalaran
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-19 09:00:00',
            'waktu_berakhir' => '2024-11-19 10:45:00',
            'total_benar' => 17,
            'total_salah' => 3,
            'nilai' => 85.0
        ],
        
        // User 5 - Sedang mengerjakan
        [
            'id_user' => 5,
            'id_jenis_soal' => 7, // Pengetahuan & Penalaran Umum
            'status' => 'sedang mengerjakan',
            'waktu_mulai' => '2024-11-21 10:00:00',
            'waktu_berakhir' => null,
            'total_benar' => null,
            'total_salah' => null,
            'nilai' => null
        ],
        
        // User 5 - Selesai dengan nilai rendah
        [
            'id_user' => 5,
            'id_jenis_soal' => 3, // Matematika
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-17 11:00:00',
            'waktu_berakhir' => '2024-11-17 12:30:00',
            'total_benar' => 10,
            'total_salah' => 10,
            'nilai' => 50.0
        ],
        
        // Additional diverse data
        [
            'id_user' => 1,
            'id_jenis_soal' => 5, // Pengetahuan Kuantitatif
            'status' => 'belum',
            'waktu_mulai' => null,
            'waktu_berakhir' => null,
            'total_benar' => null,
            'total_salah' => null,
            'nilai' => null
        ],
        [
            'id_user' => 2,
            'id_jenis_soal' => 4, // Pengetahuan Umum
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-16 15:00:00',
            'waktu_berakhir' => '2024-11-16 16:20:00',
            'total_benar' => 12,
            'total_salah' => 8,
            'nilai' => 60.0
        ],
        [
            'id_user' => 3,
            'id_jenis_soal' => 6, // Penalaran
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-15 08:00:00',
            'waktu_berakhir' => '2024-11-15 09:30:00',
            'total_benar' => 18,
            'total_salah' => 2,
            'nilai' => 90.0
        ],
        [
            'id_user' => 4,
            'id_jenis_soal' => 1, // Bahasa Indonesia
            'status' => 'sedang mengerjakan',
            'waktu_mulai' => '2024-11-21 11:30:00',
            'waktu_berakhir' => null,
            'total_benar' => null,
            'total_salah' => null,
            'nilai' => null
        ],
        [
            'id_user' => 5,
            'id_jenis_soal' => 2, // Bahasa Inggris
            'status' => 'selesai',
            'waktu_mulai' => '2024-11-14 09:00:00',
            'waktu_berakhir' => '2024-11-14 10:15:00',
            'total_benar' => 13,
            'total_salah' => 7,
            'nilai' => 65.0
        ],
    ];
    
    // Prepare insert statement
    $sql = "INSERT INTO trans_user (
                id_user, 
                id_jenis_soal, 
                status, 
                waktu_mulai, 
                waktu_berakhir, 
                total_benar, 
                total_salah, 
                nilai,
                created_at,
                updated_at
            ) VALUES (
                :id_user, 
                :id_jenis_soal, 
                :status, 
                :waktu_mulai, 
                :waktu_berakhir, 
                :total_benar, 
                :total_salah, 
                :nilai,
                NOW(),
                NOW()
            )";
    
    $stmt = $conn->prepare($sql);
    
    $successCount = 0;
    $errorCount = 0;
    
    foreach ($transactions as $index => $trans) {
        try {
            $stmt->execute([
                ':id_user' => $trans['id_user'],
                ':id_jenis_soal' => $trans['id_jenis_soal'],
                ':status' => $trans['status'],
                ':waktu_mulai' => $trans['waktu_mulai'],
                ':waktu_berakhir' => $trans['waktu_berakhir'],
                ':total_benar' => $trans['total_benar'],
                ':total_salah' => $trans['total_salah'],
                ':nilai' => $trans['nilai']
            ]);
            
            $successCount++;
            echo "✓ Transaction " . ($index + 1) . " inserted successfully\n";
            echo "  User ID: {$trans['id_user']}, Jenis Soal: {$trans['id_jenis_soal']}, Status: {$trans['status']}\n";
            
        } catch (PDOException $e) {
            $errorCount++;
            echo "✗ Error inserting transaction " . ($index + 1) . ": " . $e->getMessage() . "\n";
        }
    }
    
    echo "\n=== SUMMARY ===\n";
    echo "Successfully inserted: $successCount records\n";
    echo "Failed: $errorCount records\n";
    
    // Show total records
    $stmt = $conn->query("SELECT COUNT(*) FROM trans_user");
    $totalCount = $stmt->fetchColumn();
    echo "Total trans_user records: $totalCount\n";
    
    // Show sample data with joins
    echo "\n=== SAMPLE DATA WITH USER & JENIS SOAL ===\n";
    $sql = "SELECT 
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
            ORDER BY tu.created_at DESC
            LIMIT 10";
    
    $stmt = $conn->query($sql);
    $samples = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($samples as $sample) {
        echo "\n";
        echo "ID: {$sample['id_trans_user']}\n";
        echo "User: {$sample['user_name']}\n";
        echo "Jenis Soal: {$sample['jenis_soal_name']}\n";
        echo "Status: {$sample['status']}\n";
        echo "Benar: " . ($sample['total_benar'] ?? '-') . ", ";
        echo "Salah: " . ($sample['total_salah'] ?? '-') . ", ";
        echo "Nilai: " . ($sample['nilai'] ?? '-') . "\n";
    }
    
    echo "\n=== SEEDING COMPLETED ===\n";
    
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage() . "\n";
    exit(1);
}
