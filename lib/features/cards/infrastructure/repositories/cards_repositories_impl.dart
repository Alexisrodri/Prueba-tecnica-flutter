import 'package:prueba_tecnica/features/cards/domain/domain.dart';

class CardsRepositoriesImpl extends CardsRepositories {
  final CardsDatasource datasource;

  CardsRepositoriesImpl(this.datasource);

  @override
  Future<Card> getCardById(String id) {
    return datasource.getCardById(id);
  }

  @override
  Future<List<Card>> getCardsByPage({int limit = 10, int offset = 0}) {
    return datasource.getCardsByPage(limit: limit, offset: offset);
  }
}
