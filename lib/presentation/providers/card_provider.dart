import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';

final cardProvider = StateNotifierProvider.autoDispose
    .family<CardNotifier, CardState, String>((ref, cardId) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardNotifier(cardRepository: cardsRepository, cardId: cardId);
});

class CardNotifier extends StateNotifier<CardState> {
  final CardsRepositories cardRepository;

  CardNotifier({
    required this.cardRepository,
    required String cardId,
  }) : super(CardState(id: cardId)) {
    loadCard();
  }

  Future<void> loadCard() async {
    try {
      final card = await cardRepository.getCardById(state.id);
      state = state.copyWith(
        isLoading: false,
        card: card,
      );
    } catch (e) {
      print(e);
    }
  }
}

class CardState {
  final String id;
  final bool isLoading;
  final Card? card;

  CardState({
    required this.id,
    this.card,
    this.isLoading = true,
  });

  CardState copyWith({
    String? id,
    Card? card,
    bool? isLoading,
  }) =>
      CardState(
        id: id ?? this.id,
        card: card ?? this.card,
        isLoading: isLoading ?? this.isLoading,
      );
}
