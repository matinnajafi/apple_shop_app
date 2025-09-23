import 'package:app_links/app_links.dart';
import 'package:apple_shop_app/util/extentions/string_extentions.dart';
import 'package:apple_shop_app/util/url_handler.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int finalPrice);
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  final AppLinks _appLinks = AppLinks();
  String? _authority;
  String? _status;
  final UrlHandler _urlHandler;

  ZarinpalPaymentHandler(this._urlHandler);

  @override
  Future<void> initPaymentRequest(int finalPrice) async {
    _paymentRequest.setIsSandBox(
      true,
    ); // true for testing , flase for real payment gateway
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription('this is for test application apple shop');
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    _paymentRequest.setCallbackURL('expertflutter://shop');

    _appLinks.stringLinkStream.listen((deeplink) {
      if (deeplink.toLowerCase().contains('authority')) {
        _authority = deeplink.extractValueFromQuery('Authority');
        _status = deeplink.extractValueFromQuery('Status');
        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (
      status,
      paymentGatewayUri,
      callBackMap,
    ) {
      // We can manage the other statuses with a switch-case method
      if (status == 100) {
        _urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(_status!, _authority!, _paymentRequest, (
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
}

// this is for testing different payment gateways
// class PaypalPaymentHandler extends PaymentHandler {
//   @override
//   Future<void> initPaymentRequest() async {}

//   @override
//   Future<void> sendPaymentRequest() async {}

//   @override
//   Future<void> verifyPaymentRequest() async {}
// }
