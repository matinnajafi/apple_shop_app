import 'package:apple_shop_app/data/model/banner.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeGetResponseState extends HomeState {
  Either<String, List<BannerImage>> bannerList;
  HomeGetResponseState(this.bannerList);
}
