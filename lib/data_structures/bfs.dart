import 'package:app/data_structures/aresta.dart';
import 'package:app/data_structures/fila.dart';
import 'grafo.dart';
import 'vertices.dart';

extension BreadthFirstSearchWithFinal<E> on Grafo<E> {
  Future<List<Vertice<E>>> bfs(
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
      while (queueVertices.isNotEmpty) {
        // vertice u  que vai ser desempilhado
        final u = queueVertices.dequeue();
        if (obterArestas(u!).isEmpty) {
          /*  print("Lista de arestas vazia para o vertice: $u"); */
        }
        // para cada aresta (a) na lista de adjacencia[u]
        for (Aresta<E> a in obterArestas(u)) {
          // se aresta não for explorado
          if (!arestasVisitadas.contains(a)) {
            // marca como visitado o vertice e a aresta
            arestasVisitadas.add(a);
            if (!verticeVisitados.contains(a.destino)) {
              verticeVisitados.add(a.destino);
            }
            // enqueue v
            queueVertices.enqueue(a.destino);
          }
        }
      }
    }
    return verticeVisitados;
  }

  Future<List<Vertice<E>>> findBFSpath(
      Vertice<E> startNode, Vertice<E> endNode) async {
    QueueList<Vertice<E>> queue = QueueList<Vertice<E>>();
    Set visited = {};
    Map parent = {};

    queue.enqueue(startNode);
    visited.add(startNode);

    while (queue.isNotEmpty) {
      Vertice<E>? currentNode = queue.dequeue();
      if (currentNode == endNode) {
        // Se chegamos ao nó final, construímos o caminho
        List<Vertice<E>> path = [currentNode!];
        while (currentNode != startNode) {
          currentNode = parent[currentNode];
          path.insert(0, currentNode!);
        }
        return path;
      }
      for (Aresta<E> a in obterArestas(currentNode!)) {
        // se aresta não for explorado
        if (!visited.contains(a.destino)) {
          queue.enqueue(a.destino);
          visited.add(currentNode);
          parent[a.destino] = currentNode;
        }
      }
    }
    // Se não encontramos o nó final, retornamos uma lista vazia
    return [];
  }
}
