import 'package:app_links/app_links.dart';
import 'package:apple_shop_app/bloc/basket/basket_event.dart';
import 'package:apple_shop_app/bloc/basket/basket_state.dart';
import 'package:apple_shop_app/data/repository/basket_repository.dart';
import 'package:apple_shop_app/di/di.dart';
import 'package:apple_shop_app/util/extentions/string_extentions.dart';
import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  final PaymentRequest _paymentRequest = PaymentRequest();
  final AppLinks _appLinks = AppLinks();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var basketFinalPrice = await _basketRepository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemList, basketFinalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentRequest.setIsSandBox(true);
      _paymentRequest.setAmount(1000);
      _paymentRequest.setDescription('this is for test application apple shop');
      _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
      _paymentRequest.setCallbackURL('expertflutter://shop');

      _appLinks.stringLinkStream.listen((deeplink) {
        if (deeplink.toLowerCase().contains('authority')) {
          String? authority = deeplink.extractValueFromQuery('Authority');
          String? status = deeplink.extractValueFromQuery('Status');
          ZarinPal().verificationPayment(status!, authority!, _paymentRequest, (
            isPaymentSuccess,
            refID,
            paymentRequest,
            callBackMap,
          ) {
            if (isPaymentSuccess) {
              print('ref Id: $refID');
            } else {
              print('Payment request canceled.');
            }
          });
        }
      });
    });

    on<BasketPaymentRequestEvent>((event, emit) async {
      ZarinPal().startPayment(_paymentRequest, (
        status,
        paymentGatewayUri,
        callBackMap,
      ) {
        // We can manage the other statuses with a switch-case method
        if (status == 100) {
          launchUrl(
            Uri.parse(paymentGatewayUri!),
            mode: LaunchMode.externalApplication,
          );
        }
      });
    });
  }
}
