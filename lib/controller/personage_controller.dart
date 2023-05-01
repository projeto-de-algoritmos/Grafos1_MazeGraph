import 'package:app/data_structures/bfs.dart';
import 'package:app/data_structures/vertices.dart';
import 'package:app/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:app/data_structures/dfs.dart';

const initialCharposition = Tuple2(1, 1);
const winGamePosition = Tuple2(28, 28);
const speedOfBoy = Duration(milliseconds: 200);

final lastVertice = Vertice(
  indexX: winGamePosition.head,
  indexY: winGamePosition.tail,
  dado: Colors.yellow,
);

class GameController extends ValueNotifier<Tuple2<int, int>> {
  GameController(
    super.value,
    this.colorMatriz,
  );
  List<List<Color>> colorMatriz;
  Tuple2<int, int> oldPosition = const Tuple2(1, 1);

  late List<Vertice<Color>>? solvedGrafo;

  void updatePersonagePosition(int x, int y) {
    value = Tuple2(x, y);
  }

  Future<void> rodaBFSpath() async {
    final lastVertice = Vertice(
      indexX: winGamePosition.head,
      indexY: winGamePosition.tail,
      dado: Colors.transparent,
    );
    solvedGrafo = await matrizes.value1.findBFSpath(
        Vertice(
          indexX: initialCharposition.head,
          indexY: initialCharposition.tail,
          dado: Colors.transparent,
        ),
        lastVertice);
  }

  Future<void> rodaAllBFS() async {
    final lastVertice = Vertice(
      indexX: winGamePosition.head,
      indexY: winGamePosition.tail,
      dado: Colors.transparent,
    );
    solvedGrafo = await matrizes.value1.bfs(
        Vertice(
          indexX: initialCharposition.head,
          indexY: initialCharposition.tail,
          dado: Colors.transparent,
        ),
        lastVertice);
  }

  Future<void> rodaDFS() async {
    final lastVertice = Vertice(
      indexX: winGamePosition.head,
      indexY: winGamePosition.tail,
      dado: Colors.transparent,
    );
    solvedGrafo = matrizes.value1.depthFirstSearch(
        Vertice(
          indexX: initialCharposition.head,
          indexY: initialCharposition.tail,
          dado: Colors.transparent,
        ),
        lastVertice);
  }

  void comecaAandar(Color corASerPintada) async {
    Tuple2 oldPosition = const Tuple2(1, 1);
    //! Altera cor da matriz de cores
    for (Vertice<Color> vertice in solvedGrafo!) {
      colorMatriz[oldPosition.value1][oldPosition.value2] = corASerPintada;
      colorMatriz[vertice.indexX][vertice.indexY] = Colors.red;
      oldPosition = Tuple2(vertice.indexX, vertice.indexY);
      updatePersonagePosition(vertice.indexX, vertice.indexY);
      await Future.delayed(speedOfBoy);
    }
  }
}
