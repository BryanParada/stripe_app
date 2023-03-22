import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart'; 

import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeService{

  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance; //al llamar la instancia

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey = dotenv.env['API_KEY'].toString();

  void init() {

  }

  Future payWithExistingCard({
    required String amount,
    required String currency,
    required CreditCard card
  }) async{

  }

  Future payWithNewCard({
    required String amount,
    required String currency,
    }) async{

  }

  Future payApplePayGooglePay({
    required String amount,
    required String currency,
    }) async{

  }

  Future _createPaymentIntent({
    required String amount,
    required String currency,
    })async{

  }

  Future _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod
    }) async{

  }


}


//como llamar
// final stripeService = new StripeService();