import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_event.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/register_screen.dart';
import 'package:apple_shop_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameController = TextEditingController(
    text: 'matinnajafi',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '12345678',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
        usernameController: _usernameController,
        passwordController: _passwordController,
      ),
    );
  }
}

class ViewContainer extends StatefulWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) : _usernameController = usernameController,
       _passwordController = passwordController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
  bool _isobscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
              color: CustomColors.backgroundScreenColor,
            ),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ورود به حساب کاربری',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 26.0,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 34.0),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 24.0,
                          left: 24.0,
                          bottom: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'نام کاربری:',
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 12.0,
                                  left: 12.0,
                                  top: 2.0,
                                ),
                                child: TextField(
                                  controller: widget._usernameController,
                                  style: const TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 24.0,
                          left: 24.0,
                          bottom: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'رمز عبور:',
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 12.0,
                                      left: 12.0,
                                      top: 2.0,
                                    ),
                                    child: TextField(
                                      controller: widget._passwordController,
                                      obscureText: _isobscure,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: const TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isobscure = !_isobscure;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      child: Icon(
                                        (_isobscure)
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: Colors.grey[600],
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: RoundCheckBox(
                                checkedWidget: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                uncheckedWidget: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                isRound: false,
                                animationDuration: const Duration(
                                  milliseconds: 200,
                                ),
                                size: 22,
                                borderColor: Colors.white,
                                checkedColor: CustomColors.blue,
                                uncheckedColor: Colors.grey[300],
                                onTap: (selected) {},
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            const Text(
                              'مرا به خاطر بسپار',
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                                color: CustomColors.gery,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'رمز را فراموش کرده‌اید؟',
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                                color: CustomColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthResponseState) {
                            state.response.fold(
                              (exceptionMessage) {
                                widget._usernameController.clear();
                                widget._passwordController.clear();
                                var snackBar = SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  content: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      exceptionMessage,
                                      style: const TextStyle(
                                        fontFamily: 'SM',
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              },
                              (successMessage) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const DashboardScreen(),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthInitiateState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 4.0,
                                  // ignore: deprecated_member_use
                                  shadowColor: Colors.white.withOpacity(0.2),
                                  minimumSize: const Size(
                                    double.infinity,
                                    50.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: CustomColors.blue,
                                ),
                                onPressed: () {
                                  // send login request
                                  BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginRequest(
                                      widget._usernameController.text,
                                      widget._passwordController.text,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'ورود به حساب',
                                  style: TextStyle(
                                    fontFamily: 'SM',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is AuthLoadingState) {
                            return CircularProgressIndicator(
                              color: Colors.blue[800],
                            );
                          }
                          if (state is AuthResponseState) {
                            Widget widget = Text('');
                            state.response.fold(
                              (l) {
                                widget = Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 4.0,
                                      // ignore: deprecated_member_use
                                      shadowColor: Colors.white.withOpacity(
                                        0.2,
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        50.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      backgroundColor: CustomColors.blue,
                                    ),
                                    onPressed: () {
                                      // send login request
                                      BlocProvider.of<AuthBloc>(context).add(
                                        AuthLoginRequest(
                                          this.widget._usernameController.text,
                                          this.widget._passwordController.text,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'ورود به حساب',
                                      style: TextStyle(
                                        fontFamily: 'SM',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              (r) {
                                return widget = Text(
                                  r,
                                  style: const TextStyle(
                                    fontFamily: 'SM',
                                    color: Colors.green,
                                    fontSize: 14,
                                  ),
                                );
                              },
                            );
                            return widget;
                          }
                          return const Text('خطای نامشخص');
                        },
                      ),
                      const SizedBox(height: 30.0),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1.0,
                            indent: 24.0,
                            endIndent: 24.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            height: 24,
                            decoration: BoxDecoration(
                              color: CustomColors.backgroundScreenColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                'ورود از طریق',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  color: Colors.grey[500],
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 40.0,
                        children: [
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Image.asset(
                              'assets/images/icon_apple_black.png',
                            ),
                          ),
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Image.asset('assets/images/icon_google.png'),
                          ),
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Image.asset(
                              'assets/images/icon_twitter.png',
                            ),
                          ),
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Image.asset(
                              'assets/images/icon_facebook.png',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'حساب کاربری ندارید؟ ',
                            style: TextStyle(
                              fontFamily: 'SM',
                              color: CustomColors.gery,
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'ثبت نام کنید',
                              style: TextStyle(
                                fontFamily: 'SM',
                                color: CustomColors.blueIndicator,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: CustomColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'بازگشت',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
