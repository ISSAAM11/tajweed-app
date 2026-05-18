import 'package:generic_requester/generic_requester.dart';

final class SignUpModelResponse extends ModelingProtocol {
  final bool success;
  final String info;

  SignUpModelResponse({required this.success, required this.info});

  factory SignUpModelResponse.empty() =>
      SignUpModelResponse(success: false, info: '');

  factory SignUpModelResponse.fromMap(Map<String, dynamic>? json) {
    return SignUpModelResponse(
      success: json?['success'] ?? false,
      info: json?['info'] ?? '',
    );
  }

  @override
  fromJson(json) {
    return SignUpModelResponse(
      success: json?['success'] ?? false,
      info: json?['info'] ?? '',
    );
  }

  @override
  List<Object?> get props => [success, info];
}

// final class TokenData with EquatableMixin {
//   final String access;
//   final String refresh;

//   const TokenData({required this.access, required this.refresh});

//   factory TokenData.from(Map<String, dynamic> json) =>
//       TokenData(access: json['access'] ?? '', refresh: json['refresh'] ?? '');

//   @override
//   List<Object?> get props => [access, refresh];

//   @override
//   String toString() => 'TokenData(access: $access, refresh: $refresh)';
// }
