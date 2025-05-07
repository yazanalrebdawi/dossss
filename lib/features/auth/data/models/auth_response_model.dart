

import 'package:dooss_business_app/features/auth/data/models/user_model.dart';

class AuthResponceModel {
    final String message;
    final UserModel user;
    final String token;

    AuthResponceModel({
        required this.message,
        required this.user,
        required this.token,
    });

    AuthResponceModel copyWith({
        String? message,
        UserModel? user,
        String? token,
    }) => 
        AuthResponceModel(
            message: message ?? this.message,
            user: user ?? this.user,
            token: token ?? this.token,
        );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'user': user.toJson(),
      'token': token,
    };
  }

  factory AuthResponceModel.fromJson(Map<String, dynamic> map) {
    return AuthResponceModel(
      message: map['message'],
      user: UserModel.fromJson(map['user']),
      token: map['token'],
    );
  }

}
