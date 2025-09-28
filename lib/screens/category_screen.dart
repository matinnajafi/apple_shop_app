import 'package:apple_shop_app/bloc/category/category_bloc.dart';
import 'package:apple_shop_app/bloc/category/category_event.dart';
import 'package:apple_shop_app/bloc/category/category_state.dart';
import 'package:apple_shop_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/screens/product_list_screen.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:apple_shop_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryListRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppbar('دسته بندی', isSubpage: false),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryInitState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'در حال آماده‌سازی دسته‌بندی‌ها...',
                        style: TextStyle(
                          color: CustomColors.blue,
                          fontFamily: 'SB',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }
                if (state is CategoryLoadingState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.blueIndicator,
                      ),
                    ),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.response.fold(
                    (l) {
                      return SliverToBoxAdapter(child: Text(l));
                    },
                    (r) {
                      return GetCategoryList(list: r);
                    },
                  );
                }
                return SliverToBoxAdapter(child: Text('error'));
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

class GetCategoryList extends StatelessWidget {
  final List<Category>? list;
  const GetCategoryList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => CategoryProductBloc(),
                        child: ProductListScreen(list![index]),
                      ),
                ),
              );
            },
            child: CachedImage(imageUrl: list?[index].thumbnail),
          );
        }, childCount: list?.length ?? 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
