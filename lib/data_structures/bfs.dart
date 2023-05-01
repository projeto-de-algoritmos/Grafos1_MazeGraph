import 'package:app/data_structures/aresta.dart';
import 'package:app/data_structures/fila.dart';
import 'grafo.dart';
import 'vertices.dart';

/// Complexidade O(n+m)
extension BreadthFirstSearch<E> on Grafo<E> {
  Future<List<Vertice<E>>> breadthFirstSearch(
      Vertice<E> inicio, Vertice<E> destino) async {
    final queue = QueueList<Vertice<E>>();
    Set<Vertice<E>> enqueued = {};
    List<Vertice<E>> visitado = [];

    queue.enqueue(inicio);
    enqueued.add(inicio);
    while (!queue.isEmpty) {
      //!TODO Problema ta aqui
      final vertice = queue.dequeue();
      if (vertice == null) break;

      visitado.add(vertice);

      final arestasVizinhas = obterArestas(vertice);
      for (final aresta in arestasVizinhas) {
        if (!enqueued.contains(aresta.destino)) {
          queue.enqueue(aresta.destino);
          enqueued.add(aresta.destino);
          //! Caso Encontre o caminho retorne.
          if (aresta.destino == destino) {
            return visitado;
          }
        }
      }
    }
    return visitado;
  }
}

extension BreadthFirstSearchWithFinal<E> on Grafo<E> {
  Future<List<Vertice<E>>> breadthFirstSearchWithFinal(
    Vertice<E> inicio,
    Vertice<E> destino,
  ) async {
    List<Vertice<E>> verticeVisitados = [];
    List<Aresta<E>> arestasVisitadas = [];
    QueueList<Vertice<E>> queueVertices = QueueList<Vertice<E>>();

    // Para cada nó (s) do grafo (G)  não visitado faça
    for (var no in vertices) {
      // (S) pilha enqueue (s)
      queueVertices.enqueue(no);
      // mark visited (s)
      if (!verticeVisitados.contains(no)) {
        verticeVisitados.add(no);
      }
      // Enquanto S(pilha) is not empyt faça:
      while (!queueVertices.isEmpty) {
        // vertice u  que vai ser desempilhado
        final u = queueVertices.dequeue();
        if (u == null) {
          print("temos um problema");
        }
        // para cada aresta (a) na lista de adjacencia[u]
        for (Aresta<E> a in obterArestas(u!)) {
          // se aresta não for explorado
          if (!arestasVisitadas.contains(a)) {
            // marca como visitado o vertice e a aresta
            arestasVisitadas.add(a);
            if (!verticeVisitados.contains(a.destino)) {
              verticeVisitados.add(a.destino);
            }
            // se a.destino == destino return visitado
            if (a.destino == destino) {
              return verticeVisitados;
            }
            // enqueue v
            queueVertices.enqueue(a.destino);
          }
        }
      }
    }

    return verticeVisitados;
  }
}
