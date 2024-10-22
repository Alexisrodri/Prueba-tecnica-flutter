import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';

abstract class CardsRepositories {
  Future<List<Cards>> getCardsByPage(
      {int limit = 10, int offset = 0, String? archetype = ''});

  Future<Cards> getCardById(String id);

  Future<List<Archetype>> getArchetype();

  Future<List<Cards>> getBanListCards({
    int limit = 10,
    int offset = 0,
  });
}
