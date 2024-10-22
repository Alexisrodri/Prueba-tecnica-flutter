import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';

import '../../../widgets/widgets.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedArchetype = ref.watch(selectedArchetypeProvider);
    final cardsState = ref.watch(cardsProvider(selectedArchetype));
    final cardsNotifier = ref.read(cardsProvider(selectedArchetype).notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFC2B4A7),
      appBar: AppBar(
        title: const Text('Catálogo de cartas'),
        centerTitle: true,
        backgroundColor: const Color(0xFFC2B4A7),
      ),
      body: Column(
        children: [
          Expanded(
              child: CardsView(
            cards: cardsState.cards,
            voidCallback: () async {
              await cardsNotifier.loadNextPage();
            },
          )),
        ],
      ),
      floatingActionButton: FilterFAB(selectedArchetype: selectedArchetype),
    );
  }
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
      icon: Icon(
        selectedArchetype != null
            ? Icons.delete_forever
            : Icons.filter_list_alt,
        color: Colors.white,
      ),
      label: Text(
        selectedArchetype != null ? 'Eliminar filtro' : 'Filtrar',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
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

void updateArchetype(WidgetRef ref, String archetypeName) {
  ref.read(selectedArchetypeProvider.notifier).state = archetypeName;

  ref.read(cardsProvider(archetypeName).notifier).loadNextPage();
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
                    trackVisibility: true,
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
