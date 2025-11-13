class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
    };
  }
}
