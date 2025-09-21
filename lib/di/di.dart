import 'package:apple_shop_app/bloc/basket/basket_bloc.dart';
import 'package:apple_shop_app/data/datasource/authentication_datasource.dart';
import 'package:apple_shop_app/data/datasource/banner_datasource.dart';
import 'package:apple_shop_app/data/datasource/basket_datasource.dart';
import 'package:apple_shop_app/data/datasource/category_datasource.dart';
import 'package:apple_shop_app/data/datasource/category_product_datasource.dart';
import 'package:apple_shop_app/data/datasource/comment_datasource.dart';
import 'package:apple_shop_app/data/datasource/product_datasource.dart';
import 'package:apple_shop_app/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop_app/data/repository/authentication_repository.dart';
import 'package:apple_shop_app/data/repository/banner_repository.dart';
import 'package:apple_shop_app/data/repository/basket_repository.dart';
import 'package:apple_shop_app/data/repository/category_product_repository.dart';
import 'package:apple_shop_app/data/repository/category_repository.dart';
import 'package:apple_shop_app/data/repository/comment_repository.dart';
import 'package:apple_shop_app/data/repository/product_detail_repository.dart';
import 'package:apple_shop_app/data/repository/product_repository.dart';
import 'package:apple_shop_app/util/payment_handler.dart';
import 'package:apple_shop_app/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  // components
  await _initComponents();

  // datasources
  _initDatasources();

  // repositories
  _initRepositories();

  // bloc
  _initBloc();
}

Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );

  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  //util
  locator.registerSingleton<UrlHandler>(UrlLauncher());
  locator.registerSingleton<PaymentHandler>(
    ZarinpalPaymentHandler(locator.get()),
  );
}

void _initDatasources() {
  locator.registerSingleton<IAuthenticationDataSource>(AuthenticationRemote());

  locator.registerSingleton<ICategoryDatasource>(CategoryRemoteDatasource());

  locator.registerSingleton<IBannerDatasource>(BannerRemoteDatasource());
  locator.registerSingleton<IProductDatasource>(ProductRemoteDatasource());
  locator.registerSingleton<IDetailProductDatasource>(
    DetailProductRemoteDatasource(),
  );
  locator.registerSingleton<ICategoryProductDatasource>(
    CategoryProductRemoteDatasource(),
  );
  locator.registerSingleton<IBasketDatasource>(BasketLocalDatasource());
  locator.registerSingleton<ICommentDatasource>(CommentRemoteDatasource());
}

void _initRepositories() {
  locator.registerSingleton<IAuthRepository>(AuthenticationRepository());
  locator.registerSingleton<ICategoryRepository>(CategoryRepository());
  locator.registerSingleton<IBannerRepository>(BannerRepository());
  locator.registerSingleton<IProductRepository>(ProductRepository());
  locator.registerSingleton<IDetailProductRepository>(
    DetailProductRepository(),
  );
  locator.registerSingleton<ICategoryProductRepository>(
    CategoryProductRepository(),
  );
  locator.registerSingleton<IBasketRepository>(BasketRepository());
  locator.registerSingleton<ICommentRepository>(CommentRepository());
}

void _initBloc() {
  locator.registerSingleton<BasketBloc>(
    BasketBloc(locator.get(), locator.get()),
  );
}
