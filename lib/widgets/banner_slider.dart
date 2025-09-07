import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/banner.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class BannerSlider extends StatelessWidget {
  List<BannerImage> bannerList;
  BannerSlider({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            itemCount: bannerList.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: CachedImage(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: CustomColors.blueIndicator,
              dotColor: Colors.white,
            ),
            controller: controller,
            count: bannerList.length,
          ),
        ),
      ],
    );
  }
}
