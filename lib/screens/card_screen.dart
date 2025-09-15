import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/util/extentions/string_extentions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
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
                                'سبد خرید',
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CardItem();
                  }, childCount: 10),
                ),
                SliverPadding(padding: EdgeInsets.only(bottom: 60)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 44, left: 44, bottom: 10),
              child: SizedBox(
                height: 53,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ادامه فرایند خرید',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SM',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 44, left: 44, bottom: 20),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CustomColors.gery,
            blurRadius: 12.0,
            spreadRadius: -6.0,
            offset: Offset(2.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'آیفون 13 پرو مکس',
                          style: TextStyle(fontSize: 16, fontFamily: 'SB'),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'گارانتی 18 ماهه الماس رایان',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SM',
                            color: CustomColors.gery,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Text(
                                    '3%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SB',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'تومان',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SM',
                                color: CustomColors.gery,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '12,000,000',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SM',
                                color: CustomColors.gery,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          alignment: WrapAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: CustomColors.red.withOpacity(0.6),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'حذف',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'SM',
                                        color: CustomColors.red,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const SizedBox(width: 4),
                                    Image.asset(
                                      'assets/images/icon_trash.png',
                                      scale: 1.1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            optionCheap('آبی', color: '3B5EDF'),
                            optionCheap('256 گیگابایت'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/images/iphone.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 1.0,
              dashLength: 6.0,
              dashGapLength: 3.0,
              dashColor: CustomColors.gery.withOpacity(0.5),
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16),
                ),
                const SizedBox(width: 5),
                const Text(
                  '12,450,000',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class optionCheap extends StatelessWidget {
  String? color;
  String title;
  optionCheap(this.title, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.gery.withOpacity(0.6), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                height: 14,
                width: 14,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: color.parseToColor(),
                  shape: BoxShape.circle,
                ),
              ),
            },
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontFamily: 'SM'),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
