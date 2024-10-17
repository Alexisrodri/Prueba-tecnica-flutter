import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/presentation/providers/providers.dart';

class CardScreen extends ConsumerWidget {
  final String cardId;
  const CardScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(cardProvider(cardId));
    return Scaffold(
      appBar: AppBar(
        title: Text(cardState.id),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cardId),
            Text(cardState.card?.name ?? 'No found card	')
          ],
        ),
      ),
    );
  }
}
