import 'package:go_router/go_router.dart';

import '../../presentation/screens.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/cards',
    builder: (context, state) => const CardsScreen(),
    routes: [
      GoRoute(
        path: ':id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return CardScreen(
            cardId: id,
          );
        },
      )
    ],
  ),
]);
