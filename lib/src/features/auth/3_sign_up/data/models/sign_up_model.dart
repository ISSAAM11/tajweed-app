import 'package:generic_requester/generic_requester.dart';

final class SignUpModel extends ModelingProtocol {
  final String status;
  final String message;

  const SignUpModel({required this.status, required this.message});

  factory SignUpModel.empty() => SignUpModel(status: '', message: '');

  @override
  fromJson(json) {
    return SignUpModel(status: json?['status'], message: json?['message']);
  }

  @override
  List<Object?> get props => [status, message];
}
