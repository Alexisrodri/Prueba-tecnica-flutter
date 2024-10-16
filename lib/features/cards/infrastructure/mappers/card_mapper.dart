import 'package:prueba_tecnica/features/cards/domain/domain.dart';

class CardMapper {
  static jsonToEntity(Map<String, dynamic> json) => Card(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        humanReadableCardType: json['humanReadableCardType'],
        frameType: json['frameType'],
        desc: json['desc'],
        race: json['race'],
        ygoprodeckUrl: json['ygoprodeckUrl'],
        cardSets: json['cardSets'],
        cardImages: json['cardImages'],
        cardPrices: json['cardPrices'],
      );
}
