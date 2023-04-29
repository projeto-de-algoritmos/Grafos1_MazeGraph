import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Game Page")),
        leading: const BackButton(
            /* onPressed: () => GoRouter.of(context).pop(), */
            ),
      ),
      body: const Center(
        child: Text("Game Page"),
      ),
    );
  }
}
