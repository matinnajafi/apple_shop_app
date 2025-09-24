import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_event.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameController = TextEditingController(
    text: 'matin892',
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

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) : _usernameController = usernameController,
       _passwordController = passwordController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset('assets/images/login_photo.jpg', height: 200),
              const SizedBox(height: 80),
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
                      'نام کاربری :',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.grey[300],
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
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
                      'رمز عبور :',
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.grey[300],
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
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
                        // show error message
                        // print(exceptionMessage);
                      },
                      (successMessage) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthInitiateState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        minimumSize: Size(200, 50),
                        backgroundColor: Colors.blue[800],
                      ),
                      onPressed: () {
                        // send login request
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginRequest(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                        );
                      },
                      child: const Text(
                        'ورود به حساب کاربری',
                        style: TextStyle(
                          fontFamily: 'SB',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }
                  if (state is AuthLoadingState) {
                    return CircularProgressIndicator(
                      color: CustomColors.blueIndicator,
                    );
                  }
                  if (state is AuthResponseState) {
                    return Text(
                      state.response.fold((l) => l, (r) => r),
                      style: TextStyle(
                        fontFamily: 'SB',
                        color:
                            state.response.isLeft()
                                ? CustomColors.red
                                : CustomColors.green,
                        fontSize: 16,
                      ),
                    );
                  }
                  return const Text('خطای نامشخص');
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text(
                  'اگر حساب کاربری ندارید ثبت نام کنید',
                  style: TextStyle(
                    fontFamily: 'SM',
                    color: CustomColors.blueIndicator,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
