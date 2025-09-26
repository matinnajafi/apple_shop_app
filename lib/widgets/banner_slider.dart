import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/banner.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerImage> bannerList;
  const BannerSlider({super.key, required this.bannerList});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.bannerList.length,
          itemBuilder:
              (context, index, realIndex) => SizedBox(
                height: 177,
                width: double.infinity,
                child: CachedImage(
                  imageUrl: widget.bannerList[index].thumbnail,
                  radius: 15,
                ),
              ),
          options: CarouselOptions(
            height: 177,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.bannerList.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: CustomColors.blueIndicator,
              dotColor: Colors.white,
            ),
            onDotClicked: (index) {
              _carouselController.animateToPage(index);
            },
          ),
        ),
      ],
    );
  }
}
