import 'package:apple_shop_app/data/model/category.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItemChip extends StatelessWidget {
  Category category;
  CategoryItemChip(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    String categoryColor = '0xff${category.color}';
    int hexColor = int.parse(categoryColor);
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(hexColor),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(44),
                  ),
                  shadows: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: -12,
                      color: Color(hexColor),
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: CachedImage(imageUrl: category.icon),
              ),
            ],
          ),

          SizedBox(height: 10),
          Text(
            category.title ?? 'محصول',
            style: TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
