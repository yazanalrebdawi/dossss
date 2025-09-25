import 'package:dooss_business_app/core/models/enums/app_language_enum.dart';
import 'package:dooss_business_app/core/models/enums/app_them_enum.dart';
import 'package:flutter/material.dart';
import 'package:dooss_business_app/features/auth/data/models/user_model.dart';

class AppManagerState {
  //?-------------------------------------------------------------------
  //! User Data
  final UserModel? user;

  //! Language
  final Locale locale;
  final AppLanguageEnum? lastApply;

  //! Them
  final AppThemeEnum themeMode;
  //?-------------------------------------------------------------------

  AppManagerState({
    this.themeMode = AppThemeEnum.light,
    this.user,
    this.locale = const Locale('en'),
    this.lastApply,
  });
  //?-------------------------------------------------------------------
  AppManagerState copyWith({
    UserModel? user,
    AppThemeEnum? themeMode,
    Locale? locale,
    AppLanguageEnum? lastApply,
  }) {
    return AppManagerState(
      themeMode: themeMode ?? this.themeMode,
      user: user ?? this.user,
      locale: locale ?? this.locale,
      lastApply: lastApply,
    );
  }

  //?-------------------------------------------------------------------
}
