import 'aresta.dart';
import 'vertices.dart';

abstract class Grafo<E> {
  Iterable<Vertice<E>> get vertices;
  List<Aresta<E>> obterArestas(Vertice<E> source);

  /// Criar um Vertice somente com só um dado.
  Vertice<E> criarVertice(E dado, int indexX, int indexY);
  // adiciona uma Aresta
  void addAresta({
    required Vertice<E> inicio,
    required Vertice<E> destino,
    TipoDeAresta tipoDeAresta = TipoDeAresta.direcionado,
    required double? peso,
  });
  // mostra o peso de um vertice
  double? peso(
    Vertice<E> inicio,
    Vertice<E> destino,
  );
}
