import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/infrastructure.dart';

final cardsRepositoryProvider = Provider<CardsRepositories>((ref) {
  final cardsRepository = CardsRepositoriesImpl(CardsDatasourcesImpl());

  return cardsRepository;
});
