class TipeUser {
  final int idTipeUser;
  final String tipeUser;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TipeUser({
    required this.idTipeUser,
    required this.tipeUser,
    this.createdAt,
    this.updatedAt,
  });

  factory TipeUser.fromJson(Map<String, dynamic> json) {
    return TipeUser(
      idTipeUser: json['id_tipe_user'],
      tipeUser: json['tipe_user'],
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
      'id_tipe_user': idTipeUser,
      'tipe_user': tipeUser,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
