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
      backgroundColor: const Color(0xFFC2B4A7),
      appBar: AppBar(
        title: const Text('Catálogo de cartas'),
        centerTitle: true,
        backgroundColor: const Color(0xFFC2B4A7),
      ),
      body: const Column(
        children: [
          Expanded(child: _CardsView()),
        ],
      ),
      floatingActionButton: FilterFAB(selectedArchetype: selectedArchetype),
    );
  }
}

class _CardsView extends ConsumerStatefulWidget {
  const _CardsView();

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends ConsumerState<_CardsView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref
            .read(cardsProvider(ref.watch(selectedArchetypeProvider)).notifier)
            .loadNextPage();
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
    final selectedArchetype = ref.watch(selectedArchetypeProvider);
    final cardsState = ref.watch(cardsProvider(selectedArchetype));

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

void updateArchetype(WidgetRef ref, String archetypeName) {
  ref.read(selectedArchetypeProvider.notifier).state = archetypeName;

  ref.read(cardsProvider(archetypeName).notifier).loadNextPage();
}

class FilterFAB extends ConsumerWidget {
  const FilterFAB({
    super.key,
    required this.selectedArchetype,
  });

  final String? selectedArchetype;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      backgroundColor:
          selectedArchetype != null ? Colors.red : Colors.lightBlue,
      icon: Icon(selectedArchetype != null
          ? Icons.delete_forever
          : Icons.filter_list_alt),
      label: Text(selectedArchetype != null ? 'Eliminar filtro' : 'Filtrar'),
      onPressed: () {
        if (selectedArchetype != null) {
          _removeFilter(ref);
        } else {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: true,
                initialChildSize: 1.0,
                builder: (context, scrollController) {
                  return _ArchetypesFilter(scrollController: scrollController);
                },
              );
            },
          );
        }
      },
    );
  }
}

void _removeFilter(WidgetRef ref) {
  ref.read(selectedArchetypeProvider.notifier).state = null;

  ref.read(cardsProvider(null).notifier).loadNextPage();
}

class _ArchetypesFilter extends ConsumerWidget {
  final ScrollController scrollController;

  const _ArchetypesFilter({required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureArchetypes = ref.read(cardsRepositoryProvider).getArchetype();
    final selectedArchetype =
        ref.watch(selectedArchetypeProvider.notifier).state;

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
                            final archetypeName = archetype.archetypeName;
                            updateArchetype(ref, archetypeName);

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
