import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:prueba_tecnica/widgets/widgets.dart';

// import '../../providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final cardsState = ref.watch(cardsProvider(''));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CardsSlideshow(cards: cardsState.cards),
            IconButton.outlined(
                onPressed: () {
                  context.push('/cards');
                },
                icon: const Icon(
                  Icons.open_in_new_sharp,
                )),
            const Center(
              child: Text('Center'),
            ),
          ],
        ),
      ),
    );
  }
}
