part of '../sign_in_datasource.dart';

/// Creates mock sign in data
///
Map<String, dynamic> _mockSignIn() => {
  "status": "success",
  "message": "Sign in successful",
  "token": "1234567890",
  "data": {
    "userAccount": {
      "id": "123",
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "+1234567890",
      "password": "password123",
      "role": "admin",
      "status": "active",
      "createdAt": DateTime.now().subtract(Duration(hours: 8)).toIso8601String(),
      "updatedAt": DateTime.now().subtract(Duration(hours: 8)).toIso8601String(),
    },
  },
};


