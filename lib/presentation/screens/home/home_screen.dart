import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.outlined(
                onPressed: () {
                  // context.push('/cards');
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
