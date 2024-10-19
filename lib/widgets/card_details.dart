import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 350,
                width: 350,
                child: Text('sizebox'),
                //  _ImageGallery(
                //     images: cardState.card!.cardImages.first.imageUrl),
              ),
            ),
            SizedBox(height: 20),
            // CardInfo(
            // 	cardState: cardState
            // 	),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final String images;

  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          'assets/imgs/no-image.jpg',
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.network(
      images,
      scale: 1.0,
      fit: BoxFit.contain,
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Name Card',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'YuGiOh',
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // GridInfoCard(cardState: cardState),
        Text(
          'Description',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'description',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        // const Spacer(),
        // const SizedBox()
      ],
    );
  }
}

class GridInfoCard extends StatelessWidget {
  const GridInfoCard({
    super.key,
    // required this.cardState,
  });

  // final CardState cardState;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        childAspectRatio: 2,
      ),
      children: [
        // Tipo
        const GridTile(
          header: Text(
            'Type',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.library_books_rounded,
              ),
              SizedBox(width: 5),
              // Text(
              //   cardState.card!.type,
              //   style: const TextStyle(
              //     fontStyle: FontStyle.italic,
              //   ),
              // ),
            ],
          ),
        ),
        // Arquetipo (solo si existe)
        // if (cardState.card!.archetype != null)
        //   GridTile(
        //     header: const Text(
        //       'Archetype',
        //       style: TextStyle(
        //         fontSize: 20,
        //       ),
        //     ),
        //     child: Row(
        //       children: [
        //         Image.network(
        //           'https://images.ygoprodeck.com/images/cards/${cardState.card!.archetype}.jpg',
        //           width: 30,
        //           height: 30,
        //           fit: BoxFit.cover,
        //           scale: 1.0,
        //           errorBuilder: (context, error, stackTrace) {
        //             return const Icon(
        //               Icons.science_rounded,
        //             );
        //           },
        //         ),
        const SizedBox(width: 5),
        //       Text(
        //         cardState.card!.archetype!,
        //         style: const TextStyle(
        //           fontSize: 18,
        //           fontStyle: FontStyle.italic,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Tipo/Raza
        // GridTile(
        //   header: const Text(
        //     'Race/Type',
        //     style: TextStyle(
        //       fontSize: 20,
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       Image.network(
        //         'https://images.ygoprodeck.com/images/cards/icons/race/${cardState.card!.race}.png',
        //         width: 30,
        //         scale: 1.0,
        //       ),
        //       const SizedBox(width: 5),
        //       Text(
        //         cardState.card!.race,
        //         style: const TextStyle(
        //           fontSize: 20,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Atributo (solo si existe)
        // if (cardState.card!.attribute != null)
        //   GridTile(
        //     header: const Text(
        //       'Attribute',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     child: Row(
        //       children: [
        //         Image.network(
        //           'https://images.ygoprodeck.com/images/cards/${cardState.card!.attribute}.jpg',
        //           width: 30,
        //           height: 30,
        //           scale: 1.0,
        //           fit: BoxFit.cover,
        //         ),
        //         const SizedBox(width: 5),
        //         Text(
        //           cardState.card!.attribute!,
        //           style: const TextStyle(
        //             fontSize: 22,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // Level/Rank (solo si existe)
        // if (cardState.card!.level != null)
        GridTile(
          header: const Text(
            'Level/Rank',
            style: TextStyle(color: Colors.white),
          ),
          child: Row(
            children: [
              Image.network(
                'https://ygoprodeck.com/wp-content/uploads/2017/01/level.png',
                width: 30,
                height: 30,
                scale: 1.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 5),
              const Text(
                // '${cardState.card!.level}',
                'estadisticas',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        // ATK (solo si existe)
        // if (cardState.card!.atk != null)
        const GridTile(
            header: Text(
              'ATK',
              style: TextStyle(color: Colors.white),
            ),
            child: Row(
              children: [
                Text('estadisticas')
                // StatWidget(
                //   value: cardState.card!.atk!,
                //   icon: Symbols.swords,
                //   color: Colors.amber,
                // ),
              ],
            )),
        // if (cardState.card!.def != null)
        const GridTile(
          header: Text(
            'DEF',
            style: TextStyle(color: Colors.white),
          ),
          child: Row(
            children: [
              Text('estadisticas')
              // StatWidget(
              //   // label: 'DEF',
              //   value: cardState.card!.def!,
              //   icon: Symbols.swords,
              //   color: Colors.amber,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatWidget extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color? color;

  const StatWidget({
    super.key,
    required this.value,
    required this.icon,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(width: 10),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
