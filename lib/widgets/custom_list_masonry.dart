import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/features/cards/domain/domain.dart';
import 'package:prueba_tecnica/widgets/cards_cardview.dart';

class CardsView extends ConsumerStatefulWidget {
  final List<Cards> cards;
  final Future<void> Function() voidCallback;
  const CardsView({
    super.key,
    required this.cards,
    required this.voidCallback,
  });

  @override
  CardsViewState createState() => CardsViewState();
}

class CardsViewState extends ConsumerState<CardsView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        await widget.voidCallback();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final selectedArchetype = ref.watch(selectedArchetypeProvider);
    // final cardsState = ref.watch(cardsProvider(selectedArchetype));

    return Padding(
      padding: const EdgeInsets.all(15),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          final card = widget.cards[index];
          return GestureDetector(
            onTap: () => context.push('/cards/${card.id}'),
            child: CardsCardview(card: card),
          );
        },
      ),
    );
  }
}
