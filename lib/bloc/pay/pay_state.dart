part of 'pay_bloc.dart';

@immutable 
class PayState {

  final double amountPay;
  final String currency; //moneda USD-CAD
  final bool cardActive;
  final CreditCardModel card;

  String get amountPayString => '${(this.amountPay * 100).floor()}';

  PayState({
  this.amountPay = 300.55, 
  this.currency = 'USD', 
  this.cardActive = false, 
  this.card = const CreditCardModel(
    cardNumberHidden: '',
    cardNumber: '',
    brand: '',
    cvv: '',
    expiracyDate: '',
    cardHolderName: ''
  ),
});

  PayState copyWith({
    double? amountPay,
    String? currency,
    bool? cardActive,
    CreditCardModel? card,
  }) => PayState(
    amountPay : amountPay ?? this.amountPay,
    currency  : currency ?? this.currency,
    cardActive: cardActive ?? this.cardActive,
    card      : card ?? this.card,
  );


}
