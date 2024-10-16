import 'package:prueba_tecnica/features/cards/domain/entities/card.dart';

abstract class CardsDatasource {
  Future<List<Card>> getCardsByPage({int limit = 10, int offset = 0});

  Future<Card> getCardById(String id);
}
