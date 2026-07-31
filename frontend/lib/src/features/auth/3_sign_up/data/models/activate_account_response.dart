import 'package:equatable/equatable.dart';
import 'package:generic_requester/generic_requester.dart';

final class ActivateAccountResponse extends ModelingProtocol {
  final bool success;
  final String info;
  final TokenData? data;

  ActivateAccountResponse({
    required this.success,
    required this.info,
    this.data,
  });

  factory ActivateAccountResponse.empty() =>
      ActivateAccountResponse(success: false, info: '', data: null);

  @override
  fromJson(json) {
    return ActivateAccountResponse(
      success: json?['success'] ?? false,
      info: json?['info'] ?? '',
      data: json?['data'] != null ? TokenData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [success, info, data];
}

final class TokenData with EquatableMixin {
  final String access;
  final String refresh;

  const TokenData({required this.access, required this.refresh});

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      TokenData(access: json['access'] ?? '', refresh: json['refresh'] ?? '');

  @override
  List<Object?> get props => [access, refresh];

  @override
  String toString() => 'TokenData(access: $access, refresh: $refresh)';
}
