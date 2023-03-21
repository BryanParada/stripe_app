import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/models/credit_card.dart';

import '../widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {

  final card = CreditCard(
        cardNumberHidden: '4242',
        cardNumber: '4242424242424242',
        brand: 'visa',
        cvv: '213',
        expiracyDate: '01/25',
        cardHolderName: 'Juan Perez'
      );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
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