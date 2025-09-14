import 'package:apple_shop_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_event.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/category.dart';
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
                                widget.category.title ?? 'لیست محصولات',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: CustomColors.blue,
                                  fontFamily: 'SB',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: CustomColors.blue,
                        ),
                      ),
                    ),
                  ),
                },
                if (state is CategoryProductResponseState) ...{
                  state.productListByCategory.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(child: Text(exceptionMessage));
                    },
                    (productList) {
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
