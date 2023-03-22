import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart'; 

import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeService{

  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance; //al llamar la instancia

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = dotenv.env['SECRET_KEY'].toString();
  String _apiKey = dotenv.env['API_KEY'].toString();

  final headerOptions = new Options(
    contentType: Headers.formUrlEncodedContentType, 
    headers: {
      'Authorization': 'Bearer ${StripeService._secretKey}'
    }
  );

  void init() {

    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      ),
    );

  }

  Future payWithExistingCard({
    required String amount,
    required String currency,
    required CreditCard card
  }) async{




  }

  Future<StripeCustomResponse> payWithNewCard({
    required String amount,
    required String currency,
    }) async{

    try {
      
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

     final resp = await this._makePayment(
      amount: amount,
      currency: currency,
      paymentMethod: paymentMethod
     );


      return resp;
      //  return StripeCustomResponse(ok: true);

    } catch (e) {
      return StripeCustomResponse(
        ok: false,
         msg: e.toString()
         );
    }


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

      try {
        
        final dio = new Dio();
        final data = {
          'amount' : amount,
          'currency': currency,
        };

        final resp = await dio.post(
          _paymentApiUrl,
          data: data,
          options: headerOptions,
        );

        return PaymentIntentResponse.fromMap( resp.data ); //fromJson

      } catch (e) {
        
        print('Error trying to pay: ${e.toString()}');
        // return PaymentIntentResponse( status: '400');
        

      }


  }

  Future<StripeCustomResponse> _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod
    }) async{


    try {

            // Crear el intent
          final paymentIntent = await this._createPaymentIntent(
            amount: amount,
              currency: currency
              );

          final paymentResult = await StripePayment.confirmPaymentIntent(
            PaymentIntent(
              clientSecret: paymentIntent.clientSecret, //no es nuestra llave secreta
              paymentMethodId: paymentMethod.id
              )
          );

          if( paymentResult.status == 'succeeded'){
            return StripeCustomResponse(
              ok: true
              );
          } else {
            return StripeCustomResponse(
              ok: false,
              msg: 'Failed: ${paymentResult.status}'
            );
          } 
      
    } catch (e) {
      
      print(e.toString());
      
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );

    }


  }


}


//como llamar
// final stripeService = new StripeService();