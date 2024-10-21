import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';

class CardsSlideshow extends StatelessWidget {
  final List<Cards> cards;

  const CardsSlideshow({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.7,
        scale: 0.9,
        autoplay: true,
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.blueGrey,
              color: Colors.grey,
            )),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return _Slide(
            cards: card,
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Cards cards;
  const _Slide({
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    final customDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        // BoxShadow(
        //   color: Colors.black12,
        //   blurRadius: 1,
        //   offset: Offset(0, 5),
        // )
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: customDecoration,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () => context.push('/cards/${cards.id}'),
              child: FadeInImage(
                placeholder: const AssetImage('assets/imgs/card-back.png'),
                image: NetworkImage(cards.cardImages.first.imageUrl),
                fit: BoxFit.contain,
                height: 100,
              ),
            )),
      ),
    );
  }
}
