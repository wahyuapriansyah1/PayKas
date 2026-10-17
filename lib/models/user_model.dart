class UserModel {
  final String name;
  final String username;
  final String email;
  final String phone;
  final String className;
  final String role;
  final String? avatarAsset;

  const UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.className,
    this.role = 'Bendahara Kelas',
    this.avatarAsset,
  });

  UserModel copyWith({
    String? name,
    String? username,
    String? email,
    String? phone,
    String? className,
    String? role,
    String? avatarAsset,
  }) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      className: className ?? this.className,
      role: role ?? this.role,
      avatarAsset: avatarAsset ?? this.avatarAsset,
    );
  }
}
