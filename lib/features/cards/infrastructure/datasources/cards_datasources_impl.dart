import 'package:dio/dio.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/mappers/card_mapper.dart';

class CardsDatasourcesImpl extends CardsDatasource {
  late final Dio dio;

  CardsDatasourcesImpl()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://db.ygoprodeck.com/api/v7/',
        ));

  // https://db.ygoprodeck.com/api/v7/cardinfo.php?&num=10&offset=0#

  @override
  Future<Card> getCardById(String id) {
    // TODO: implement getCardById
    throw UnimplementedError();
  }

  @override
  Future<List<Card>> getCardsByPage({int limit = 10, int offset = 0}) async {
    final response =
        await dio.get<List>('cardinfo.php?&num=$limit&offset=$offset');
    final List<Card> cards = [];
    for (final card in response.data ?? []) {
      cards.add(CardMapper.jsonToEntity(card));
    }
    return cards;
  }
}
