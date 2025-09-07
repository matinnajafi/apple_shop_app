import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CachedImage extends StatelessWidget {
  String? imageUrl;
  double radius; // Optional
  CachedImage({super.key, this.imageUrl, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl!,
        placeholder:
            (context, url) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: CustomColors.gery,
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.red[300],
              ),
              child: Center(
                child: Icon(Icons.error, color: Colors.red, size: 34),
              ),
            ),
      ),
    );
  }
}
