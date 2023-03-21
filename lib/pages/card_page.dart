import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart'; 

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {

  final card = context.read<PayBloc>().state.card;
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        leading: IconButton(
          icon: Icon( Icons.arrow_back),
          onPressed: (){
            context.read<PayBloc>().add( OnDeactivateCard() );
            Navigator.pop(context);
          },
        )
      ),
      body: Stack(
        children: [

          Container(),

          Hero(
            tag: card.cardNumber,
            child: CreditCardWidget(
                      cardNumber: card.cardNumberHidden,
                      expiryDate: card.expiracyDate,
                      cardHolderName: card.cardHolderName,
                      isHolderNameVisible: true,
                      cvvCode: card.cvv, 
                      showBackView: false, 
                      onCreditCardWidgetChange: (creditCardBrand) {}
                      ),
          ),

             Positioned(
            bottom: 0,
            child: TotalPayButton()
          ),



        ],
      )
    );
  }
}