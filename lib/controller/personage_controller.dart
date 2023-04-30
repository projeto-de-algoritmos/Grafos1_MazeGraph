import 'package:app/data_structures/bfs.dart';
import 'package:app/data_structures/vertices.dart';
import 'package:app/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

const initialCharposition = Tuple2(1, 1);
const winGamePosition = Tuple2(28, 28);

class PersonagemController extends ValueNotifier<Tuple2<int, int>> {
  PersonagemController(super.value);

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

  Future<void> comecaAandar() async {
    print("Solved Grafo: $solvedGrafo");
    for (var vertice in solvedGrafo!) {
      await Future.delayed(const Duration(seconds: 1));
      print("Andou no ${vertice.indexX} x ${vertice.indexY}");
      personagemPositionController.update(vertice.indexX, vertice.indexY);
    }
  }
}
