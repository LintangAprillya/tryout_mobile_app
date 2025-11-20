import 'package:flutter/material.dart';

class DashboardStats {
  final int totalPeserta;
  final int pesertaSedangUjian;
  final int totalPaketSoal;
  final int ujianSelesai;
  final List<ChartData> chartData;

  DashboardStats({
    required this.totalPeserta,
    required this.pesertaSedangUjian,
    required this.totalPaketSoal,
    required this.ujianSelesai,
    required this.chartData,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalPeserta: json['total_peserta'] ?? 0,
      pesertaSedangUjian: json['peserta_sedang_ujian'] ?? 0,
      totalPaketSoal: json['total_paket_soal'] ?? 0,
      ujianSelesai: json['ujian_selesai'] ?? 0,
      chartData: (json['chart_data'] as List?)
              ?.map((item) => ChartData.fromJson(item))
              .toList() ??
          [],
    );
  }

  // Dummy data untuk testing
  factory DashboardStats.dummy() {
    return DashboardStats(
      totalPeserta: 1250,
      pesertaSedangUjian: 45,
      totalPaketSoal: 7,
      ujianSelesai: 856,
      chartData: [
        ChartData(month: 'Jan', value: 120),
        ChartData(month: 'Feb', value: 145),
        ChartData(month: 'Mar', value: 180),
        ChartData(month: 'Apr', value: 165),
        ChartData(month: 'Mei', value: 195),
        ChartData(month: 'Jun', value: 210),
        ChartData(month: 'Jul', value: 235),
      ],
    );
  }
}

class ChartData {
  final String month;
  final int value;

  ChartData({
    required this.month,
    required this.value,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      month: json['month'] ?? '',
      value: json['value'] ?? 0,
    );
  }
}
