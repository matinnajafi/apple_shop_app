import 'package:apple_shop_app/data/datasource/authentication_datasource.dart';
import 'package:apple_shop_app/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  // components
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // datasources
  locator.registerFactory<IAuthenticationDataSource>(
    () => AuthenticationRemote(),
  );

  // repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
}
