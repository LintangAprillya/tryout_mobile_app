class JenisSoal {
  final int idJenisSoal;
  final String jenisSoal;
  final int pengerjaan; // dalam menit
  final DateTime waktuMulai;
  final DateTime waktuBerakhir;
  final String? gambar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  JenisSoal({
    required this.idJenisSoal,
    required this.jenisSoal,
    required this.pengerjaan,
    required this.waktuMulai,
    required this.waktuBerakhir,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });

  factory JenisSoal.fromJson(Map<String, dynamic> json) {
    return JenisSoal(
      idJenisSoal: json['id_jenis_soal'],
      jenisSoal: json['jenis_soal'],
      pengerjaan: json['pengerjaan'],
      waktuMulai: DateTime.parse(json['waktu_mulai']),
      waktuBerakhir: DateTime.parse(json['waktu_berakhir']),
      gambar: json['gambar'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    // Format datetime untuk MySQL: YYYY-MM-DD HH:MM:SS
    String formatDateTime(DateTime dt) {
      return '${dt.year.toString().padLeft(4, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.day.toString().padLeft(2, '0')} '
          '${dt.hour.toString().padLeft(2, '0')}:'
          '${dt.minute.toString().padLeft(2, '0')}:'
          '${dt.second.toString().padLeft(2, '0')}';
    }
    
    return {
      'id_jenis_soal': idJenisSoal,
      'jenis_soal': jenisSoal,
      'pengerjaan': pengerjaan,
      'waktu_mulai': formatDateTime(waktuMulai),
      'waktu_berakhir': formatDateTime(waktuBerakhir),
      'gambar': gambar,
      'created_at': createdAt != null ? formatDateTime(createdAt!) : null,
      'updated_at': updatedAt != null ? formatDateTime(updatedAt!) : null,
    };
  }
}
