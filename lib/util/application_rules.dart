import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class getRulesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 6.0),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset('assets/images/icon_rules.png'),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: double.infinity),
                        const Text(
                          'حریم خصوصی',
                          style: TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        const Text(
                          'اطلاعات شما نزد ما کاملاً محفوظ است؛ ما فقط از آن برای بهبود تجربه خریدتان استفاده می‌کنیم و هرگز آن را در اختیار شخص ثالثی نمی‌گزاریم',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: double.infinity),
                        const Text(
                          'قوانین خرید',
                          style: TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        const Text(
                          'قیمت‌های ما نهایی است و در صورت نارضایتی، می‌توانید طبق قوانین بازگشت کالا اقدام کنید',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: double.infinity),
                        const Text(
                          'حق کپی‌رایت',
                          style: TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        const Text(
                          'تمامی محتوای برنامه متعلق به جامعه برنامه نویسان موبایل است ولی هرگونه کپی‌برداری غیر مجاز یا سوء نیت از آن پیگرد قانونی دارد',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4.0,
                        // ignore: deprecated_member_use
                        shadowColor: Colors.white.withOpacity(0.2),
                        minimumSize: const Size(double.infinity, 45.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: CustomColors.blue,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'متوجه شدم',
                        style: TextStyle(
                          fontFamily: 'SM',
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
