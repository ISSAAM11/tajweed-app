part of '../sign_up_datasource.dart';

Map<String, dynamic> _mockSignUpSuccess() => {
  "success": true,
  "info": "REGISTRATION_COMPLETED",
};
Map<String, dynamic> _mockResendPinSuccess() => {
  "success": true,
  "info": "code sent",
};

Map<String, dynamic> _mockActivateAccountSuccess() => {
  "success": true,
  "info": "ACCOUNT_ACTIVATED",
  "data": {
    "access": "mock_access_token_123",
    "refresh": "mock_refresh_token_456",
  },
};
