import 'package:generic_requester/generic_requester.dart';

final class User extends ModelingProtocol {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String status;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.empty() => const User(
    id: '',
    name: '',
    email: '',
    phone: '',
    password: '',
    role: '',
    status: '',
    createdAt: '',
    updatedAt: '',
  );

  @override
  User fromJson(json) {
    try {
      return User(
        id: json?['id'] ?? '',
        name: json?['name'] ?? '',
        email: json?['email'] ?? '',
        phone: json?['phone'] ?? '',
        password: json?['password'] ?? '',
        role: json?['role'] ?? '',
        status: json?['status'] ?? '',
        createdAt: json?['createdAt'] ?? '',
        updatedAt: json?['updatedAt'] ?? '',
      );
    } catch (e, s) {
      throw JsonParsingException(e, s);
    }
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    password,
    role,
    status,
    createdAt,
    updatedAt,
  ];
}
