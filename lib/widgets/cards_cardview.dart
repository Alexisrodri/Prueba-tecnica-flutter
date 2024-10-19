import 'package:flutter/material.dart';
import 'package:prueba_tecnica/features/cards/domain/entities/card.dart'
    as card_data;

class CardsCardview extends StatelessWidget {
  final card_data.CardResponse card;

  const CardsCardview({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardImages(images: card.cardImages),
        Text(
          card.name,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _CardImages extends StatelessWidget {
  final List<card_data.CardImage> images;
  const _CardImages({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/imgs/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }
    return ClipRRect(
      child: FadeInImage(
        placeholder: const AssetImage('assets/imgs/card-back.png'),
        fit: BoxFit.cover,
        image: NetworkImage(images.first.imageUrl),
      ),
    );
  }
}
