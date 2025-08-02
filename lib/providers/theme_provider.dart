import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isPremium = false;

  bool get isDarkMode => _isDarkMode;
  bool get isPremium => _isPremium;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isPremium = prefs.getBool('isPremium') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setPremium(bool isPremium) async {
    _isPremium = isPremium;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', _isPremium);
    notifyListeners();
  }
} 