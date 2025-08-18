import 'package:generic_requester/generic_requester.dart';
import 'package:equatable/equatable.dart';

final class SignUpModelResponse extends ModelingProtocol {
  final bool success;
  final String info;
  final TokenData? data;
  final String? error;

  SignUpModelResponse({
    required this.success,
    required this.info,
    required this.data,
    this.error,
  });

  factory SignUpModelResponse.empty() =>
      SignUpModelResponse(success: false, info: '', data: null, error: null);

  @override
  fromJson(json) {
    return SignUpModelResponse(
      success: json?['SUCCESS'] ?? false,
      info: json?['INFO'] ?? '',
      data: json?['DATA'] != null ? TokenData.from(json['DATA']) : null,
      error: json?['ERROR'],
    );
  }

  @override
  List<Object?> get props => [success, info, data, error];
}

final class TokenData with EquatableMixin {
  final String access;
  final String refresh;

  const TokenData({required this.access, required this.refresh});

  factory TokenData.from(Map<String, dynamic> json) =>
      TokenData(access: json['access'] ?? '', refresh: json['refresh'] ?? '');

  @override
  List<Object?> get props => [access, refresh];

  @override
  String toString() => 'TokenData(access: $access, refresh: $refresh)';
}
