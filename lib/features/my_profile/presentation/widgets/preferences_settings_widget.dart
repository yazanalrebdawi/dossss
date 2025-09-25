import 'dart:developer';
import 'package:dooss_business_app/features/my_profile/presentation/pages/theme_settings_screen.dart';
import 'package:dooss_business_app/features/my_profile/presentation/widgets/card_settings_widget.dart';
import 'package:dooss_business_app/features/my_profile/presentation/widgets/language_row_widget.dart';
import 'package:dooss_business_app/features/my_profile/presentation/widgets/settings_switch_row_widget.dart';
import 'package:flutter/material.dart';

class PreferencesSettingsWidget extends StatelessWidget {
  const PreferencesSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardSettingsWidget(
      text: "Preferences",
      height: 243,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LanguageRowWidget(
            iconBackgroundColor: Color(0xffF3E8FF),
            iconColor: Color(0xff9333EA),
            iconData: Icons.language,
            text: "Language",
            onLanguageChanged: (String value) {
              log(value);
            },
          ),

          SettingsSwitchRowWidget(
            iconBackgroundColor: Color(0xffFEF9C3),
            iconColor: Color(0xffCA8A04),
            iconData: Icons.color_lens,
            text: "Theme",
            initialValue: true,
            onChanged: (value) {
              log('Theme switched to $value');
            },
            onTapRow: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeSettingsScreen()),
              );
            },
          ),
          SettingsSwitchRowWidget(
            switchEnabled: false,
            iconBackgroundColor: Color(0xffE0E7FF),
            iconColor: Color(0xff4F46E5),
            iconData: Icons.notifications,
            text: "Notifications",
            initialValue: true,
            onChanged: (value) {
              log('Notifications switched to $value');
            },
            onTapRow: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SettingsNotificationsScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
