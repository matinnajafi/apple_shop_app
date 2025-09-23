import 'dart:math' as math;
import 'dart:ui';

import 'package:apple_shop_app/bloc/basket/basket_bloc.dart';
import 'package:apple_shop_app/bloc/basket/basket_event.dart';
import 'package:apple_shop_app/bloc/comment/comment_bloc.dart';
import 'package:apple_shop_app/bloc/comment/comment_event.dart';
import 'package:apple_shop_app/bloc/comment/comment_state.dart';
import 'package:apple_shop_app/bloc/product/product_bloc.dart';
import 'package:apple_shop_app/bloc/product/product_event.dart';
import 'package:apple_shop_app/bloc/product/product_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/data/model/comment.dart';
import 'package:apple_shop_app/data/model/product.dart';
import 'package:apple_shop_app/data/model/productImage.dart';
import 'package:apple_shop_app/data/model/product_property.dart';
import 'package:apple_shop_app/data/model/product_variant.dart';
import 'package:apple_shop_app/data/model/variant.dart';
import 'package:apple_shop_app/data/model/variant_type.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/screens/home_screen.dart';
import 'package:apple_shop_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProductBloc();
        bloc.add(
          ProductDetailInitialEvent(
            widget.product.id,
            widget.product.categoryId,
            widget.product.name,
          ),
        );
        return bloc;
      },
      child: DetailsContentWidget(parentWidget: widget),
    );
  }
}

class DetailsContentWidget extends StatelessWidget {
  const DetailsContentWidget({super.key, required this.parentWidget});

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailLoadingState) ...{
                  const SliverToBoxAdapter(child: LoadingAnimation()),
                } else ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 44,
                        right: 44,
                        bottom: 32,
                      ),
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
                              if (state is ProductDetailResponseState) ...{
                                state.productCategory.fold(
                                  (exceptionMessage) {
                                    return Expanded(
                                      child: Text(
                                        'جزئیات محصول',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: CustomColors.blue,
                                          fontFamily: 'SB',
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                  (productCategory) {
                                    return Expanded(
                                      child: Text(
                                        productCategory.title ?? 'محصول',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: CustomColors.blue,
                                          fontFamily: 'SB',
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              },
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  'assets/images/icon_back.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is ProductDetailResponseState) ...{
                    state.productName.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              'محصول جدید',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'SB', fontSize: 16),
                            ),
                          ),
                        );
                      },
                      (productName) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              productName.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'SB', fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  },
                  if (state is ProductDetailResponseState) ...[
                    state.productImages.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productImageList) {
                        return _getGalleryWidget(
                          productImageList,
                          parentWidget.product.thumbnail,
                        );
                      },
                    ),
                  ],
                  if (state is ProductDetailResponseState) ...[
                    state.productVariant.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productVariantList) {
                        return VariantContainerGenerator(
                          productVariantList,
                        ); // Product variants
                      },
                    ),
                  ],
                  if (state is ProductDetailResponseState) ...{
                    state.productProperties.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (productProperyList) {
                        return getProductProperties(productProperyList);
                      },
                    ),
                  },
                  getProductDescription(parentWidget.product.description),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              child: DraggableScrollableSheet(
                                initialChildSize: 0.8,
                                minChildSize: 0.6,
                                maxChildSize: 0.9,
                                builder: (context, controller) {
                                  return CommentBottomSheet(
                                    controller,
                                    productId: parentWidget.product.id,
                                  );
                                },
                              ),
                              create: (context) {
                                var bloc = CommentBloc(locator.get());
                                bloc.add(
                                  CommentInitializeEvent(
                                    parentWidget.product.id,
                                  ),
                                );
                                return bloc;
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 44,
                          right: 44,
                          top: 24,
                        ),
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: CustomColors.gery,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon_left_category.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'مشاهده',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColors.blue,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: CustomColors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: CustomColors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: CustomColors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: CustomColors.gery,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'SM',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                ': نظرات کاربران',
                                style: TextStyle(fontFamily: 'SM'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 44,
                        right: 44,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceTagButton(),
                          AddButtonToBasket(parentWidget.product),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet(this.controller, {super.key, required this.productId});
  final ScrollController controller;
  final String productId;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return LoadingAnimation();
        } else if (state is CommentResponseState) {
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    state.response.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (commentList) {
                        if (commentList.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'برای این محصول کامنتی ثبت نشده!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'SB',
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: commentList.length,
                              (context, index) {
                                final commentItem = commentList[index];
                                return _buildCommentItem(commentItem);
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: CustomColors.blue,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: GestureDetector(
                                onTap: () {
                                  if (textController.text.trim().isEmpty) {
                                    return;
                                    // show error snackbar or...
                                  }
                                  context.read<CommentBloc>().add(
                                    CommentPostEvent(
                                      productId,
                                      textController.text,
                                    ),
                                  );
                                  textController.clear();
                                },
                                child: const SizedBox(
                                  height: 53,
                                  child: Center(
                                    child: Text(
                                      'ثبت نظر',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'SB',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is CommentErrorState) {
          return Text('خطایی رخ داده!');
        } else {
          return Text('خطای نامشخصی رخ داده!');
        }
      },
    );
  }
}

Widget _buildCommentItem(Comment commentItem) {
  // checks for empty/null username and avatar
  final isUsernameEmpty = commentItem.username?.isEmpty ?? true;
  final isAvatarEmpty = commentItem.avatar?.isEmpty ?? true;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Display username or a default value
                Text(
                  isUsernameEmpty ? 'کاربر' : commentItem.username!,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: isUsernameEmpty ? 'SM' : 'SB',
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                // Display comment text safely, providing an empty string if null
                Text(
                  commentItem.text ?? '',
                  style: const TextStyle(fontSize: 14, fontFamily: 'SM'),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          // Display user avatar or a default placeholder
          SizedBox(
            height: 34,
            width: 34,
            child:
                isAvatarEmpty
                    ? Image.asset('assets/images/avatar.png')
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(34),
                      child: CachedImage(
                        imageUrl: commentItem.userThumbnailUrl,
                      ),
                    ),
          ),
        ],
      ),
    ),
  );
}

