import 'package:app/data_structures/bfs.dart';
import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:app/data_structures/vertices.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List<List<Color>> createMatrizTeste(
    int linhas,
    int colunas,
    Color parede,
    Tuple2<int, int> posicaoInicial,
    Tuple2<int, int> posicaoFinal,
    ListaDeAdjacencia<Color> listaDeAdjacencia) {
  //!Criando matriz com paredes
  final matriz =
      List.generate(linhas, (integer) => List.filled(colunas, parede));

  List<Tuple2> listaDeObstaculos = [
    const Tuple2(1, 2),
    const Tuple2(2, 2),
  ];

  //! Completa a matriz com caminhos indicados com cor transparente
  for (int linha = 0; linha < linhas; linha++) {
    for (int coluna = 0; coluna < colunas; coluna++) {
      // se for canto
      if (linha == 0 ||
          coluna == 0 ||
          linha == linhas - 1 ||
          coluna == colunas - 1) {
        matriz[linha][coluna] = parede;
      } else if (listaDeObstaculos.contains(Tuple2(linha, coluna))) {
        matriz[linha][coluna] = parede;
      } else {
        matriz[linha][coluna] = Colors.transparent;
        listaDeAdjacencia.criarVertice(matriz[linha][coluna], linha, coluna);
      }
    }
  }

  for (int linha = 1; linha < linhas - 1; linha++) {
    for (int coluna = 1; coluna < colunas - 1; coluna++) {
      if (matriz[linha][coluna] == parede) continue;
      // olhando pra linha de baixo
      if (matriz[linha][coluna] == matriz[linha + 1][coluna]) {
        // olhando pra linha de direita
        final verticeDeInicio = listaDeAdjacencia.vertices.firstWhere(
            (vertice) => vertice.indexX == linha && vertice.indexY == coluna);
        final verticeDeDestino = listaDeAdjacencia.vertices.firstWhere(
            (vertice) =>
                vertice.indexX == linha + 1 && vertice.indexY == coluna);
        listaDeAdjacencia.addAresta(
            inicio: verticeDeInicio, destino: verticeDeDestino);
      }
      if (matriz[linha][coluna] == matriz[linha][coluna + 1]) {
        final verticeDeInicio = listaDeAdjacencia.vertices.firstWhere(
            (vertice) => vertice.indexX == linha && vertice.indexY == coluna);
        final verticeDeDestino = listaDeAdjacencia.vertices.firstWhere(
            (vertice) =>
                vertice.indexX == linha && vertice.indexY == coluna + 1);
        listaDeAdjacencia.addAresta(
            inicio: verticeDeInicio, destino: verticeDeDestino);
      }
      // olhando pra linha de cima
      if (matriz[linha][coluna] == matriz[linha - 1][coluna]) {
        final verticeDeInicio = listaDeAdjacencia.vertices.firstWhere(
            (vertice) => vertice.indexX == linha && vertice.indexY == coluna);
        final verticeDeDestino = listaDeAdjacencia.vertices.firstWhere(
            (vertice) =>
                vertice.indexX == linha - 1 && vertice.indexY == coluna);
        listaDeAdjacencia.addAresta(
            inicio: verticeDeInicio, destino: verticeDeDestino);
        // olhando pra linha de esquerda
      }
      if (matriz[linha][coluna] == matriz[linha][coluna - 1]) {
        final verticeDeInicio = listaDeAdjacencia.vertices.firstWhere(
            (vertice) => vertice.indexX == linha && vertice.indexY == coluna);
        final verticeDeDestino = listaDeAdjacencia.vertices.firstWhere(
            (vertice) =>
                vertice.indexX == linha && vertice.indexY == coluna - 1);
        listaDeAdjacencia.addAresta(
            inicio: verticeDeInicio, destino: verticeDeDestino);
      }
    }
  }
  matriz[posicaoInicial.head][posicaoInicial.tail] = Colors.red;
  matriz[posicaoFinal.tail][posicaoFinal.tail] = Colors.yellow;
  return matriz;
}

