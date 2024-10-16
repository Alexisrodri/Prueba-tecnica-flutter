import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/presentation/providers/cards_repository_provider.dart';

final cardsProvider = StateNotifierProvider<CardsNotifier, CardsState>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsNotifier(cardsRepository: cardsRepository);
});

class CardsNotifier extends StateNotifier<CardsState> {
  final CardsRepositories cardsRepository;

  CardsNotifier({required this.cardsRepository}) : super(CardsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);
    final cards = await cardsRepository.getCardsByPage(
        limit: state.limit, offset: state.offset);
    if (cards.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }
    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      cards: [...state.cards, ...cards],
    );
  }
}

class CardsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Card> cards;

  CardsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.cards = const [],
  });
  CardsState copyWith(
      {bool? isLastPage,
      int? limit,
      int? offset,
      bool? isLoading,
      List<Card>? cards}) {
    return CardsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        cards: cards ?? this.cards);
  }
}
