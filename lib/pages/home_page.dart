import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/data/cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: null,
            ),
        ]
      ),
      body:Stack(
        children: [

          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9
              ),
              physics: BouncingScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (_, i) {
          
                final card = cards[i];
          
                return CreditCardWidget(
                  cardNumber: card.cardNumberHidden,
                  expiryDate: card.expiracyDate,
                  cardHolderName: card.cardHolderName,
                  isHolderNameVisible: true,
                  cvvCode: card.cvv, 
                  showBackView: false, 
                  onCreditCardWidgetChange: (creditCardBrand) {}
                  );
          
              }
              ),
          )


        ],
      ),
    );
  }
}