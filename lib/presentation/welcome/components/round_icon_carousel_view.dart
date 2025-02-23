import 'dart:async';
import 'package:flutter/material.dart';
import '../../resources/resources.dart';

class RoundIconCarouselView extends StatefulWidget {
  const RoundIconCarouselView({super.key});

  @override
  State<RoundIconCarouselView> createState() => _RoundIconCarouselViewState();
}

class _RoundIconCarouselViewState extends State<RoundIconCarouselView> {
  final List<CarouselItems> items = [
    CarouselItems(
        icon: ImageAssets.figmaImage,
        color: ColorManager.blue.withValues(alpha: 0.5)),
    CarouselItems(icon: ImageAssets.dribbleImage, color: ColorManager.pink),
    CarouselItems(icon: ImageAssets.spotifyImage, color: ColorManager.green),
    CarouselItems(
        icon: ImageAssets.playStationImage, color: ColorManager.white),
    CarouselItems(icon: ImageAssets.youtubeImage, color: ColorManager.red),
  ];

  int selectedIndex = 0;
  late PageController pageController;
  static const int infiniteScale = 1000;
  static const Duration autoPlayInterval = Duration(seconds: 3);
  static const Duration autoPlayAnimationDuration = Duration(milliseconds: 800);
  Timer? autoPlayTimer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 0.2,
      initialPage: items.length * (infiniteScale ~/ 2), // Start from the middle to allow infinite looping.
    );
    startAutoPlay();
  }

  /// Starts auto-playing the carousel.
  void startAutoPlay() {
    autoPlayTimer?.cancel();
    autoPlayTimer = Timer.periodic(autoPlayInterval, (timer) {
      if (pageController.hasClients && pageController.page != null) {
        pageController.animateToPage(
          pageController.page!.toInt() + 1,
          duration: autoPlayAnimationDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    autoPlayTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (_) => autoPlayTimer?.cancel(), // Pause auto-play on tap down.
      onTapUp: (_) => startAutoPlay(), // Resume auto-play on tap release.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
        child: SizedBox(
          height: height * 0.2,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index % items.length;
              });
            },
            itemCount: items.length * infiniteScale, // Infinite effect by multiplying items.
            itemBuilder: (context, index) {
              final itemIndex = index % items.length;
              return AnimatedScale(
                scale: selectedIndex == itemIndex ? 1.3 : 1.0, // Scale animation for selected item.
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: _buildShadows(itemIndex),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Image.asset(
                      items[itemIndex].icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds a glowing shadow effect for the selected item.
  List<BoxShadow> _buildShadows(int itemIndex) {
    if (selectedIndex == itemIndex) {
      return [
        BoxShadow(
          color: items[itemIndex].color.withValues(alpha: 0.5),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 1),
        ),
        BoxShadow(
          color: items[itemIndex].color.withValues(alpha: 0.3),
          spreadRadius: 15,
          blurRadius: 20,
          offset: const Offset(1, 1),
        ),
      ];
    }
    return [];
  }
}

class CarouselItems {
  final String icon;
  final Color color;

  CarouselItems({required this.icon, required this.color});
}
