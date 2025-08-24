import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// الانتقال لشاشة تسجيل الدخول
  static void navigateToLogin(BuildContext context) {
    print('🔄 NavigationService - Navigating to login screen');
    if (context.mounted) {
      context.go('/login');
    }
  }
  
  /// الانتقال للصفحة الرئيسية
  static void navigateToHome(BuildContext context) {
    print('🏠 NavigationService - Navigating to home screen');
    if (context.mounted) {
      context.go('/home');
    }
  }
  
  /// الانتقال لشاشة تسجيل الدخول من أي مكان في التطبيق
  static void navigateToLoginFromAnywhere() {
    print('🔄 NavigationService - Navigating to login from anywhere');
    // استخدام GoRouter للانتقال من أي مكان
    try {
      final context = navigatorKey.currentContext;
      if (context != null) {
        context.go('/login');
      } else {
        print('⚠️ NavigationService - No context available for navigation');
      }
    } catch (e) {
      print('❌ NavigationService - Error navigating to login: $e');
    }
  }
  
  /// مسح جميع الصفحات والانتقال لشاشة تسجيل الدخول
  static void clearStackAndNavigateToLogin(BuildContext context) {
    print('🔄 NavigationService - Clearing stack and navigating to login');
    if (context.mounted) {
      context.go('/login');
    }
  }
}
