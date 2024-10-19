import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';

abstract class CardsRepositories {
  Future<List<Card>> getCardsByPage(
      {int limit = 10, int offset = 0, String? archetype = ''});

  Future<Card> getCardById(String id);

  Future<List<Archetype>> getArchetype();
}
