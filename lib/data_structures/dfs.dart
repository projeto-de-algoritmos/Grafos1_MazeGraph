import 'package:app/data_structures/grafo.dart';
import 'package:app/data_structures/pilha.dart';
import 'package:app/data_structures/vertices.dart';

extension DepthFirstSearch<E> on Grafo<E> {
  List<Vertice<E>> depthFirstSearch(
    Vertice<E> inicio,
    Vertice<E> destino,
  ) {
    final stack = StackList<Vertice<E>>();
    final pushed = <Vertice<E>>{};
    final visited = <Vertice<E>>[];
    stack.push(inicio);
    pushed.add(inicio);
    visited.add(inicio);

    loop:
    while (stack.isNotEmpty) {
      final vertex = stack.peek;
      final vizinhos = obterArestas(vertex);
      for (final aresta in vizinhos) {
        if (!pushed.contains(aresta.destino)) {
          stack.push(aresta.destino);
          pushed.add(aresta.destino);
          visited.add(aresta.destino);
          continue loop;
        }
      }
      stack.pop();
    }
    return visited;
  }
}
