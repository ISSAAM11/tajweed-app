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
      return 'Please enter a password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]').hasMatch(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*()_+-=[]{}|;:,.<>?)';
    }

    // Check for common weak patterns
    if (RegExp(r'(.)\1{2,}').hasMatch(value)) {
      return 'Password cannot contain repeated characters (e.g., aaa, 111)';
    }

    if (RegExp(r'(123|abc|qwe|password|admin)').hasMatch(value.toLowerCase())) {
      return 'Password cannot contain common sequences';
    }

    return null;
  }

  // Login password validation (less strict for login)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 1) {
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
    if (RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]').hasMatch(password)) score++;

    if (score <= 2) return 'Weak';
    if (score <= 4) return 'Fair';
    if (score <= 5) return 'Good';
    return 'Strong';
  }
}

extension Validator on GlobalKey<FormState> {
  bool get isUnvalid => !(currentState?.validate() ?? false);
}