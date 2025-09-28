import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/widgets/custom_appbar.dart';
import 'package:apple_shop_app/widgets/logout_textbutton.dart';
import 'package:apple_shop_app/widgets/setting_item.dart';
import 'package:flutter/material.dart';

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
            const CustomAppbar('حساب کاربری', isSubpage: false),
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
            const LogoutTextButton(),
          ],
        ),
      ),
    );
  }
}
