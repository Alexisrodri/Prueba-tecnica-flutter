import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';

final cardsProvider = StateNotifierProvider.family
    .autoDispose<CardsNotifier, CardsState, String?>((ref, archetype) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsNotifier(
    archetype,
    cardsRepository: cardsRepository,
  );
});

class CardsNotifier extends StateNotifier<CardsState> {
  final CardsRepositories cardsRepository;
  String? archetype;

  CardsNotifier(this.archetype, {required this.cardsRepository})
      : super(CardsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final cards = await cardsRepository.getCardsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (cards.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      cards: [...state.cards, ...cards],
    );
  }

  Future<void> reloadCards({String? archetype}) async {
    try {
      final newCards = await cardsRepository.getCardsByPage(
        limit: 10,
        offset: 0,
        archetype: archetype,
      );

      state = state.copyWith(
        cards: newCards,
        isLastPage: newCards.isEmpty, // Actualiza isLastPage
        offset: newCards.length, // Resetea el offset
      );
    } catch (e) {
      // Manejo de errores
      throw Exception('Error al recargar las cartas: $e');
    }
  }
}

class CardsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final String archetype;
  final bool isLoading;
  final List<Card> cards;

  CardsState({
    this.isLastPage = false,
    this.archetype = '',
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.cards = const [],
  });
  CardsState copyWith(
      {bool? isLastPage,
      int? limit,
      String? archetype,
      int? offset,
      bool? isLoading,
      List<Card>? cards}) {
    return CardsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        archetype: archetype ?? this.archetype,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        cards: cards ?? this.cards);
  }
}
