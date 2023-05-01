import 'package:app/data_structures/aresta.dart';
import 'package:app/data_structures/fila.dart';
import 'package:flutter/material.dart';
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
    while (queue.isNotEmpty) {
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

  Future<List<Vertice<E>>> bfs(Vertice<E> startNode, Vertice<E> endNode) async {
    QueueList<Vertice<E>> queue = QueueList<Vertice<E>>();
    Set visited = {};
    Map parent = {};
    /*  print("End Node $endNode"); */

    queue.enqueue(startNode);
    visited.add(startNode);

    while (queue.isNotEmpty) {
      Vertice<E>? currentNode = queue.dequeue();
      /*    print("Current Node $currentNode");
      print("Qtd de Arestas: ${obterArestas(currentNode!)}") */

      if (currentNode!.dado == Colors.red) {
        /*     print("Passei pela posição inicial"); */
      }

      if (currentNode.dado == Colors.yellow) {
        /* print("Passei pela posição final"); */
      }
      if (currentNode == endNode) {
        // Se chegamos ao nó final, construímos o caminho
        List<Vertice<E>> path = [currentNode];
        while (currentNode != startNode) {
          currentNode = parent[currentNode];
          path.insert(0, currentNode!);
        }
        return path;
      }

      for (Aresta<E> a in obterArestas(currentNode)) {
        // se aresta não for explorado
        if (!visited.contains(a.destino)) {
          /* print(a.destino); */
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
