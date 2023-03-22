import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final payBloc = context.read<PayBloc>().state;

    return Container(
      width: width,
      height: 100,
      padding: EdgeInsets.symmetric( horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${payBloc.amountPay} ${ payBloc.currency}', style: TextStyle(fontSize: 20))
            ],
          ),

          BlocBuilder<PayBloc, PayState>(
            builder: (context, state) {
              return  _BtnPayment( state );
            },
          ),

         


        ],
      ),
    );
  }
}



class _BtnPayment extends StatelessWidget { 

  final PayState state; 
  const _BtnPayment(this.state);

  @override
  Widget build(BuildContext context) {
    return state.cardActive
                ? buildBtnCard(context)
                : buildAppleAndGooglePay(context);
  }
   
 Widget buildBtnCard(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
         Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white),
          Text('  Card Pay', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),
      onPressed: ()async {
        print('Hola Mundo');
        
        showLoading(context);

        final stripService = new StripeService();
        final state = context.read<PayBloc>().state;
        // print(card.cardNumber);
        final card = state.card;
        final monthYear = card.expiracyDate.split('/');

        final resp = await stripService.payWithExistingCard(
          amount: state.amountPayString ,
          currency: state.currency, 
          card: CreditCard(
            number: card.cardNumber,
            expMonth: int.parse(monthYear[0]),
            expYear: int.parse(monthYear[1]),
          )
          );

        Navigator.pop(context);

        if (resp.ok){
          showAlert(context, 'Card Ok', 'Everything Ok');
        } else{
          showAlert(context, 'Something went wrong', resp.msg);
        }
        

      },
      );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
            ? FontAwesomeIcons.google
            :  FontAwesomeIcons.apple,
            color: Colors.white
            ),
          Text(' Pay', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),
      onPressed: (){
        print('hola GPAY');
        
      },
      );
  }
}