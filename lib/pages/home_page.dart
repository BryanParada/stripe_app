import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/data/cards.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/card_page.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

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
            onPressed: () async {

              // showLoading(context);
              // await Future.delayed(Duration(seconds:1));
              // Navigator.pop(context);
              showAlert(context, 'Hi', 'world');

            },
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
          
                return GestureDetector(
                  onTap: (){
                    context.read<PayBloc>().add(OnSelectCard(card)); //context.bloc = context.read

                    Navigator.push(context, navigateFadeIn(context, CardPage()));
                    
                  },
                  child: Hero(
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
                );
          
              }
              ),
          ),


          Positioned(
            bottom: 0,
            child: TotalPayButton()
          ),


        ],
      ),
    );
  }
}