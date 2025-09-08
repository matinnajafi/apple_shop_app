import 'package:apple_shop_app/data/model/banner.dart';
import 'package:apple_shop_app/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeGetResponseState extends HomeState {
  Either<String, List<BannerImage>> bannerList;
  Either<String, List<Category>> categoryList;
  HomeGetResponseState(this.bannerList, this.categoryList);
}
