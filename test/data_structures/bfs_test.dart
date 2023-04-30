import 'package:app/data_structures/bfs.dart';
import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('bfs ...', () async {
    ListaDeAdjacencia<Color> listaDeAdjacencia = ListaDeAdjacencia<Color>();

    final ver1 = listaDeAdjacencia.criarVertice(Colors.black, 1, 1);
    final ver2 = listaDeAdjacencia.criarVertice(Colors.transparent, 1, 2);
    listaDeAdjacencia.addAresta(inicio: ver1, destino: ver2);

    final result =
        await listaDeAdjacencia.breadthFirstSearchWithFinal(ver1, ver2);

    print(listaDeAdjacencia.toString());

    print("BFS: $result");
  });
}
