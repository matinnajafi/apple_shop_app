import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_event.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _usernameController = TextEditingController(
    text: '',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '12345678',
  );
  final TextEditingController _passwordConfirmController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
        usernameController: _usernameController,
        passwordController: _passwordController,
        passwordConfirmController: _passwordConfirmController,
      ),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required TextEditingController passwordConfirmController,
  }) : _usernameController = usernameController,
       _passwordController = passwordController,
       _passwordConfirmController = passwordConfirmController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;
  final TextEditingController _passwordConfirmController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset('assets/images/register.jpg', height: 200),
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
                          'تکرار رمز عبور :',
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
                            controller: _passwordConfirmController,
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
                            _usernameController.clear();
                            _passwordController.clear();
                            _passwordConfirmController.clear();
                            var snackBar = SnackBar(
                              backgroundColor: Colors.red,
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
                            // send register request
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthRegisterRequest(
                                _usernameController.text,
                                _passwordController.text,
                                _passwordConfirmController.text,
                              ),
                            );
                          },
                          child: const Text(
                            'ثبت نام',
                            style: TextStyle(
                              fontFamily: 'SB',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                      if (state is AuthLoadingState) {
                        return const CircularProgressIndicator(
                          color: CustomColors.blueIndicator,
                        );
                      }
                      if (state is AuthResponseState) {
                        Widget widget = Text('');
                        state.response.fold(
                          (l) {
                            widget = ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                minimumSize: const Size(200, 50),
                                backgroundColor: Colors.blue[800],
                              ),
                              onPressed: () {
                                // send register request
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthRegisterRequest(
                                    _usernameController.text,
                                    _passwordController.text,
                                    _passwordConfirmController.text,
                                  ),
                                );
                              },
                              child: const Text(
                                'ثبت نام',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  color: Colors.white,
                                  fontSize: 18,
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'قبلا ثبت نام کرده اید؟ وارد شوید',
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
            ],
          ),
        ),
      ),
    );
  }
}
