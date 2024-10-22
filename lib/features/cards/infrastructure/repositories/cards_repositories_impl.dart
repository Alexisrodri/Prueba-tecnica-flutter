import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';

class CardsRepositoriesImpl extends CardsRepositories {
  final CardsDatasource datasource;

  CardsRepositoriesImpl(this.datasource);

  @override
  Future<Cards> getCardById(String id) {
    return datasource.getCardById(id);
  }

  @override
  Future<List<Cards>> getCardsByPage(
      {int limit = 10, int offset = 0, String? archetype = ''}) {
    return datasource.getCardsByPage(
      limit: limit,
      offset: offset,
      archetype: archetype,
    );
  }

  @override
  Future<List<Archetype>> getArchetype() {
    return datasource.getArchetype();
  }

  @override
  Future<List<Cards>> getBanListCards({
    int limit = 10,
    int offset = 0,
  }) {
    return datasource.getBanListCards(
      limit: limit,
      offset: offset,
    );
  }
}
