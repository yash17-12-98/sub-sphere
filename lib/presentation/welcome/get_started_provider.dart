import '../base/base.dart';

class GetStartedProvider extends BaseProvider {
  bool viewButton = false;
  bool showText = false;
  bool showCarousel = false;

  alterCarouselViewStateAfterSomeDelay() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showCarousel = true;
      notifyListeners();
    });
  }

  alterButtonViewStateAfterSomeDelay() {
    Future.delayed(const Duration(milliseconds: 500), () {
      viewButton = true;
      notifyListeners();
    });
  }

  alterTexViewStateAfterSomeDelay() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showText = true;
      notifyListeners();
    });
  }
}
