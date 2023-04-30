import 'package:app/data_structures/aresta.dart';
import 'package:app/data_structures/grafo.dart';
import 'package:app/data_structures/vertices.dart';

/// Espaço alocado: O(n²), Adicionar Vertice: O(n²), Adicionar Aresta: O(1), Encontrar Arestas e Vertices: O(1)
class MatrixDeAdjacencia<E> implements Grafo<E> {
  final List<Vertice<E>> _vertices = [];

  /// matriz de pesos
  final List<List<double?>?> _pesos = [];
  var _proximaPosicao = 0;

  @override
  Iterable<Vertice<E>> get vertices => _vertices;

  @override
  void addAresta({
    required Vertice<E> inicio,
    required Vertice<E> destino,
    TipoDeAresta tipoDeAresta = TipoDeAresta.direcionado,
    required double? peso,
  }) {
    // para adicionar arestas representamos elas com os pesos
    _pesos[inicio.indexX]?[destino.indexX] = peso;
    // para grafos não direcionados é preciso adicionar dos dois lados da matriz
    if (tipoDeAresta == TipoDeAresta.naoDirecionado) {
      _pesos[destino.indexX]?[inicio.indexX] = peso;
    }
  }

  ///TODO? dúvida porque preencher isso com nulll nos pesos??
  @override
  Vertice<E> criarVertice(E dado, int IndexX, int IndexY) {
    final vertice = Vertice(
      indexX: IndexX,
      indexY: IndexY,
      dado: dado,
    );
    _proximaPosicao++;
    _vertices.add(vertice);

    // Preenche a coluna com null
    for (var i = 0; i < _pesos.length; i++) {
      _pesos[i]?.add(null);
    }

    // Preenche a linha com null
    final linha = List<double?>.filled(
      _vertices.length,
      null,
      growable: true,
    );
    _pesos.add(linha);

    return vertice;
  }

  @override

  /// Obter arestas daquele vertice
  List<Aresta<E>> obterArestas(Vertice<E> inicio) {
    List<Aresta<E>> arestas = [];

    for (var column = 0; column < _pesos.length; column++) {
      final peso = _pesos[inicio.indexX]?[column];

      if (peso == null) continue;

      final destino = _vertices[column];
      arestas.add(Aresta(inicio: inicio, destino: destino, peso: peso));
    }

    return arestas;
  }

  @override
  double? peso(Vertice<E> inicio, Vertice<E> destino) {
    return _pesos[inicio.indexX]?[destino.indexX];
  }

  @override
  String toString() {
    final output = StringBuffer();
    for (final vertice in _vertices) {
      output.writeln('${vertice.indexX}: ${vertice.dado}');
    }

    for (int i = 0; i < _pesos.length; i++) {
      for (int j = 0; j < _pesos.length; j++) {
        final value = (_pesos[i]?[j] ?? '.').toString();
        output.write(value.padRight(6));
      }
      output.writeln();
    }
    return output.toString();
  }
}
