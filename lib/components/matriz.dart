import 'dart:math';
import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Generate a pixelMatrix and fill it
List<List<Color>> createMatrix(
    int rows, int cols, Color borderColor, Color fillColor) {
  final matrix = List.generate(rows, (_) => List.filled(cols, borderColor));

  for (int row = 1; row < rows - 1; row++) {
    for (int col = 1; col < cols - 1; col++) {
      if (row == 4 && col == 4) {
        matrix[row][col] = Colors.red;
      } else {
        matrix[row][col] = fillColor;
      }
    }
  }

  return matrix;
}
// Color.red -> personagem
// Color.black -> parede
// Color.transparent -> caminhos possiveis

Tuple2<ListaDeAdjacencia<Color>, List<List<Color>>>
    createMatrizDeAdjacenciaEDecolor(int linhas, int colunas, Color parede,
        Tuple2<int, int> posicaoInicial, Tuple2<int, int> posicaoFinal) {
  ListaDeAdjacencia<Color> listaDeAdjacencia = ListaDeAdjacencia<Color>();
  //!Criando matriz com paredes
  final matriz =
      List.generate(linhas, (integer) => List.filled(colunas, parede));

  //! Gerando lista de obstáculos
  List<Tuple2> listaDeObstaculos = [
    Tuple2(1,8), Tuple2(1,14), Tuple2(1,23),
    Tuple2(2,2), Tuple2(2,3), Tuple2(2,4), Tuple2(2,6), Tuple2(2,7), Tuple2(2,8), Tuple2(2,10), Tuple2(2,11), Tuple2(2,12), Tuple2(2,14), Tuple2(2,15), Tuple2(2,16), Tuple2(2,18), Tuple2(2,19), Tuple2(2,20), Tuple2(2,21), Tuple2(2,22), Tuple2(2,23), Tuple2(2,25), Tuple2(2,26), Tuple2(2,27),
    Tuple2(3,2), Tuple2(3,8), Tuple2(3,10), Tuple2(3,18), Tuple2(3,27),
    Tuple2(4,2), Tuple2(4,3), Tuple2(4,4), Tuple2(4,5), Tuple2(4,6), Tuple2(4,7), Tuple2(4,8), Tuple2(4,10), Tuple2(4,11), Tuple2(4,12), Tuple2(4,13), Tuple2(4,14), Tuple2(4,16), Tuple2(4,18), Tuple2(4,19), Tuple2(4,20), Tuple2(4,21), Tuple2(4,22), Tuple2(4,23), Tuple2(4,24), Tuple2(4,25), Tuple2(4,26), Tuple2(4,27),
    Tuple2(5,2), Tuple2(5,6), Tuple2(5,10), Tuple2(5,14), Tuple2(5,16), Tuple2(5,25),
    Tuple2(6,4), Tuple2(6,5), Tuple2(6,6), Tuple2(6,8), Tuple2(6,9), Tuple2(6,10), Tuple2(6,12), Tuple2(6,13), Tuple2(6,14), Tuple2(6,16), Tuple2(6,17), Tuple2(6,18), Tuple2(6,19), Tuple2(6,20), Tuple2(6,21), Tuple2(6,22), Tuple2(6,23), Tuple2(6,25), Tuple2(6,27),
    Tuple2(7,2), Tuple2(7,4), Tuple2(7,12), Tuple2(7,19), Tuple2(7,25), Tuple2(7,27),
    Tuple2(8,2), Tuple2(8,4), Tuple2(8,6), Tuple2(8,8), Tuple2(8,9), Tuple2(8,10), Tuple2(8,11), Tuple2(8,12), Tuple2(8,13), Tuple2(8,14), Tuple2(8,15), Tuple2(8,16), Tuple2(8,17), Tuple2(8,18), Tuple2(8,19), Tuple2(8,21), Tuple2(8,22), Tuple2(8,23), Tuple2(8,24), Tuple2(8,25), Tuple2(8,27),
    Tuple2(9,2), Tuple2(9,4), Tuple2(9,6), Tuple2(9,8), Tuple2(9,16), Tuple2(9,21),Tuple2(9,27),
    Tuple2(10,2), Tuple2(10,4), Tuple2(10,6), Tuple2(10,8), Tuple2(10,10), Tuple2(10,11), Tuple2(10,12), Tuple2(10,13), Tuple2(10,14), Tuple2(10,16), Tuple2(10,18), Tuple2(10,19), Tuple2(10,20), Tuple2(10,21), Tuple2(10,23), Tuple2(10,24), Tuple2(10,25), Tuple2(10,26), Tuple2(10,27),
    Tuple2(11,2), Tuple2(11,4), Tuple2(11,6), Tuple2(11,8), Tuple2(11,10), Tuple2(11,14), Tuple2(11,16), Tuple2(11,18), Tuple2(11,23),
    Tuple2(12,2), Tuple2(12,4), Tuple2(12,5), Tuple2(12,6), Tuple2(12,8), Tuple2(12,10), Tuple2(12,12), Tuple2(12,13), Tuple2(12,14), Tuple2(12,16), Tuple2(12,18), Tuple2(12,20), Tuple2(12,21), Tuple2(12,23), Tuple2(12,24), Tuple2(12,25), Tuple2(12,26), Tuple2(12,27),
    Tuple2(13,2), Tuple2(13,6), Tuple2(13,8), Tuple2(13,10), Tuple2(13,12),  Tuple2(13,18), Tuple2(13,20), Tuple2(13,21), Tuple2(13,23), Tuple2(13,27),
    Tuple2(14,2), Tuple2(14,4), Tuple2(14,6), Tuple2(14,8), Tuple2(14,10), Tuple2(14,12), Tuple2(14,14), Tuple2(14,15), Tuple2(14,16), Tuple2(14,16), Tuple2(14,17), Tuple2(14,18), Tuple2(14,20), Tuple2(14,21), Tuple2(14,23), Tuple2(14,25), Tuple2(14,27), Tuple2(14,28),
    Tuple2(15,2), Tuple2(15,4), Tuple2(15,6), Tuple2(15,8), Tuple2(15,10), Tuple2(15,12), Tuple2(15,16), Tuple2(15,18), Tuple2(15,20), Tuple2(15,21), Tuple2(15,23), Tuple2(15,25), Tuple2(15,27),
    Tuple2(16,1), Tuple2(16,2), Tuple2(16,4), Tuple2(16,6), Tuple2(16,8), Tuple2(16,10), Tuple2(16,12), Tuple2(16,14), Tuple2(16,15), Tuple2(16,16), Tuple2(16,18), Tuple2(16,20), Tuple2(16,21), Tuple2(16,23), Tuple2(16,25), Tuple2(16,27),
    Tuple2(17,2), Tuple2(17,4), Tuple2(17,6), Tuple2(17,8), Tuple2(17,10), Tuple2(17,12), Tuple2(17,14), Tuple2(17,18), Tuple2(17,19), Tuple2(17,20), Tuple2(17,25), Tuple2(17,27),
    Tuple2(18,2), Tuple2(18,4), Tuple2(18,6), Tuple2(18,8), Tuple2(18,10), Tuple2(18,12), Tuple2(18,14), Tuple2(18,16), Tuple2(18,17), Tuple2(18,18), Tuple2(18,20), Tuple2(18,22), Tuple2(18,23), Tuple2(18,24), Tuple2(18,25), Tuple2(18,27),
    Tuple2(19,2), Tuple2(19,4), Tuple2(19,8), Tuple2(19,10), Tuple2(19,14), Tuple2(19,17), Tuple2(19,20), Tuple2(19,22),
    Tuple2(20,2), Tuple2(20,3), Tuple2(20,4), Tuple2(20,6), Tuple2(20,7), Tuple2(20,8), Tuple2(20,10), Tuple2(20,11), Tuple2(20,12), Tuple2(20,13), Tuple2(20,14), Tuple2(20,15), Tuple2(20,22), Tuple2(20,24), Tuple2(20,25), Tuple2(20,26), Tuple2(20,27),
    Tuple2(21,8), Tuple2(21,15), Tuple2(21,16), Tuple2(21,17), Tuple2(21,18), Tuple2(21,19), Tuple2(21,20), Tuple2(21,22), Tuple2(21,24), Tuple2(21,26), Tuple2(21,27),
    Tuple2(22,2), Tuple2(22,3), Tuple2(22,4), Tuple2(22,5), Tuple2(22,6), Tuple2(22,7), Tuple2(22,8), Tuple2(22,9), Tuple2(22,10), Tuple2(22,11), Tuple2(22,12), Tuple2(22,13), Tuple2(22,15), Tuple2(22,17), Tuple2(22,22), Tuple2(22,24), Tuple2(22,26), Tuple2(22,27),
    Tuple2(23,1), Tuple2(23,2), Tuple2(23,4), Tuple2(23,13), Tuple2(23,15), Tuple2(23,17), Tuple2(23,19), Tuple2(23,20), Tuple2(23,21), Tuple2(23,22), Tuple2(23,24), Tuple2(23,27),
    Tuple2(24,4), Tuple2(24,6), Tuple2(24,7), Tuple2(24,8), Tuple2(24,9), Tuple2(24,10), Tuple2(24,11), Tuple2(24,15), Tuple2(24,17), Tuple2(24,22), Tuple2(24,24), Tuple2(24,25),
    Tuple2(25,2), Tuple2(25,4), Tuple2(25,6), Tuple2(25,11), Tuple2(25,12), Tuple2(25,13), Tuple2(25,14), Tuple2(25,15), Tuple2(25,17), Tuple2(25,18), Tuple2(25,19), Tuple2(25,20), Tuple2(25,22), Tuple2(25,25), Tuple2(25,26), Tuple2(25,27), Tuple2(25,28),
    Tuple2(26,2), Tuple2(26,6), Tuple2(26,8), Tuple2(26,9), Tuple2(26,13), Tuple2(26,15), Tuple2(26,17),  Tuple2(26,22),
    Tuple2(27,2), Tuple2(27,3), Tuple2(27,4), Tuple2(27,5), Tuple2(27,6), Tuple2(27,9), Tuple2(27,11), Tuple2(27,12), Tuple2(27,13), Tuple2(27,15), Tuple2(27,17), Tuple2(27,19), Tuple2(27,20), Tuple2(27,21), Tuple2(27,22), Tuple2(27,23), Tuple2(27,24), Tuple2(27,25), Tuple2(27,26), Tuple2(27,27),
    Tuple2(28,27), Tuple2(28,9)
  ];

  //! Preenchendo matriz de cores com obstáculos aleatórios
  for (var element in listaDeObstaculos) {
    matriz[element.value1][element.value2] = parede;
  }

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
  try {
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
  } catch (e) {
    print(e);
  }

  matriz[posicaoInicial.head][posicaoInicial.tail] = Colors.red;
  listaDeAdjacencia.updateVertice(
      Tuple2(posicaoInicial.head, posicaoInicial.tail), Colors.red);
  matriz[posicaoFinal.tail][posicaoFinal.tail] = Colors.yellow;
  listaDeAdjacencia.updateVertice(
      Tuple2(posicaoFinal.head, posicaoFinal.tail), Colors.yellow);

  print(
      "Quatidade de arestas: ${listaDeAdjacencia.quatidadeDeAresta()} Quantidade de nós: ${listaDeAdjacencia.vertices.length}");
  /* print(
      "Quantidade de nós: ${listaDeAdjacencia.vertices.length} Quantidade de obstáculos: ${listaDeObstaculos.length} = ${listaDeAdjacencia.vertices.length + listaDeObstaculos.length + 126}  900");
  matriz.asMap().keys.forEach(
    (element) {
      final strings = matriz[element].asMap();
      print("$element - $strings");
    },
  ); */

  return Tuple2(listaDeAdjacencia, matriz);
}
