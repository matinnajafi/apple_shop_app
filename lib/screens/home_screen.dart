import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/widgets/banner_slider.dart';
import 'package:apple_shop_app/widgets/category_item_chip.dart';
import 'package:apple_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: getAppbar()),
            SliverToBoxAdapter(child: BannerSlider()),
            SliverPadding(padding: EdgeInsets.only(bottom: 32)),
            SliverToBoxAdapter(child: RowTitle()),
            SliverToBoxAdapter(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 44),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const CategoryItemChip();
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: RowTitle()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 216,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductItem(),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverToBoxAdapter(child: RowTitle()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 216,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductItem(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class getAppbar extends StatelessWidget {
  const getAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 44, right: 44, bottom: 32),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/images/icon_apple_blue.png',
                width: 24,
                height: 24,
              ),
              Expanded(
                child: Text(
                  'جستوجوی محصولات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: CustomColors.gery,
                    fontFamily: 'SB',
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Image.asset(
                'assets/images/icon_search.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowTitle extends StatelessWidget {
  const RowTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      child: Row(
        children: [
          Image.asset(
            'assets/images/icon_left_category.png',
            width: 24,
            height: 24,
          ),
          SizedBox(width: 5),
          Text(
            'مشاهده همه',
            style: TextStyle(
              color: CustomColors.blue,
              fontFamily: 'SB',
              fontSize: 12,
            ),
          ),
          Spacer(),
          Text(
            'پرفروش ترین‌ها',
            style: TextStyle(
              color: CustomColors.gery,
              fontFamily: 'SB',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
