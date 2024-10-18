import 'package:prueba_tecnica/features/cards/domain/domain.dart';

class CardMapper {
  static List<Card> jsonToEntities(Map<String, dynamic> json) {
    final List<dynamic> cardsJson = json['data'] ?? [];
    return cardsJson.map((card) => jsonToEntity(card)).toList();
  }

  static Card jsonToEntity(Map<String, dynamic> json) => Card(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        humanReadableCardType: json['humanReadableCardType'],
        frameType: json['frameType'],
        desc: json['desc'],
        race: json['race'],
        attribute: json['attribute'],
        archetype: json['archetype'],
        atk: json['atk'],
        def: json['def'],
        level: json['level'],
        ygoprodeckUrl: json['ygoprodeck_url'],
        cardSets: json['card_sets'] != null
            ? (json['card_sets'] as List<dynamic>)
                .map((x) => CardSet.fromJson(x))
                .toList()
            : [],
        cardImages: (json['card_images'] as List<dynamic>)
            .map((image) => CardImage.fromJson(image))
            .toList(),
        cardPrices: (json['card_prices'] as List<dynamic>)
            .map((x) => CardPrice.fromJson(x))
            .toList(),
      );
}
