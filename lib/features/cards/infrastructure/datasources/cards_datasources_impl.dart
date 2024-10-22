import 'package:dio/dio.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/features/cards/domain/entities/entities.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/errors/cards_erros.dart';
import 'package:prueba_tecnica/features/cards/infrastructure/mappers/card_mapper.dart';

class CardsDatasourcesImpl extends CardsDatasource {
  late final Dio dio;

  CardsDatasourcesImpl()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://db.ygoprodeck.com/api/v7/',
        ));

  // https://db.ygoprodeck.com/api/v7/cardinfo.php?&num=10&offset=0#
  // https://db.ygoprodeck.com/api/v7/cardinfo.php?archetype=Blue-Eyes
  // https://db.ygoprodeck.com/api/v7/cardinfo.php?id=84962466
  // https://db.ygoprodeck.com/api/v7/cardinfo.php?banlist=tcg&num=10&offset=0

  @override
  Future<Cards> getCardById(String id) async {
    try {
      final response = await dio.get('cardinfo.php?id=$id');
      final card = CardMapper.jsonToEntities(response.data);
      return card.map((card) => card).first;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw CardNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Cards>> getCardsByPage({
    int limit = 10,
    int offset = 0,
    String? archetype,
  }) async {
    final url =
        'cardinfo.php?num=$limit&offset=$offset${archetype != null && archetype.isNotEmpty ? '&archetype=$archetype' : ''}';

    final response = await dio.get(url);

    final List<Cards> cards = [];

    if (response.data != null && response.data['data'] != null) {
      for (final card in response.data['data']) {
        cards.add(CardMapper.jsonToEntity(card));
      }
    }
    return cards;
  }

  @override
  Future<List<Archetype>> getArchetype() async {
    try {
      final response = await dio.get('archetypes.php');
      final List<dynamic> archetypeResponse = response.data;
      final archetype = archetypeResponse
          .map(
            (e) => Archetype.fromJson(e),
          )
          .toList();
      return archetype;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw CardNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Cards>> getBanListCards({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final url = 'cardinfo.php?banlist=tcg&num=$limit&offset=$offset';

      final response = await dio.get(url);
      final List<Cards> cards = [];

      if (response.data != null && response.data['data'] != null) {
        for (final card in response.data['data']) {
          cards.add(CardMapper.jsonToEntity(card));
        }
      } else {
        throw Exception('La respuesta no contiene datos válidos');
      }

      return cards;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw CardNotFound(); // Si no se encuentra el recurso
      }
      throw Exception('Error al obtener las cartas de la lista de baneadas');
    } catch (e) {
      throw Exception('Error inesperado al obtener las cartas');
    }
  }
}
