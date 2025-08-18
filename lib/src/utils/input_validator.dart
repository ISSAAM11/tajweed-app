import 'package:flutter/widgets.dart' show FormState, GlobalKey;

class InputValidators {
  // Email validation with comprehensive regex pattern
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }

    // Comprehensive email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    // Additional checks for common email issues
    if (value.trim().length > 254) {
      return 'Email address is too long';
    }

    if (value.trim().startsWith('.') || value.trim().endsWith('.')) {
      return 'Email address cannot start or end with a dot';
    }

    return null;
  }

  // Password validation with comprehensive requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add at least one uppercase letter (A-Z)';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Add at least one number (0-9)';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Add at least one special character (!@#...)';
    }

    return null; // ✅ Valid password
  }

  // Login password validation (less strict for login)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.isEmpty) {
      return 'Password cannot be empty';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Email format helper method
  static bool isValidEmailFormat(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  // Password strength checker
  static String getPasswordStrength(String password) {
    int score = 0;

    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]').hasMatch(password))
      score++;

    if (score <= 2) return 'Weak';
    if (score <= 4) return 'Fair';
    if (score <= 5) return 'Good';
    return 'Strong';
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    // Allow only letters, spaces, hyphens, and apostrophes
    if (!RegExp(r"^[a-zA-ZÀ-ÿ' -]+$").hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, or apostrophes';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }

    return null; // ✅ Valid name
  }
}

extension Validator on GlobalKey<FormState> {
  bool get isUnvalid => !(currentState?.validate() ?? false);
}
