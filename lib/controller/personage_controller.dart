import 'package:app/data_structures/bfs.dart';
import 'package:app/data_structures/vertices.dart';
import 'package:app/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

const initialCharposition = Tuple2(1, 1);
const winGamePosition = Tuple2(28, 28);

class PersonagemController extends ValueNotifier<Tuple2<int, int>> {
  PersonagemController(super.value, this.colorMatriz);
  List<List<Color>> colorMatriz;
  Tuple2<int, int> oldPosition = const Tuple2(1, 1);

  late List<Vertice<Color>>? solvedGrafo;

  void update(int x, int y) {
    value = Tuple2(x, y);
  }

  Future<void> runBFS() async {
    print("Acheiiiiiiiiiiii o grafooo");
    solvedGrafo = await matriz.value1.breadthFirstSearchWithFinal(
        Vertice(
          indexX: initialCharposition.head,
          indexY: initialCharposition.tail,
          dado: Colors.red,
        ),
        Vertice(
          indexX: winGamePosition.head,
          indexY: winGamePosition.tail,
          dado: Colors.yellow,
        ));
  }

  void comecaAandar() async {
    Tuple2 oldPosition = const Tuple2(1, 1);
    for (Vertice<Color> vertice in solvedGrafo!) {
      //Se ele ta na posição inicial não alteramos nada
      colorMatriz[oldPosition.value1][oldPosition.value2] = Colors.transparent;
      colorMatriz[vertice.indexX][vertice.indexY] = Colors.red;
      update(vertice.indexX, vertice.indexY);
      /* print(
          "Posição anterior: $oldPosition ${colorMatriz[oldPosition.value1][oldPosition.value2]} | Posicao Atual: ${vertice.indexX} x ${vertice.indexY} ${colorMatriz[vertice.indexX][vertice.indexY]}"); */
      oldPosition = Tuple2(vertice.indexX, vertice.indexY);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
