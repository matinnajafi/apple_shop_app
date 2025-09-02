import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(viewportFraction: 0.8);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red,
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
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: CustomColors.blueIndicator,
              dotColor: Colors.white,
            ),
            controller: controller,
            count: 3,
          ),
        ),
      ],
    );
  }
}
