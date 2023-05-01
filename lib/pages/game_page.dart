import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:app/main.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GamePage extends StatefulWidget {
  final ListaDeAdjacencia<Color> listaDeAdjacencia;

  const GamePage({
    super.key,
    required this.listaDeAdjacencia,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    personagemPositionController.comecaAandar();
  }

  @override
  void dispose() {
    personagemPositionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: personagemPositionController,
        builder: (context, snapshot, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  personagemPositionController.colorMatriz.length, // Column
            ),
            itemCount: personagemPositionController.colorMatriz.length *
                personagemPositionController.colorMatriz.length, // row
            itemBuilder: (BuildContext context, int index) {
              final row =
                  index ~/ personagemPositionController.colorMatriz[0].length;
              final col =
                  index % personagemPositionController.colorMatriz[0].length;

              if (personagemPositionController.colorMatriz[row][col] ==
                  Colors.red) {
                return const RiveAnimation.asset(
                  'assets/personagem_2.riv',
                  animations: [
                    "Walk sem livro",
                  ],
                );
              }
              return Container(
                color: personagemPositionController.colorMatriz[row][col],
              );
            },
          );
        });
  }
}
