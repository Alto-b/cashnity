import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _storageKey = 'isDarkMode';

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  final RxBool isDark = false.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
    _updateIsDark();
  }

  void _loadThemeFromStorage() {
    bool? storedIsDark = _box.read<bool>(_storageKey);
    if (storedIsDark != null) {
      _themeMode.value = storedIsDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode.value = ThemeMode.system;
    }
  }

  void _updateIsDark() {
    if (_themeMode.value == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDark.value = brightness == Brightness.dark;
    } else {
      isDark.value = _themeMode.value == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _box.write(_storageKey, isDarkMode); // Save preference
    _updateIsDark();
    Get.changeThemeMode(_themeMode.value);
  }
}
