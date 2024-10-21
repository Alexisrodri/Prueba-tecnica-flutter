import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';

final cardsProvider = StateNotifierProvider.autoDispose
    .family<CardsNotifier, CardsState, String?>((ref, archetype) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsNotifier(
    cardsRepository: cardsRepository,
    archetype: archetype,
  );
});

class CardsNotifier extends StateNotifier<CardsState> {
  final CardsRepositories cardsRepository;

  CardsNotifier({
    required this.cardsRepository,
    required String? archetype,
  }) : super(CardsState(archetype: archetype ?? '')) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    try {
      if (state.isLoading || state.isLastPage) return;
      state = state.copyWith(isLoading: true);

      final cards = await cardsRepository.getCardsByPage(
        limit: state.limit,
        offset: state.offset,
        archetype: state.archetype,
      );

      if (!mounted) return;

      if (cards.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          isLastPage: true,
        );
        return;
      }

      state = state.copyWith(
        isLoading: false,
        offset: state.offset + 10,
        cards: [...state.cards, ...cards],
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateArchetype(String value) async {
    state = state.copyWith(
      archetype: value,
      offset: 0,
      cards: [],
      isLastPage: false,
      isLoading: true,
    );

    await loadNextPage();
  }
}

class CardsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final String? archetype;
  final bool isLoading;
  final List<Cards> cards;
  final String? error;

  CardsState({
    this.isLastPage = false,
    required this.archetype,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.cards = const [],
    this.error,
  });

  CardsState copyWith({
    bool? isLastPage,
    int? limit,
    String? archetype,
    int? offset,
    bool? isLoading,
    List<Cards>? cards,
    String? error,
  }) {
    return CardsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      archetype: archetype ?? this.archetype,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      cards: cards ?? this.cards,
      error: error ?? this.error,
    );
  }
}
