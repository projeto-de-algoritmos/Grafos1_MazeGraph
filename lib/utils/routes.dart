import 'package:app/main.dart';
import 'package:app/pages/game_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
    path: '/game',
    builder: (context, state) {
      return GamePage(
        listaDeAdjacencia: matrizes.head,
      );
    },
  ),
]);
