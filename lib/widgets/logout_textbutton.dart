import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/welcome_screen.dart';
import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutTextButton extends StatelessWidget {
  const LogoutTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextButton(
        style: TextButton.styleFrom(
          // ignore: deprecated_member_use
          overlayColor: CustomColors.red.withOpacity(0.1),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      const Text(
                        'خروج از حساب کاربری',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'آیا مطمئن هستید که می‌خواهید خارج شوید؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed:
                                  () => Navigator.of(dialogContext).pop(),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: const Text(
                                'لغو',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                AuthManager.logout();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      var authBloc = AuthBloc();
                                      authBloc.stream.forEach((state) {
                                        if (state is AuthResponseState) {
                                          state.response.fold(
                                            (exceptionMessage) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'خطا: $exceptionMessage',
                                                  ),
                                                ),
                                              );
                                            },
                                            (successMessage) {
                                              Navigator.of(
                                                context,
                                              ).pushReplacement(
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          const DashboardScreen(),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      });
                                      return BlocProvider(
                                        create: (_) => authBloc,
                                        child: WelcomeScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'بله، خروج',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          'خروج از حساب کاربری',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
