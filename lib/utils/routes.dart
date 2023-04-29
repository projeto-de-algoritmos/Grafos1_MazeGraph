import 'package:app/components/matriz.dart';
import 'package:app/pages/game_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
    path: '/game',
    builder: (context, state) => GamePage(
      cenarioMatrix: createMatrix(
        10,
        10,
        Colors.black,
        Colors.transparent,
      ),
    ),
  ),
]);
