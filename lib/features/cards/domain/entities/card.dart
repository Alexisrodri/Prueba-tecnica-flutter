// To parse this JSON data, do
//
//     final Card = cardFromJson(jsonString);

import 'dart:convert';

List<CardResponse> cardFromJson(String str) => List<CardResponse>.from(
    json.decode(str).map((x) => CardResponse.fromJson(x)));

String cardToJson(List<CardResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardResponse {
  int id;
  String name;
  String type;
  String humanReadableCardType;
  String frameType;
  String desc;
  String race;
  String? archetype;
  String ygoprodeckUrl;
  List<CardSet> cardSets;
  List<CardImage> cardImages;
  List<CardPrice> cardPrices;
  List<String>? typeline;
  int? atk;
  int? def;
  int? level;
  String? attribute;

  CardResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.humanReadableCardType,
    required this.frameType,
    required this.desc,
    required this.race,
    this.archetype,
    required this.ygoprodeckUrl,
    required this.cardSets,
    required this.cardImages,
    required this.cardPrices,
    this.typeline,
    this.atk,
    this.def,
    this.level,
    this.attribute,
  });

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        humanReadableCardType: json["humanReadableCardType"],
        frameType: json["frameType"],
        desc: json["desc"],
        race: json["race"],
        archetype: json["archetype"],
        ygoprodeckUrl: json["ygoprodeck_url"],
        cardSets: List<CardSet>.from(
            json["Card_sets"].map((x) => CardSet.fromJson(x))),
        cardImages: List<CardImage>.from(
            json["Card_images"].map((x) => CardImage.fromJson(x))),
        cardPrices: List<CardPrice>.from(
            json["Card_prices"].map((x) => CardPrice.fromJson(x))),
        typeline: json["typeline"] == null
            ? []
            : List<String>.from(json["typeline"]!.map((x) => x)),
        atk: json["atk"],
        def: json["def"],
        level: json["level"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "humanReadableCardType": humanReadableCardType,
        "frameType": frameType,
        "desc": desc,
        "race": race,
        "archetype": archetype,
        "ygoprodeck_url": ygoprodeckUrl,
        "card_sets": List<dynamic>.from(cardSets.map((x) => x.toJson())),
        "card_images": List<dynamic>.from(cardImages.map((x) => x.toJson())),
        "card_prices": List<dynamic>.from(cardPrices.map((x) => x.toJson())),
        "typeline":
            typeline == null ? [] : List<dynamic>.from(typeline!.map((x) => x)),
        "atk": atk,
        "def": def,
        "level": level,
        "attribute": attribute,
      };
}

class CardImage {
  int id;
  String imageUrl;
  String imageUrlSmall;
  String imageUrlCropped;

  CardImage({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
    required this.imageUrlCropped,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
        id: json["id"],
        imageUrl: json["image_url"],
        imageUrlSmall: json["image_url_small"],
        imageUrlCropped: json["image_url_cropped"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "image_url_small": imageUrlSmall,
        "image_url_cropped": imageUrlCropped,
      };
}

class CardPrice {
  String CardmarketPrice;
  String tcgplayerPrice;
  String ebayPrice;
  String amazonPrice;
  String coolstuffincPrice;

  CardPrice({
    required this.CardmarketPrice,
    required this.tcgplayerPrice,
    required this.ebayPrice,
    required this.amazonPrice,
    required this.coolstuffincPrice,
  });

  factory CardPrice.fromJson(Map<String, dynamic> json) => CardPrice(
        CardmarketPrice: json["Cardmarket_price"],
        tcgplayerPrice: json["tcgplayer_price"],
        ebayPrice: json["ebay_price"],
        amazonPrice: json["amazon_price"],
        coolstuffincPrice: json["coolstuffinc_price"],
      );

  Map<String, dynamic> toJson() => {
        "Cardmarket_price": CardmarketPrice,
        "tcgplayer_price": tcgplayerPrice,
        "ebay_price": ebayPrice,
        "amazon_price": amazonPrice,
        "coolstuffinc_price": coolstuffincPrice,
      };
}

class CardSet {
  String setName;
  String setCode;
  String setRarity;
  String setRarityCode;
  String setPrice;

  CardSet({
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setRarityCode,
    required this.setPrice,
  });

  factory CardSet.fromJson(Map<String, dynamic> json) => CardSet(
        setName: json["set_name"],
        setCode: json["set_code"],
        setRarity: json["set_rarity"],
        setRarityCode: json["set_rarity_code"],
        setPrice: json["set_price"],
      );

  Map<String, dynamic> toJson() => {
        "set_name": setName,
        "set_code": setCode,
        "set_rarity": setRarity,
        "set_rarity_code": setRarityCode,
        "set_price": setPrice,
      };
}
