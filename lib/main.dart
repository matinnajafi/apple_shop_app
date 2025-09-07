import 'dart:ui';

import 'package:apple_shop_app/bloc/category/category_bloc.dart';
import 'package:apple_shop_app/constants/custom_colors.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/screens/card_screen.dart';
import 'package:apple_shop_app/screens/category_screen.dart';
import 'package:apple_shop_app/screens/home_screen.dart';
import 'package:apple_shop_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndexbottomNavigationBar = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: selectedIndexbottomNavigationBar,
          children: getScreens(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  selectedIndexbottomNavigationBar = index;
                });
              },
              currentIndex: selectedIndexbottomNavigationBar,
              selectedLabelStyle: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColors.blue,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'SB',
                fontSize: 12,
                color: CustomColors.gery,
              ),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_profile.png'),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -6,
                          offset: Offset(0.0, 13.0),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_profile_active.png'),
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_basket.png'),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -6,
                          offset: Offset(0.0, 13.0),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_basket_active.png'),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_category.png'),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -6,
                          offset: Offset(0.0, 13.0),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/icon_category_active.png',
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_home.png'),
                  activeIcon: Container(
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -6,
                          offset: Offset(0.0, 13.0),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/icon_home_active.png'),
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      ProfileScreen(),
      CardScreen(),
      // provide bloc for CategoryScreen
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: CategoryScreen(),
      ),
      HomeScreen(),
    ];
  }
}
