import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/home/domain/entities/home_banner_entity.dart';

class AutoMovingAdsCarousel extends StatefulWidget {
  final List<HomeBannerEntity> banners;

  const AutoMovingAdsCarousel({super.key, required this.banners});

  @override
  State<AutoMovingAdsCarousel> createState() => _AutoMovingAdsCarouselState();
}

class _AutoMovingAdsCarouselState extends State<AutoMovingAdsCarousel> {
  late final PageController _pageController;
  Timer? _autoMoveTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _startAutoMovingEngine();
  }

  void _startAutoMovingEngine() {
    _autoMoveTimer?.cancel();
    if (widget.banners.length <= 1) return;

    _autoMoveTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_pageController.hasClients) return;

      if (_currentIndex < widget.banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void didUpdateWidget(covariant AutoMovingAdsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners.length != widget.banners.length) {
      _currentIndex = 0;
      _startAutoMovingEngine();
    }
  }

  @override
  void dispose() {
    _autoMoveTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = context.appTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomImageView(
                  imagePath: widget.banners[index].imageUrl,
                  radius: BorderRadius.circular(16),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.banners.length,
          effect: WormEffect(
            dotHeight: 8,
            dotColor: theme.primaryColor300,
            activeDotColor: theme.primaryColor,
          ),
          onDotClicked: (index) {},
        ),
      ],
    );
  }
}
