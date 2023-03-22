part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnSelectCard extends PayEvent {

  final CreditCardModel card;
  OnSelectCard(this.card);

}

class OnDeactivateCard extends PayEvent{

}