import 'package:dartz/dartz.dart';

import 'aresta.dart';
import 'grafo.dart';
import 'vertices.dart';

/// Espaço alocado: O(n + m), Adicionar Vertice: O(1), Adicionar Aresta: O(1), Encontrar Arestas e Vertices: O(n)
class ListaDeAdjacencia<E> implements Grafo<E> {
  Map<Vertice<E>, List<Aresta<E>>> conecoes = {};

  int quatidadeDeAresta() {
    var qtd = 0;
    for (var element in conecoes.values) {
      qtd += element.length;
    }
    return qtd;
  }

  bool updateVertice(Tuple2<int, int> pos, E newValue) {
    try {
      var vertice = conecoes.keys.firstWhere((vertice) =>
          vertice.indexX == pos.value1 && vertice.indexY == pos.value2);

      final arestas = conecoes.remove(vertice);

      conecoes[vertice]?.addAll(arestas!);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override

  /// Para obter as arestas, caso seja nulo retorna [ ]
  Iterable<Vertice<E>> get vertices => conecoes.keys;

  @override

  /// Para obter as arestas, caso seja nulo retorna [ ]
  List<Aresta<E>> obterArestas(Vertice<E> inicio) {
    final conect = conecoes[inicio];
    return conecoes[inicio] ?? [];
  }

  @override
  Vertice<E> criarVertice(E dado, int indexX, int indexY) {
    final vertice = Vertice(
      indexX: indexX,
      indexY: indexY,
      dado: dado,
    );

    conecoes[vertice] = [];
    return vertice;
  }

  @override
  void addAresta({
    required Vertice<E> inicio,
    required Vertice<E> destino,
    TipoDeAresta tipoDeAresta = TipoDeAresta.direcionado,
    double? peso,
  }) {
    // adicionamos a aresta com base no vertice de inicio -> destino
    conecoes[inicio]?.add(Aresta(inicio: inicio, destino: destino, peso: peso));

    /* print(conecoes); */
    // Caso o Grafo seja não direcionado add aresta destino -> inicio
    if (tipoDeAresta == TipoDeAresta.naoDirecionado) {
      conecoes[destino]
          ?.add(Aresta(inicio: destino, destino: inicio, peso: peso));
    }
  }

  @override

  /// Essa função busca o peso baseado na posição de inicio e de destino caso não encontre retorna null
  double? peso(Vertice<E> inicio, Vertice<E> destino) {
    final match = obterArestas(inicio).where((aresta) {
      return aresta.destino == destino;
    });
    if (match.isEmpty) return null;
    return match.first.peso;
  }

  @override
  String toString() {
    final result = StringBuffer();

    conecoes.forEach((vertice, arestas) {
      final destinos = arestas.map((aresta) {
        return aresta.destino;
      }).join('| ');
      result.writeln('$vertice --> $destinos');
    });

    return result.toString();
  }
}
