import 'package:app/components/lista_de_obstaculos.dart';
import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

Tuple2<ListaDeAdjacencia<Color>, List<List<Color>>>
    criarMatrizDeAdjacenciaEDecolor(int linhas, int colunas, Color parede,
        Tuple2<int, int> posicaoInicial, Tuple2<int, int> posicaoFinal) {
  ListaDeAdjacencia<Color> listaDeAdjacencia = ListaDeAdjacencia<Color>();

  //! Criando matriz de cores com paredes pretas
  final matriz =
      List.generate(linhas, (integer) => List.filled(colunas, parede));

  //! Gerando lista de obstáculos
  for (var element in listaDeObstaculos) {
    matriz[element.value1][element.value2] = parede;
  }

  //! Completa a matriz com respectiva cor e cria vertices do grafo
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
  //! Adiciona arestas para cada vertice olhando cima, baixo, esquerda, direita
  for (int linha = 1; linha < linhas - 1; linha++) {
    for (int coluna = 1; coluna < colunas - 1; coluna++) {
      if (matriz[linha][coluna] == parede) continue;
      // olhando pra linha de baixo
      if (matriz[linha][coluna] == matriz[linha + 1][coluna]) {
        final verticeDeInicio = listaDeAdjacencia.vertices.firstWhere(
            (vertice) => vertice.indexX == linha && vertice.indexY == coluna);
        final verticeDeDestino = listaDeAdjacencia.vertices.firstWhere(
            (vertice) =>
                vertice.indexX == linha + 1 && vertice.indexY == coluna);
        listaDeAdjacencia.addAresta(
            inicio: verticeDeInicio, destino: verticeDeDestino);
      }
      // olhando pra linha de direita
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
  //! Preenche Posições iniciais e final do jogo com cores
  matriz[posicaoInicial.head][posicaoInicial.tail] = Colors.red;
  matriz[posicaoFinal.tail][posicaoFinal.tail] = Colors.yellow;

  return Tuple2(listaDeAdjacencia, matriz);
}
