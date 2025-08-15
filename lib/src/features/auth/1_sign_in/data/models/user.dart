import 'package:equatable/equatable.dart';
base class User with EquatableMixin {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String createdAt;
  final String updatedAt;

  const User._({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });



 
  factory User.from(Map<String, dynamic> json) => User._(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    role: json['role'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
   
  );
  

  @override
  List<Object?> get props => [id, name, email, phone, role, createdAt, updatedAt];

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
