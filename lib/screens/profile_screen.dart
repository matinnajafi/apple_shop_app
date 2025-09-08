import 'package:apple_shop_app/constants/custom_colors.dart';
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
            Padding(
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
            Text('متین نجفی', style: TextStyle(fontFamily: 'SB', fontSize: 16)),
            Text(
              '09123456789',
              style: TextStyle(fontFamily: 'SM', fontSize: 12),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 20,
                spacing: 14,
                children: const [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
