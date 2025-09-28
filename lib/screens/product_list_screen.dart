import 'package:apple_shop_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_event.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/screens/home_screen.dart';
import 'package:apple_shop_app/widgets/custom_appbar.dart';
import 'package:apple_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(
      context,
    ).add(CategoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.backgroundScreenColor,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomAppbar(
                    widget.category.title ?? 'لیست محصولات',
                    isSubpage: true,
                  ),
                ),
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(child: LoadingAnimation()),
                },
                if (state is CategoryProductResponseState) ...{
                  state.productListByCategory.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(child: Text(exceptionMessage));
                    },
                    (productList) {
                      if (productList.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 25.0),
                              child: Text(
                                '!محصولی در این دسته‌بندی وجود ندارد',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 44),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return ProductItem(productList[index]);
                            }, childCount: productList.length),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 2 / 2.8,
                                  crossAxisCount: 2,
                                ),
                          ),
                        );
                      }
                    },
                  ),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
