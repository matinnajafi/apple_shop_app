import 'package:flutter/material.dart';

class AppSnackBar {
  // A static method to show a custom error SnackBar
  static void showError(
    BuildContext context,
    String message,
    Duration duration,
  ) {
    final snackBar = SnackBar(
      backgroundColor: Colors.redAccent,
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
