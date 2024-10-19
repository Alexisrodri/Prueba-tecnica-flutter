part of 'cards_bloc.dart';

@immutable
abstract class CardsState {
  // final bool isLastPage;
  // final int limit;
  // final int offset;
  // final String archetype;
  // final bool isLoading;
  // final List<CardResponse> cards;

  // const CardsState(
  //     {required this.isLastPage,
  //     required this.limit,
  //     required this.offset,
  //     required this.archetype,
  //     required this.isLoading,
  //     required this.cards});
}

final class CardsInitial extends CardsState {}

final class CardsFetchingLoadingState extends CardsState {}

final class CardsFetchingSucces extends CardsState {
  final List<CardResponse> cards;
  CardsFetchingSucces({required this.cards});
}
