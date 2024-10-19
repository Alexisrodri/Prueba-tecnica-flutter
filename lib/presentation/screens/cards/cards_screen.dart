import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';
import 'package:prueba_tecnica/widgets/widgets.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedArchetype = ref.watch(selectedArchetypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartas'),
      ),
      body: Column(
        children: [
          if (selectedArchetype != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Archetype: $selectedArchetype',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          const Expanded(child: _CardsView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.3,
                minChildSize: 0.1,
                maxChildSize: 0.8,
                builder: (context, scrollController) {
                  return _ArchetypesFilter(scrollController: scrollController);
                },
              );
            },
          );
        },
        child: const Icon(Icons.filter_list_alt),
      ),
    );
  }
}

class _CardsView extends ConsumerStatefulWidget {
  const _CardsView();

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends ConsumerState<_CardsView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(cardsProvider(''));
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
    final cardsState = ref.watch(cardsProvider(''));

    return Padding(
      padding: const EdgeInsets.all(15),
      child: MasonryGridView.count(
        controller: scrollController,
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
      ),
    );
  }
}

class _ArchetypesFilter extends ConsumerWidget {
  final ScrollController scrollController;

  const _ArchetypesFilter({required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureArchetypes = ref.read(cardsRepositoryProvider).getArchetype();
    final selectedArchetype = ref.watch(selectedArchetypeProvider);

    return FutureBuilder(
      future: futureArchetypes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final archetypes = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 5,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  'Filtra por archetype',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    radius: const Radius.circular(8),
                    thickness: 8,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: archetypes.length,
                      itemBuilder: (context, index) {
                        final archetype = archetypes[index];
                        final isSelected =
                            selectedArchetype == archetype.archetypeName;

                        return ListTile(
                          title: Text(
                            archetype.archetypeName,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          onTap: () {
                            ref.read(selectedArchetypeProvider.notifier).state =
                                archetype.archetypeName;

                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
