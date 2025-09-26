import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/welcome_screen.dart';
import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:apple_shop_app/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 44, right: 44, bottom: 32),
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
                      const Expanded(
                        child: Text(
                          'حساب کاربری',
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
            const Text(
              'متین نجفی',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            const Text(
              '09123456789',
              style: TextStyle(fontFamily: 'SM', fontSize: 12),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 20,
                spacing: 14,
                children: const [
                  SettingItem(title: 'علاقه‌مندی‌ها', icon: Icons.favorite),
                  SettingItem(title: 'آدرس ها', icon: Icons.location_pin),
                  SettingItem(
                    title: 'سفارشات',
                    icon: Icons.shopping_bag_rounded,
                  ),
                  SettingItem(title: 'تنظیمات', icon: Icons.settings_rounded),
                  SettingItem(
                    title: 'اطلاعیه ها',
                    icon: Icons.notifications_active_rounded,
                  ),
                  SettingItem(title: 'رهگیری', icon: Icons.fire_truck_rounded),
                  SettingItem(
                    title: 'تخفیف ها',
                    icon: Icons.local_offer_rounded,
                  ),
                  SettingItem(title: 'نقد و نظرات', icon: Icons.star_rounded),
                  SettingItem(title: 'پشتیبانی', icon: Icons.comment_rounded),
                  SettingItem(title: 'بلاگ', icon: Icons.web),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
                color: CustomColors.gery,
              ),
            ),
            const Text(
              'v-1.0.0',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
                color: CustomColors.gery,
              ),
            ),
            const Text(
              'Instagram.com/Mtiw_dev',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
                color: CustomColors.gery,
              ),
            ),
            SizedBox(
              height: 36,
              child: TextButton(
                style: TextButton.styleFrom(overlayColor: CustomColors.red),
                onPressed: () {
                  AuthManager.logout();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider(
                          create: (context) {
                            var authBloc = AuthBloc();
                            authBloc.stream.forEach((state) {
                              if (state is AuthResponseState) {
                                state.response.fold(
                                  (exceptionMessage) {
                                    Text('Error: $exceptionMessage');
                                  },
                                  (successMessage) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const DashboardScreen(),
                                      ),
                                    );
                                    // globalNavigatorKey.currentState
                                    //     ?.pushReplacement(
                                    //       MaterialPageRoute(
                                    //         builder:
                                    //             (context) =>
                                    //                 const DashboardScreen(),
                                    //       ),
                                    //     );
                                  },
                                );
                              }
                            });
                            return authBloc;
                          },
                          child: WelcomeScreen(),
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'خروج از حساب کاربری',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.redAccent,
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
