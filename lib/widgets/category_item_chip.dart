import 'package:apple_shop_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/screens/product_list_screen.dart';
import 'package:apple_shop_app/util/extentions/string_extentions.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CategoryItemChip extends StatelessWidget {
  Category category;
  CategoryItemChip(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                    create: (context) => CategoryProductBloc(),
                    child: ProductListScreen(category),
                  ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: ShapeDecoration(
                    color: category.color.parseToColor(), // Use ColorExtention
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                    shadows: [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: -12,
                        color:
                            category.color.parseToColor(), // Use ColorExtention
                        offset: Offset(0, 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(child: CachedImage(imageUrl: category.icon)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              category.title ?? 'محصول',
              style: TextStyle(fontFamily: 'SB', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
