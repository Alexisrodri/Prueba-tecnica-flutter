import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';

class CardsRepositoriesImpl extends CardsRepositories {
  final CardsDatasource datasource;

  CardsRepositoriesImpl(this.datasource);

  @override
  Future<Card> getCardById(String id) {
    return datasource.getCardById(id);
  }

  @override
  Future<List<Card>> getCardsByPage(
      {int limit = 10, int offset = 0, String? archetype = ''}) {
    return datasource.getCardsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Archetype>> getArchetype() {
    return datasource.getArchetype();
  }
}
