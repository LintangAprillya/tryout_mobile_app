class Soal {
  final int idSoal;
  final int idJenisSoal;
  final String soal;
  final String? jenisSoalName;
  final List<OpsiJawaban>? opsiJawaban;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Soal({
    required this.idSoal,
    required this.idJenisSoal,
    required this.soal,
    this.jenisSoalName,
    this.opsiJawaban,
    this.createdAt,
    this.updatedAt,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      idSoal: json['id_soal'],
      idJenisSoal: json['id_jenis_soal'],
      soal: json['soal'],
      jenisSoalName: json['jenis_soal_name'],
      opsiJawaban: json['opsi_jawaban'] != null
          ? (json['opsi_jawaban'] as List)
              .map((item) => OpsiJawaban.fromJson(item))
              .toList()
          : null,
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
      'id_soal': idSoal,
      'id_jenis_soal': idJenisSoal,
      'soal': soal,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Method untuk menentukan tipe soal (essay atau pilihan ganda)
  String get tipeSoal {
    if (opsiJawaban == null || opsiJawaban!.isEmpty) {
      return 'Essay';
    }
    return 'Pilihan Ganda';
  }
}

class OpsiJawaban {
  final int idOpsiJawaban;
  final int idSoal;
  final String opsiJawaban;
  final String status; // 'Salah' atau 'Benar'
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OpsiJawaban({
    required this.idOpsiJawaban,
    required this.idSoal,
    required this.opsiJawaban,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OpsiJawaban.fromJson(Map<String, dynamic> json) {
    return OpsiJawaban(
      idOpsiJawaban: json['id_opsi_jawaban'],
      idSoal: json['id_soal'],
      opsiJawaban: json['opsi_jawaban'],
      status: json['status'],
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
      'id_opsi_jawaban': idOpsiJawaban,
      'id_soal': idSoal,
      'opsi_jawaban': opsiJawaban,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isCorrect => status == 'Benar';
}
