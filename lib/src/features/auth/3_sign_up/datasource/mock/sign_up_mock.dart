part of '../sign_up_datasource.dart';

/// Creates mock sign up data
///

Map<String, dynamic> _mockSignUpSuccess() => {
  "SUCCESS": true,
  "INFO": "REGISTRATION_COMPLETED",
  "DATA": {
    "access":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjM0NTYiLCJleHAiOjE2ODk1NzQ0MDB9.V6vVQjP8F0lUO4lXj2I2Jx1sK2wJtTqjL_RnUqY8B2A",
    "refresh":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjM0NTYiLCJleHAiOjE3MDAwMDAwMDB9.XyYy3q_5G7h8G9yq5_8c2z8J7vQxR4kO9D7xN1F2g3h",
  },
  "ERROR": null,
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