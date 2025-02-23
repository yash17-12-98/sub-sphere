import '../base/base_provider.dart';

class GetStartedProvider extends BaseProvider {
  bool viewButton = false;
  bool showText = false;
  bool showCarousel = false;

  /// Triggers animations sequentially with delays.
  Future<void> triggerAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    showCarousel = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    showText = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    viewButton = true;
    notifyListeners();
  }
}
