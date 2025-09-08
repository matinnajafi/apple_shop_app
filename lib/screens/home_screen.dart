import 'package:apple_shop_app/bloc/home/home_bloc.dart';
import 'package:apple_shop_app/bloc/home/home_event.dart';
import 'package:apple_shop_app/bloc/home/home_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/banner.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/widgets/banner_slider.dart';
import 'package:apple_shop_app/widgets/category_item_chip.dart';
import 'package:apple_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                _getAppbar(),
                if (state is HomeLoadingState) ...[
                  SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  ),
                ],
                if (state is HomeGetResponseState) ...[
                  state.bannerList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(child: Text(exceptionMessage));
                    },
                    (bannersList) {
                      return _getBanners(bannerList: bannersList);
                    },
                  ),
                ],
                SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                _getCategoryListTitle(),
                if (state is HomeGetResponseState) ...[
                  state.categoryList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(child: Text(exceptionMessage));
                    },
                    (categoryList) {
                      return _getCategoryList(categoryList);
                    },
                  ),
                ],
                _getBestSellerTitle(),
                _getBestSellerProduct(),
                SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                _getMostViewedTitle(),
                _getMostViewedProduct(),
                SliverPadding(padding: EdgeInsets.only(bottom: 16)),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _getBanners extends StatelessWidget {
  List<BannerImage> bannerList;
  // ignore: unused_element_parameter
  _getBanners({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: BannerSlider(bannerList: bannerList));
  }
}

// ignore: camel_case_types
class _getMostViewedProduct extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getMostViewedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

// ignore: camel_case_types
class _getBestSellerProduct extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getBestSellerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _getCategoryList extends StatelessWidget {
  List<Category> categoryList;
  // ignore: unused_element_parameter
  _getCategoryList(this.categoryList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(right: 44),
            child: ListView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return CategoryItemChip(categoryList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _getAppbar extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
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
                  'assets/images/icon_search.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'جستوجوی محصولات',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: CustomColors.gery,
                      fontFamily: 'SB',
                      fontSize: 14,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/icon_apple_blue.png',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _getBestSellerTitle extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getBestSellerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 16,
          top: 12,
        ),
        child: Row(
          children: [
            Text(
              'پرفروش ترین‌ها',
              style: TextStyle(
                color: CustomColors.gery,
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
            Spacer(),
            Text(
              'مشاهده همه',
              style: TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
            SizedBox(width: 5),
            Image.asset(
              'assets/images/icon_left_category.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _getMostViewedTitle extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getMostViewedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 16),
        child: Row(
          children: [
            Text(
              'پربازدید ترین‌ها',
              style: TextStyle(
                color: CustomColors.gery,
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
            Spacer(),
            Text(
              'مشاهده همه',
              style: TextStyle(
                color: CustomColors.blue,
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
            SizedBox(width: 5),
            Image.asset(
              'assets/images/icon_left_category.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _getCategoryListTitle extends StatelessWidget {
  // ignore: unused_element_parameter
  const _getCategoryListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            Text(
              'دسته‌بندی‌ها',
              style: TextStyle(
                color: CustomColors.gery,
                fontFamily: 'SB',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
