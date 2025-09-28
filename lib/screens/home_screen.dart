import 'package:apple_shop_app/bloc/home/home_bloc.dart';
import 'package:apple_shop_app/bloc/home/home_event.dart';
import 'package:apple_shop_app/bloc/home/home_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/banner.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/widgets/banner_slider.dart';
import 'package:apple_shop_app/widgets/category_item_chip.dart';
import 'package:apple_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _getHomeScreenContent(state, context);
          },
        ),
      ),
    );
  }
}

Widget _getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return const LoadingAnimation();
  } else if (state is HomeGetResponseState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(HomeGetInitializeData());
      },
      child: CustomScrollView(
        slivers: [
          const _getAppbar(),
          state.bannerList.fold(
            (exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            },
            (bannersList) {
              return _getBanners(bannerList: bannersList);
            },
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
          const _getCategoryListTitle(),
          state.categoryList.fold(
            (exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            },
            (categoryList) {
              return _getCategoryList(categoryList);
            },
          ),
          const _getBestSellerTitle(),
          state.bestSellerProductList.fold(
            (exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            },
            (bestSellerProductList) {
              return _getBestSellerProduct(bestSellerProductList);
            },
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
          const _getMostViewedTitle(),
          state.hotestProductList.fold(
            (exceptionMessage) {
              return SliverToBoxAdapter(child: Text(exceptionMessage));
            },
            (hotestProductList) {
              return _getMostViewedProduct(hotestProductList);
            },
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  } else {
    return Center(child: Text('خطایی در دریافت داده ها رخ داده است!'));
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCircle(color: CustomColors.blue, size: 60.0),
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

// ignore: camel_case_types, must_be_immutable
class _getMostViewedProduct extends StatelessWidget {
  List<Product> mostViewedProductList;
  // ignore: unused_element_parameter
  _getMostViewedProduct(this.mostViewedProductList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 216,
        child: Padding(
          padding: const EdgeInsets.only(right: 44),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mostViewedProductList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(mostViewedProductList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class _getBestSellerProduct extends StatelessWidget {
  List<Product> bestSellerProductList;
  // ignore: unused_element_parameter
  _getBestSellerProduct(this.bestSellerProductList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 216,
        child: Padding(
          padding: const EdgeInsets.only(right: 44),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bestSellerProductList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(bestSellerProductList[index]),
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
        padding: EdgeInsets.only(right: 44, left: 44, top: 22, bottom: 28),
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
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 8),
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
