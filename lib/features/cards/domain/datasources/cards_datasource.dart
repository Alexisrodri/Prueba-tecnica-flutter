import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';

abstract class CardsDatasource {
  Future<List<CardResponse>> getCardsByPage(
      {int limit = 10, int offset = 0, String? archetype = ''});

  Future<CardResponse> getCardById(String id);

  Future<List<Archetype>> getArchetype();
}
