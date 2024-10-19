import 'package:flutter/material.dart';
import '../../../../widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  final String cardId;
  const CardScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(),
        body: const FullScreenLoader()
        // : CardDetails(cardState: cardState),
        );
  }
}
