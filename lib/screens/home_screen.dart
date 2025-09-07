import 'package:apple_shop_app/bloc/home/home_bloc.dart';
import 'package:apple_shop_app/bloc/home/home_event.dart';
import 'package:apple_shop_app/bloc/home/home_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/banner.dart';
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
                if (state is HomeLoadingState) ...[
                  SliverToBoxAdapter(child: CircularProgressIndicator()),
                ],
                _getAppbar(),
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
                SliverToBoxAdapter(child: RowTitle()),
                _getCategoryList(),
                SliverToBoxAdapter(child: RowTitle()),
                _getBestSellerProduct(),
                SliverPadding(padding: EdgeInsets.only(top: 32)),
                SliverToBoxAdapter(child: RowTitle()),
                _getMostViewedProduct(),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _getBanners extends StatelessWidget {
  List<BannerImage> bannerList;
  _getBanners({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: BannerSlider(bannerList: bannerList));
  }
}

class _getMostViewedProduct extends StatelessWidget {
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

class _getBestSellerProduct extends StatelessWidget {
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

class _getCategoryList extends StatelessWidget {
  const _getCategoryList({super.key});

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
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) {
                return const CategoryItemChip();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _getAppbar extends StatelessWidget {
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
