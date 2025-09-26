import 'package:flutter/material.dart';

class AppSnackBar {
  // A static method to show a custom SnackBar
  static void showMessage(
    BuildContext context,
    String message,
    Duration duration, {
    Color color = Colors.redAccent,
  }) {
    final snackBar = SnackBar(
      // Use the provided color or the default Colors.redAccent
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: duration, // set a duration
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          message, // error message
          style: const TextStyle(
            fontFamily: 'SM',
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );

    // Use the ScaffoldMessenger to show the SnackBar
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // Optional: Hide any currently visible snackbar
      ..showSnackBar(snackBar);
  }
}
