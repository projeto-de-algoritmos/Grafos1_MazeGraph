import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:app/main.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GamePage extends StatefulWidget {
  final List<List<Color>> cenarioMatrix;
  final ListaDeAdjacencia<Color> listaDeAdjacencia;

  const GamePage({
    super.key,
    required this.cenarioMatrix,
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
    return GestureDetector(
      onTap: () {
        final sla = personagemPositionController.value.head + 1;
        final sla2 = personagemPositionController.value.tail + 1;

        final oldPosition = personagemPositionController.value;
        personagemPositionController.update(sla, sla2);
        widget.cenarioMatrix[oldPosition.value1][oldPosition.value2] =
            Colors.transparent;
        widget.cenarioMatrix[personagemPositionController.value.value1]
            [personagemPositionController.value.value2] = Colors.red;
        print(
            "Posição atual: ${personagemPositionController.value.value1} x ${personagemPositionController.value.value2} \n Posição anterior: ${oldPosition.value1} x ${oldPosition.value2}");
      },
      child: ValueListenableBuilder(
          valueListenable: personagemPositionController,
          builder: (context, snapshot, child) {
            var qtd = 0;
            final persona = widget.cenarioMatrix.forEach((element) {
              if (element.contains(Colors.red)) {
                qtd++;
              }
            });
            print("Quantidade de personagens na tela: $qtd");
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.cenarioMatrix.length, // Column
              ),
              itemCount: widget.cenarioMatrix.length *
                  widget.cenarioMatrix.length, // row
              itemBuilder: (BuildContext context, int index) {
                final row = index ~/ widget.cenarioMatrix[0].length;
                final col = index % widget.cenarioMatrix[0].length;

                if (widget.cenarioMatrix[row][col] == Colors.red) {
                  return const RiveAnimation.asset(
                    'assets/personagem_2.riv',
                    animations: [
                      "Walk sem livro",
                    ],
                  );
                }
                return Container(
                  color: widget.cenarioMatrix[row][col],
                );
              },
            );
          }),
    );
  }
}
