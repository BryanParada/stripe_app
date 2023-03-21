import 'package:flutter/material.dart';
import 'package:stripe_app/pages/home_page.dart';
import 'package:stripe_app/pages/payment_complete_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}