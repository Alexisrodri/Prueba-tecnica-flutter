import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';
import '../../../widgets/widgets.dart';

class CardsBandlist extends ConsumerWidget {
  const CardsBandlist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardBanlist = ref.watch(cardsProvider(''));
    final cardsNotifier = ref.read(cardsProvider('').notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFC2B4A7),
      appBar: AppBar(
        title: const Text('BandList Cards'),
        centerTitle: true,
        backgroundColor: const Color(0xFFC2B4A7),
      ),
      body: Column(
        children: [
          Expanded(
            child: CardsView(
              cards: cardBanlist.bannedCards,
              voidCallback: () async {
                await cardsNotifier.loadCardsBand();
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FilterFAB(selectedArchetype: selectedArchetype),
    );
  }
}
