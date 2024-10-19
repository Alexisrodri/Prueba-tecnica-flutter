import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/datasources/cards_datasources_impl.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(CardsInitial()) {
    on<CardsInitialFetchEvent>(cardsInitiFetchEvent);
  }

  Future<void> cardsInitiFetchEvent(
      CardsInitialFetchEvent event, Emitter<CardsState> emit) async {
    emit(CardsFetchingLoadingState());
    List<CardResponse> cards = await CardsDatasourcesImpl().getCardsByPage();
    emit(CardsFetchingSucces(cards: cards));
  }
}
