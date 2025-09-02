import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: ShapeDecoration(
              color: Colors.red,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(44),
              ),
              shadows: [
                BoxShadow(
                  blurRadius: 25,
                  spreadRadius: -12,
                  color: Colors.red,
                  offset: Offset(0, 15),
                ),
              ],
            ),

            child: Icon(Icons.mouse, color: Colors.white, size: 28),
          ),
          SizedBox(height: 10),
          Text('همه', style: TextStyle(fontFamily: 'SB', fontSize: 12)),
        ],
      ),
    );
  }
}