// ignore: must_be_immutable, camel_case_types
class getProductProperties extends StatefulWidget {
  List<ProductProperty> productPropertyList;
  getProductProperties(this.productPropertyList, {super.key});

  @override
  State<getProductProperties> createState() => _getProductPropertiesState();
}

// ignore: camel_case_types
class _getProductPropertiesState extends State<getProductProperties> {
  bool _isVisible = false;
  int _tapCount = 0; // To avoid displaying too much snack bar

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.productPropertyList.isEmpty) {
                setState(() {
                  _isVisible = false;
                });

                // todo: this part is for show snackBar
                _tapCount++;
                if (_tapCount >= 6) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '!برای این محصول مشخصاتی ثبت نشده',
                        textAlign: TextAlign.right,
                      ),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                // todo: end
              } else {
                setState(() {
                  _isVisible = !_isVisible;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.gery, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // rotate left and bottom for arrow
                    Transform.rotate(
                      angle: _isVisible ? -(math.pi / 2) : 0,
                      child: Image.asset(
                        'assets/images/icon_left_category.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.arrow_forward, size: 50);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustomColors.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': مشخصات فنی',
                      style: TextStyle(fontFamily: 'SM'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomColors.gery, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.productPropertyList.length,
                    itemBuilder: (context, index) {
                      var property = widget.productPropertyList[index];
                      return Flexible(
                        child: Text(
                          '${property.title} : ${property.value}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class getProductDescription extends StatefulWidget {
  String productDescription;

  getProductDescription(this.productDescription, {super.key});

  @override
  State<getProductDescription> createState() => _getProductDescriptionState();
}

// ignore: camel_case_types
class _getProductDescriptionState extends State<getProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.gery, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // rotate left and bottom for arrow
                    Transform.rotate(
                      angle: _isVisible ? -(math.pi / 2) : 0,
                      child: Image.asset(
                        'assets/images/icon_left_category.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.arrow_forward, size: 50);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                        color: CustomColors.blue,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      ': توضیحات محصول',
                      style: TextStyle(fontFamily: 'SM'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.gery, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.productDescription,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'SM',
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VariantContainerGenerator extends StatelessWidget {
  List<ProductVarint> productVariantList;
  VariantContainerGenerator(this.productVariantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant),
            },
          },
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VariantGeneratorChild extends StatelessWidget {
  ProductVarint productVarint;
  VariantGeneratorChild(this.productVarint, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, left: 44, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVarint.variantType.title!,
            style: TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
          const SizedBox(height: 10),
          Builder(
            builder: (context) {
              switch (productVarint.variantType.type) {
                case VariantTypeEnum.COLOR:
                  return ColorVariantList(productVarint.variantList);
                case VariantTypeEnum.STORAGE:
                  return StorageVariantList(productVarint.variantList);
                case VariantTypeEnum.VOLTAGE:
                  // return VoltageVariantList(productVarint.variantList);
                  // Fallback for unimplemented case
                  return const SizedBox.shrink();
                default:
                  // Return an empty widget if the type is not handled
                  return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => ColorVariantListState();
}

class ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.variantList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String categoryColor = '0xff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(1),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  border:
                      (_selectedIndex == index)
                          ? Border.all(
                            color: CustomColors.blueIndicator,
                            width: 1.8,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                          : Border.all(
                            color: Colors.white,
                            width: 1.0,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                  color: CustomColors.backgroundScreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariants;
  StorageVariantList(this.storageVariants, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.storageVariants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      (_selectedIndex == index)
                          ? Border.all(
                            color: CustomColors.blueIndicator,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                          : Border.all(
                            color: CustomColors.gery,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.storageVariants[index].value!,
                      style: TextStyle(fontFamily: 'SB', fontSize: 12),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _getGalleryWidget extends StatefulWidget {
  List<Productimage> productImageList;
  String defaultProductThumbnail;
  int selectedItem = 0;
  // ignore: unused_element_parameter
  _getGalleryWidget(
    this.productImageList,
    this.defaultProductThumbnail, {
    // ignore: unused_element_parameter
    super.key,
  });

  @override
  State<_getGalleryWidget> createState() => _getGalleryWidgetState();
}

// ignore: camel_case_types
class _getGalleryWidgetState extends State<_getGalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 44),
        height: 284,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.gery,
              blurRadius: 40,
              spreadRadius: -24,
              offset: Offset(0.0, 24.0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/icon_star.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          '4.6',
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: CachedImage(
                          radius: 4.0,
                          imageUrl:
                              (widget.productImageList.isEmpty)
                                  ? (widget.defaultProductThumbnail)
                                  : (widget
                                      .productImageList[widget.selectedItem]
                                      .imageUrl),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/icon_favorite_deactive.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (widget.productImageList.isNotEmpty) ...{
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(4),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomColors.gery,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: CachedImage(
                                imageUrl:
                                    widget.productImageList[index].imageUrl,
                                radius: 10,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            },
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddButtonToBasket extends StatelessWidget {
  Product product;
  AddButtonToBasket(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 58,
          width: 140,
          decoration: BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: GestureDetector(
              onTap: () {
                // event for add product to shopping basket (in card screen)
                context.read<ProductBloc>().add(
                  AddProductToBasketEvent(product),
                );
                // event for update card screen
                context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
              },
              child: SizedBox(
                height: 53,
                width: 160,
                child: Center(
                  child: Text(
                    'افزودن سبد خرید',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'SB',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 58,
          width: 140,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SizedBox(
              height: 53,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),

                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '15,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '12,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SM',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '3%',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'SB',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
