import 'package:apple_shop_app/data/datasource/authentication_datasource.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/api_exception.dart';
import 'package:apple_shop_app/util/auth_manager.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDataSource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _datasource.register('matin894', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی رخ داده');
    } catch (ex) {
      return left('!خطایی رخ داده');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      AuthManager.saveToken(token);
      return right('شما با موفقیت وارد شدید!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطایی در ورود رخ داده!');
    } catch (ex) {
      return left('خطایی در ورود رخ داده!');
    }
  }
}
