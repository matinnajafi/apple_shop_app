import 'package:apple_shop_app/bloc/basket/basket_bloc.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/screens/product_detail_screen.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              // provide BasketBloc for ProductDetailScreen
              return BlocProvider<BasketBloc>.value(
                value: locator.get<BasketBloc>(),
                child: ProductDetailScreen(product),
              );
            },
          ),
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 216,
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                    width: 120,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: CachedImage(imageUrl: product.thumbnail),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset(
                        'assets/images/active_fav_product.png',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '٪${product.percent!.round().toString()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SB',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      product.name,
                      style: TextStyle(fontFamily: 'SM', fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 53,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 25,
                          spreadRadius: -12,
                          color: CustomColors.blue,
                          offset: Offset(0, 15),
                        ),
                      ],
                      color: CustomColors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/icon_right_arrow_cricle.png',
                            height: 24,
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                product.price.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 1.4,
                                  fontFamily: 'SM',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                product.realPrice.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SM',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'تومان',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
