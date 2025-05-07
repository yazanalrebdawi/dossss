import 'dart:developer';


import 'package:dartz/dartz.dart';

import '../../../../core/network/api.dart';
import '../../../../core/network/api_request.dart';
import '../../../../core/network/api_urls.dart';
import '../../../../core/network/failure.dart';
import '../../presentation/pages/verify_forget_password_screen.dart';
import '../models/auth_response_model.dart';
import '../models/create_account_params_model.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final API api;
  AuthRemoteDataSourceImp({required this.api});
  @override
  Future<Either<Failure, AuthResponceModel>> signin(
    SigninParams params,
  ) async {
    final ApiRequest apiRequest = ApiRequest(
      url: ApiUrls.login,
      data: {
        "email": params.email.text,
        "password": params.password.text,
      },
    );

    final respons = await api.post<Map<String, dynamic>>(
      apiRequest: apiRequest,
    );

    return respons.fold(
      (failure) {
        
        return Left(failure);
      },
      (response) {
        AuthResponceModel authresponse = AuthResponceModel.fromJson(response);
        return Right(authresponse);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> register(
    CreateAccountParams params,
  ) async {
    final ApiRequest apiRequest = ApiRequest(
      url: ApiUrls.rigester,
      data: {
        "email": params.email.text,
        "full_name": params.firstName.text,
        "nick_name": params.nickName.text,
        "date_of_birth": params.dateOfBirth,
        "phone": params.phoneNumber,
        "password": params.password.text,
      },
    );
    final response = await api.post(
      apiRequest: apiRequest,
    );
    return response.fold(
      (failure) {
        return Left(failure);
      },
      (response) {
        UserModel user = UserModel.fromJson(
          response as Map<String, dynamic>,
        );
        return Right(user);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
    String email,
  ) async {
    final ApiRequest apiRequest = ApiRequest(
      url: ApiUrls.services,
      data: {
        "email": email,
      },
    );
    // ! it need to correct
    final response = await api.post<Map<String, dynamic>>(
      apiRequest: apiRequest,
    );
    log(response.toString());
    return response.fold(
      (failure) {
        return Left(failure);
      },
      (respons) {
        return Right(respons);
      },
    );
  }

  @override
  Future<Either<Failure, String>> verifyOtp(
    VerifycodeParams params,
  ) async {
    final ApiRequest apiRequest = ApiRequest(
      url: ApiUrls.homeData,
      data: {
        "email": params.phoneNumber,
        "reset_code": params.otp,
      },
    );
    // ! it need to correct
    final response = await api.post<Map<String, dynamic>>(
      apiRequest: apiRequest,
    );
    log(response.toString());
    return response.fold((failure) {
      return Left(failure);
    }, (resutl) {
      final String message = resutl["status"];
      return Right(message);
    });
  }

  @override
  Future<Either<Failure, String>> newPassword(
    SigninParams params,
  ) async {
    final ApiRequest apiRequest = ApiRequest(
      url: ApiUrls.homeData,
      data: {
        "email": "eng.mustafaismail.work@gmail.com",
        "new_password": params.password.text,
      },
    );

    final respons = await api.post<Map<String, dynamic>>(
      apiRequest: apiRequest,
    );

    return respons.fold(
      (failure) {
        return Left(failure);
      },
      (response) {
        final String resutl = response["status"];
        return Right(resutl);
      },
    );
  }
}
