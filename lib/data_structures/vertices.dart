class Vertice<E> {
  final int indexX;
  final int indexY;
  final E dado;

  Vertice({
    required this.indexX,
    required this.indexY,
    required this.dado,
  });

  @override
  String toString() => dado.toString();
}
