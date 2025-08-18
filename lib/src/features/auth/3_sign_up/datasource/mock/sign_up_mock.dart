part of '../sign_up_datasource.dart';

/// Creates mock sign up data
///

Map<String, dynamic> _mockSignUpWithEmailAndPassword() => {
  "SUCCESS": "true",
  "INFO": "REGISTRATION_COMPLETED",
  "DATA": "null",
  "ERROR": "null",
};



// {
//     "SUCCESS": false,
//     "INFO": "REGISTRATION_FAILED",
//     "DATA": null,
//     "ERROR": "error exmple...."
// }

// {
//   "SUCCESS": true,
//   "INFO": "REGISTRATION_COMPLETED",
//   "DATA": {
//         "access": "eyJhbGciOiJIUz........",
//         "refresh": "eyJhbGciOiJIU.........."
//   },
//   "ERROR": null
// }