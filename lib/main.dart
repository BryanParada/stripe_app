import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/pages/home_page.dart';
import 'package:stripe_app/pages/payment_complete_page.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:stripe_app/services/stripe_service.dart';

Future<void> main() async{
  await dotenv.load();
 
  runApp(const MyApp()); //MyApp

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //INICIALIZAMOS StripService
    // final stripeService = new StripeService();
    // stripeService.init();
    //ó
    new StripeService()
    ..init();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PayBloc()) //global
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stripe App',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'payment_complete': (_) => PaymentCompletePage(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xff284879),
          scaffoldBackgroundColor: Color(0xff21232A)
        )
      ),
    );
  }
}