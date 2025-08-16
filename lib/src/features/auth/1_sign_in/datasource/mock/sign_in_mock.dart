part of '../sign_in_datasource.dart';

/// Creates mock sign in data
///
Map<String, dynamic> _mockSignInWithEmailAndPassword() => {
  "status": "success",
  "message": "Sign in successful",
  "data": {
      "id": "123",
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "+1234567890",
      "role": "admin",
      "createdAt": DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
      "updatedAt": DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
  },
};
