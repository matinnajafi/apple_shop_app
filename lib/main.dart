import 'package:apple_shop_app/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop_app/data/model/basket_item.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/screens/dashboard_screen.dart';
import 'package:apple_shop_app/screens/login_screen.dart';
import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>(
    'BasketBox',
  ); // basket Hive should be Initialized before getItInit(), cause basket bloc have dependencies with this
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndexbottomNavigationBar =
      3; // with index 3: Starting from the home page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: globalNavigatorKey,
      home: Scaffold(
        body:
            (AuthManager.readAuth().isEmpty) // user is not logged in
                ? BlocProvider(
                  create: (context) => AuthBloc(),
                  child: LoginScreen(),
                )
                : DashboardScreen(), // user is logged in
      ),
    );
  }
}
