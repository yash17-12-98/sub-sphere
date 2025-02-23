import 'package:flutter/material.dart';

/// A base provider class that extends `ChangeNotifier`.
/// This can be used as a common provider for managing shared state across multiple screens.
///
/// If any state needs to be managed globally, we can extend this `BaseProvider`
/// in specific providers and notify listeners whenever the state changes.
///
/// Example Usage:
///
/// ```dart
/// class ThemeProvider extends BaseProvider {
///   bool _isDarkMode = false;
///
///   bool get isDarkMode => _isDarkMode;
///
///   void toggleTheme() {
///     _isDarkMode = !_isDarkMode;
///     notifyListeners(); // Notifies all listeners about the state change
///   }
/// }
/// ```
///
/// The `ThemeProvider` extends `BaseProvider`, allowing it to be used across the app
/// to manage theme state. Any screen that listens to `ThemeProvider` will rebuild
/// when `notifyListeners()` is called.
class BaseProvider extends ChangeNotifier {}
