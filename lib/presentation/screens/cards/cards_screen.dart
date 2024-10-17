import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/presentation/providers/cards_provider.dart';
import 'package:prueba_tecnica/widgets/widgets.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ,
      appBar: AppBar(
        title: const Text('Cartas'),
      ),
      body: const _CardsView(),
    );
  }
}

class _CardsView extends ConsumerStatefulWidget {
  const _CardsView();

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(cardsProvider.notifier).loadNextPage();
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
    final cardsState = ref.watch(cardsProvider);
    return Padding(
        padding: const EdgeInsets.all(15),
        child: MasonryGridView.count(
          controller: scrollController,
          // physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 35,
          itemCount: cardsState.cards.length,
          itemBuilder: (context, index) {
            final card = cardsState.cards[index];
            return GestureDetector(
              onTap: () => context.push('/cards/${card.id}'),
              child: CardsCardview(card: card),
            );
          },
        ));
  }
}