void main() {
  test('bfs ...', () async {
    ListaDeAdjacencia<Color> listaDeAdjacencia = ListaDeAdjacencia<Color>();
    // L0
    /* final ver00 = listaDeAdjacencia.criarVertice(Colors.black, 0, 0);
    final ver01 = listaDeAdjacencia.criarVertice(Colors.black, 0, 1);
    final ver02 = listaDeAdjacencia.criarVertice(Colors.black, 0, 2);
    final ver03 = listaDeAdjacencia.criarVertice(Colors.black, 0, 3);
    final ver04 = listaDeAdjacencia.criarVertice(Colors.black, 0, 4); */

    // L1
    /* final ver10 = listaDeAdjacencia.criarVertice(Colors.black, 1, 0); */
    // CHaracter POSition
    final character = listaDeAdjacencia.criarVertice(Colors.red, 1, 1);
    final ver12 = listaDeAdjacencia.criarVertice(Colors.black, 1, 2);
    final ver13 = listaDeAdjacencia.criarVertice(Colors.transparent, 1, 3);
    /* final ver14 = listaDeAdjacencia.criarVertice(Colors.black, 1, 4); */

    // L2
    /* final ver20 = listaDeAdjacencia.criarVertice(Colors.black, 2, 0); */
    final ver21 = listaDeAdjacencia.criarVertice(Colors.transparent, 2, 1);
    final ver22 = listaDeAdjacencia.criarVertice(Colors.black, 2, 2);
    final ver23 = listaDeAdjacencia.criarVertice(Colors.transparent, 2, 3);
    /* final ver24 = listaDeAdjacencia.criarVertice(Colors.black, 2, 4); */
    // L3
    /* final ver30 = listaDeAdjacencia.criarVertice(Colors.black, 3, 0); */
    final ver31 = listaDeAdjacencia.criarVertice(Colors.transparent, 3, 1);
    final ver32 = listaDeAdjacencia.criarVertice(Colors.transparent, 3, 2);
    //Result
    final ganhou = listaDeAdjacencia.criarVertice(Colors.yellow, 3, 3);
    /* final ver34 = listaDeAdjacencia.criarVertice(Colors.black, 3, 4); */
    // L4
    /* final ver40 = listaDeAdjacencia.criarVertice(Colors.black, 4, 0);
    final ver41 = listaDeAdjacencia.criarVertice(Colors.black, 4, 1);
    final ver42 = listaDeAdjacencia.criarVertice(Colors.black, 4, 2);
    final ver43 = listaDeAdjacencia.criarVertice(Colors.black, 4, 3);
    final ver44 = listaDeAdjacencia.criarVertice(Colors.black, 4, 4); */

    //Print grafo as matriz

    printAdjacentList(listaDeAdjacencia);

    final matriz = createMatrizTeste(
      5,
      5,
      Colors.black,
      const Tuple2(1, 1),
      const Tuple2(3, 3),
      listaDeAdjacencia,
    );

    print("___________________MAtriz____________________");
    for (var element in matriz) {
      print(element);
    }

    print("___________________BFS____________________");

    final result =
        await listaDeAdjacencia.breadthFirstSearchWithFinal(character, ganhou);
    print("BFS: $result");

    /* print(listaDeAdjacencia.toString()); */

    //! simulando ele andando
    print("___________________Andando____________________");
    Tuple2 oldPosition = const Tuple2(1, 1);
    for (Vertice<Color> vertice in result) {
      //Se ele ta na posição inicial não alteramos nada
      matriz[oldPosition.value1][oldPosition.value2] = Colors.transparent;
      matriz[vertice.indexX][vertice.indexY] = Colors.red;
      print(
          "Posição anterior: $oldPosition ${matriz[oldPosition.value1][oldPosition.value2]} | Posicao Atual: ${vertice.indexX} x ${vertice.indexY} ${matriz[vertice.indexX][vertice.indexY]}");
      oldPosition = Tuple2(vertice.indexX, vertice.indexY);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  });
}

void printAdjacentList(ListaDeAdjacencia<Color> listaDeAdjacencia) {
  print("___________________LISta adjacencia____________________");
  var cont = 0;
  String string = "";
  for (var vertice in listaDeAdjacencia.vertices) {
    if (cont == 3) {
      print(string);
      cont = 0;
      string = "";
    }
    string += "$vertice |";
    cont++;
  }
  print(string);
}
