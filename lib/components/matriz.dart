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
  List<Tuple2> listaDeObstaculos = [];
  for (int linha = 1; linha < linhas - 1; linha++) {
    final qtdDeParedesDeUmalinha = Random().nextInt(27) + 1;
    /* print("Quantidade de Linhas: $qtdDeParedesDeUmalinha"); */
    for (int qtd = 0; qtd < qtdDeParedesDeUmalinha; qtd++) {
      /* print("Na posição: $linha x $qtdDeParedesDeUmalinha"); */
      listaDeObstaculos.add(Tuple2(
        linha,
        Random().nextInt(28) + 1,
      ));
    }
  }

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

  //if (linha == 0 || coluna == 0 || linha == linhas - 1 ||coluna == colunas - 1)
  //! Preenche a matriz com as Cores marcantes
  matriz[posicaoInicial.head][posicaoInicial.tail] = Colors.red;
  matriz[posicaoFinal.head][posicaoFinal.tail] = Colors.yellow;

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
