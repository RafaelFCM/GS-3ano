import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  String language = 'Português';
  String fontSize = 'Grande';
  bool emailNotifications = false;
  bool appNotifications = false;
  bool privacyOptions = false;

  void updateSettings({
    required String language,
    required String fontSize,
    required bool emailNotifications,
    required bool appNotifications,
    required bool privacyOptions,
  }) {
    this.language = language;
    this.fontSize = fontSize;
    this.emailNotifications = emailNotifications;
    this.appNotifications = appNotifications;
    this.privacyOptions = privacyOptions;
    notifyListeners();
  }

}
