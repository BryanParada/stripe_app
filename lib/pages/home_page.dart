 

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/data/cards.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/card_page.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {

  final stripeService = new StripeService();

 
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

      // ignore: close_sinks
    final payBloc = context.read<PayBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () async {

               showLoading(context);
              // await Future.delayed(Duration(seconds:1));
              // Navigator.pop(context);

              // showAlert(context, 'Hi', 'world');

              final amount = payBloc.state.amountPayString;
              final currency = payBloc.state.currency;

              final resp = await this.stripeService.payWithNewCard(
                  amount: amount,
                  currency: currency
                 );

              Navigator.pop(context);

            if (resp.ok){
              showAlert(context, 'Card Ok', 'Everything Ok');
            } else{
              showAlert(context, 'Something went wrong', resp.msg);
            }

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