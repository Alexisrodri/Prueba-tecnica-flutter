import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartas'),
      ),
      body: const Column(
        children: [
          // if (selectedArchetype != null)
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Text(
          //       'Selected Archetype: $selectedArchetype',
          //       style: const TextStyle(fontSize: 18),
          //     ),
          //   ),
          Expanded(child: _CardsView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return DraggableScrollableSheet(
          //       expand: false,
          //       initialChildSize: 0.3,
          //       minChildSize: 0.1,
          //       maxChildSize: 0.8,
          //       builder: (context, scrollController) {
          //         // return _ArchetypesFilter(scrollController: scrollController);
          //       },
          //     );
          //   },
          // );
        },
        child: const Icon(Icons.filter_list_alt),
      ),
    );
  }
}

class _CardsView extends StatefulWidget {
  const _CardsView();

  @override
  State<_CardsView> createState() => __CardsViewState();
}

class __CardsViewState extends State<_CardsView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final cardsState = ref.watch(cardsProvider(''));

    return const Padding(
      padding: EdgeInsets.all(15),
      child: Text('masonry add'),
      // MasonryGridView.count(
      //   controller: scrollController,
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 20,
      //   crossAxisSpacing: 35,
      //   itemCount: cardsState.cards.length,
      //   itemBuilder: (context, index) {
      //     final card = cardsState.cards[index];
      //     return GestureDetector(
      //       onTap: () => context.push('/cards/${card.id}'),
      //       child: CardsCardview(card: card),
      //     );
      //   },
      // ),
    );
  }
}

class ArchetypesFilter extends StatelessWidget {
  final ScrollController scrollController;

  const ArchetypesFilter({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text(
                      'lista de filtros',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
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
  }
}
