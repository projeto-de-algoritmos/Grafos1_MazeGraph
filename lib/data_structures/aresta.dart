import 'vertices.dart';

/// Descreve o tipo de uma aresta
enum TipoDeAresta {
  /// Grafos direcionados possuem arestas que indicam uma direção, dois vertices podem se ligar com a direção a -> b enquanto um outro vertice liga b <---> c, isso indica um grafo direcionado
  direcionado,

  /// Grafos não direcionados possuem ligaçoes duplas de ida em volta em seus vertices obs: os pesos são aplicados para ambos lados ex: a <--> b <--> c
  naoDirecionado,
}

class Aresta<E> {
  final Vertice<E> inicio;
  final Vertice<E> destino;
  final double? peso;

  Aresta({
    required this.inicio,
    required this.destino,
    this.peso,
  });
}
