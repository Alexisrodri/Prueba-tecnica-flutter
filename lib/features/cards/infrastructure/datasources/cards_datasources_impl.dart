import 'package:dio/dio.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/errors/cards_erros.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/mappers/card_mapper.dart';

class CardsDatasourcesImpl extends CardsDatasource {
  late final Dio dio;

  CardsDatasourcesImpl()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://db.ygoprodeck.com/api/v7/',
        ));

  // https://db.ygoprodeck.com/api/v7/cardinfo.php?&num=10&offset=0#
  // https://db.ygoprodeck.com/api/v7/cardinfo.php?id=84962466

  @override
  Future<Card> getCardById(String id) async {
    try {
      final response = await dio.get('cardinfo.php?id=$id');
      // print('response::${response.data}');
      final card = CardMapper.jsonToEntities(response.data);
      // print('Cardddd::$card');
      return card.map((card) => card).first;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw CardNotFound();
      throw Exception();
    } catch (e) {
      // print(e);
      throw Exception();
    }
  }

  @override
  Future<List<Card>> getCardsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get('cardinfo.php?&num=$limit&offset=$offset');
    final List<Card> cards = [];
    if (response.data != null) {
      for (final card in response.data['data']) {
        cards.add(CardMapper.jsonToEntity(card));
      }
    }
    return cards;
  }
}
