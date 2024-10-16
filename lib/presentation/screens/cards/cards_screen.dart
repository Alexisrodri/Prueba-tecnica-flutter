import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
