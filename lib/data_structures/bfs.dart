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
