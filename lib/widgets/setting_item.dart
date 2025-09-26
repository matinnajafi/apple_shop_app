import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:flutter/material.dart';

// Item Chip for profile screen
class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          // navigate to any screen // do somethings
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
                    color: CustomColors.blueIndicator, // Use ColorExtention
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                    shadows: const [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: -12,
                        color: CustomColors.blue, // Use ColorExtention
                        offset: Offset(0, 15),
                      ),
                    ],
                  ),
                ),
                Icon(icon, size: 30.0, color: Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontFamily: 'SB', fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
