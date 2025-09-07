import 'package:apple_shop_app/bloc/home/home_event.dart';
import 'package:apple_shop_app/bloc/home/home_state.dart';
import 'package:apple_shop_app/data/repository/banner_repository.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitializeData>((event, state) async {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      // ignore: invalid_use_of_visible_for_testing_member
      emit(HomeGetResponseState(bannerList));
    });
  }
}
