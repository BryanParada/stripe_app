import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/credit_card.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayState()); 

  @override
  Stream<PayState> mapEventToState( PayEvent event) async*{ //funcion generadora

  //  Al utilizar yield en lugar de return, la función mapEventToState no se detiene después de generar un nuevo estado.
  // En cambio, permanece en un estado pausado hasta que se emita el siguiente estado a través del Stream.
  // Esto permite que la función genere una secuencia de estados en función de los eventos que se reciben.


    if ( event is OnSelectCard){
      yield state.copyWith( cardActive: true, card: event.card );
    } else if ( event is OnDeactivateCard ){
      yield state.copyWith( cardActive: false );
    }


  }

}
