enum UserRole { locatario, proprietario }

class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final UserRole role;
  final String? cpf;
  final String? phone;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.role = UserRole.locatario,
    this.cpf,
    this.phone,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    UserRole? role,
    String? cpf,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      cpf: cpf ?? this.cpf,
      phone: phone ?? this.phone,
    );
  }
}
