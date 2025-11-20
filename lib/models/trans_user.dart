import 'package:flutter/material.dart';

class TransUser {
  final int idTransUser;
  final int idUser;
  final int idJenisSoal;
  final String status; // 'selesai', 'belum', 'sedang mengerjakan'
  final DateTime? waktuMulai;
  final DateTime? waktuBerakhir;
  final int? totalBenar;
  final int? totalSalah;
  final double? nilai;
  final String? userName;
  final String? jenisSoalName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransUser({
    required this.idTransUser,
    required this.idUser,
    required this.idJenisSoal,
    required this.status,
    this.waktuMulai,
    this.waktuBerakhir,
    this.totalBenar,
    this.totalSalah,
    this.nilai,
    this.userName,
    this.jenisSoalName,
    this.createdAt,
    this.updatedAt,
  });

  factory TransUser.fromJson(Map<String, dynamic> json) {
    return TransUser(
      idTransUser: json['id_trans_user'],
      idUser: json['id_user'],
      idJenisSoal: json['id_jenis_soal'],
      status: json['status'],
      waktuMulai: json['waktu_mulai'] != null
          ? DateTime.parse(json['waktu_mulai'])
          : null,
      waktuBerakhir: json['waktu_selesai'] != null
          ? DateTime.parse(json['waktu_selesai'])
          : json['waktu_berakhir'] != null
              ? DateTime.parse(json['waktu_berakhir'])
              : null,
      totalBenar: json['total_benar'],
      totalSalah: json['total_salah'],
      nilai: json['nilai']?.toDouble(),
      userName: json['user_name'],
      jenisSoalName: json['jenis_soal_name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_trans_user': idTransUser,
      'id_user': idUser,
      'id_jenis_soal': idJenisSoal,
      'status': status,
      'waktu_mulai': waktuMulai?.toIso8601String(),
      'waktu_berakhir': waktuBerakhir?.toIso8601String(),
      'total_benar': totalBenar,
      'total_salah': totalSalah,
      'nilai': nilai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Method untuk menghitung persentase benar
  double get persentaseBenar {
    if (totalBenar == null || totalSalah == null) return 0;
    int total = totalBenar! + totalSalah!;
    if (total == 0) return 0;
    return (totalBenar! / total) * 100;
  }

  // Method untuk menentukan warna status
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'sedang mengerjakan':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
