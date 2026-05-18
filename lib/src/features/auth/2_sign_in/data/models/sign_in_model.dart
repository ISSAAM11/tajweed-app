import 'package:generic_requester/generic_requester.dart';
import 'package:tajweed_ai/src/features/auth/2_sign_in/data/models/user.dart';

final class SignInModel extends ModelingProtocol {
  final String status;
  final String message;
  final User? data;

  SignInModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignInModel.empty() =>
      SignInModel(status: '', message: '', data: null);

  @override
  fromJson(json) {
    return SignInModel(
      status: json?['status'],
      message: json?['message'],
      data: json?['data'] != null ? User.from(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
