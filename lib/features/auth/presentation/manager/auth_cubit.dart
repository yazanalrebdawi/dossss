import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/locator_service.dart';
import '../../data/data_source/auth_remote_data_source_imp.dart' show AuthRemoteDataSourceImp;
import '../../data/models/create_account_params_model.dart';
import '../pages/verify_forget_password_screen.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSourceImp authRemoteDataSource;
  // final appManager = getItInstance<AppManagerCubit>();
  AuthCubit(this.authRemoteDataSource) : super(AuthState());

  void passwordObscureToggel() {
    emit(
      state.copyWith(
        isObscurePassword: !(state.isObscurePassword ?? false),
      ),
    );
  }

  void signIn(SigninParams params) async {
    log("message");
    emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));

    final result = await authRemoteDataSource.signin(params);
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: "Invalid email or password.",
          checkAuthState: CheckAuthState.error,
        ));
      },
      (authresponse) {
        // appManager.saveUserData(authresponse);
        emit(state.copyWith(
          checkAuthState: CheckAuthState.signinSuccess,
          success: authresponse.message,
        ));
      },
    );
  }

  void register(CreateAccountParams params) async {
    log("message");
    emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));

    final result = await authRemoteDataSource.register(params);
    result.fold(
      (failure) {
        emit(state.copyWith(
            error: failure.message, checkAuthState: CheckAuthState.error));
      },
      (authresponse) {
        log("############################");
        emit(state.copyWith(
          checkAuthState: CheckAuthState.success,
        ));
      },
    );
  }

  void resetPassword(int phoneNumber) async {
    emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));

    final result = await authRemoteDataSource.resetPassword(phoneNumber.toString());
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.message,
          checkAuthState: CheckAuthState.error,
        ));
      },
      (successSending) {
        emit(state.copyWith(
          checkAuthState: CheckAuthState.success,
          success: successSending["message"],
        ));
      },
    );
  }

  void verfiyOtp(VerifycodeParams params) async {
    emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));
    final result = await authRemoteDataSource.verifyOtp(params);
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.message,
          checkAuthState: CheckAuthState.error,
        ));
      },
      (successSending) {
        emit(state.copyWith(
          checkAuthState: CheckAuthState.success,
        ));
      },
    );
  }

  void newPassword(SigninParams params) async {
    emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));

    final result = await authRemoteDataSource.newPassword(params);
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.message,
          checkAuthState: CheckAuthState.error,
        ));
      },
      (successSending) {
        emit(state.copyWith(
          checkAuthState: CheckAuthState.success,
        ));
      },
    );
  }

  // void setPin(String pinCode) async {
  //   emit(state.copyWith(checkAuthState: CheckAuthState.isLoading));
  //   try {
  //     await ScureStorageService.setValue(
  //       key: CacheKeys.pinCode,
  //       value: pinCode,
  //     );
  //
  //     emit(state.copyWith(checkAuthState: CheckAuthState.isPinSet));
  //
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     final isFingerprintAvailable = await _isAvailableStrongBiometric();
  //     log("Fingerprint Availability: $isFingerprintAvailable ##########");
  //
  //     emit(state.copyWith(
  //       isFingerprintAvailable: isFingerprintAvailable,
  //     ));
  //     // if (condition) {
  //
  //     // }
  //   } catch (e) {
  //     log("Error Set Pin : $e");
  //   }
  // }

//   Future<bool> _isAvailableStrongBiometric() async {
//     if (await LocalAuthService.isBiometricSupported()) {
//       final biometricListTemp = await LocalAuthService.getAvailableBiometrics();
//
//       if (biometricListTemp.contains(BiometricType.strong)) {
//         return true;
//       }
//     }
//     return false;
//   }
 }
