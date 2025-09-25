import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/login_screen.dart';
import 'package:apple_shop_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                height: 80.0,
                width: 80.0,
                child: Image.asset('assets/images/icon_application.png'),
              ),
              const SizedBox(height: 50.0),
              const Text(
                '!به اپل شاپ خوش آمدید',
                style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'SB',
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust color for readability
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'در اپل شاپ می‌توانید محصولات اپل را با بهترین قیمت و کیفیت خریداری کنید',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SB',
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust color for readability
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                    // ignore: deprecated_member_use
                    shadowColor: Colors.white.withOpacity(0.2),
                    minimumSize: const Size(double.infinity, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: CustomColors.blue,
                  ),
                  child: const Text(
                    'ورود به حساب کاربری',
                    style: TextStyle(
                      fontFamily: 'SB',
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CustomColors.blue,
                    elevation: 0,
                    side: BorderSide(color: Colors.white, width: 1.4),
                    minimumSize: const Size(double.infinity, 45.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'ثبت نام',
                    style: TextStyle(
                      fontFamily: 'SB',
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
