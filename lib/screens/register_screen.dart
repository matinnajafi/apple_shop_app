import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_event.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.blue,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/icon_application.png'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'نام کاربری',
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          labelText: 'تکرار رمز عبور',
                          labelStyle: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitiateState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: Size(200, 50),
                                backgroundColor: Colors.blueAccent,
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
                    ],
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
