// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthState {
  final CheckAuthState? checkAuthState;

  final String? error;
  final String? success;
  final String? resetCode;
  final bool? isObscurePassword;
  final bool? isFingerprintAvailable;
  final bool? isRememberMe;
  AuthState({
    this.checkAuthState,
    this.error,
    this.success,
    this.isObscurePassword = true,
    this.isFingerprintAvailable = false,
    this.isRememberMe = false,
    this.resetCode,
  });

  AuthState copyWith({
    CheckAuthState? checkAuthState,
    String? error,
    String? success,
    bool? isObscurePassword,
    bool? isFingerprintAvailable,
    bool? isRememberMe,
     String? resetCode,
  }) {
    return AuthState(
      checkAuthState: checkAuthState ?? CheckAuthState.none,
      error: error,
      success: success,
      isObscurePassword: isObscurePassword ?? true,
      isFingerprintAvailable: isFingerprintAvailable,
      isRememberMe: isRememberMe ?? false,
      resetCode: resetCode??this.resetCode,
    );
  }
}

enum CheckAuthState {
  none,
  isPinSet,
  isLoading,
  success,
  signinSuccess,
  error,
}
