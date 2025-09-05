import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/bloc/authentication/auth_event.dart';
import 'package:apple_shop_app/bloc/authentication/auth_state.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
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
                    SizedBox(height: 20),
                    Text(
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
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
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
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          labelStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: CustomColors.blue,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
                                // send login request
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthLoginRequest(
                                    _usernameController.text,
                                    _passwordController.text,
                                  ),
                                );
                              },
                              child: Text(
                                'ورود به حساب کاربری',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  color: Colors.white,
                                  fontSize: 18,
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
                          return Text('خطای نامشخص');
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
