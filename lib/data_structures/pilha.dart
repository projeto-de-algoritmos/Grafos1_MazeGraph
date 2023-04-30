class StackList<E> {
  StackList() : _storage = <E>[];
  final List<E> _storage;

  E get peek => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  bool get isNotEmpty => !isEmpty;

  void push(E element) => _storage.add(element);
  E pop() => _storage.removeLast();

  @override
  String toString() {
    return '--- Topo ---\n'
        '${_storage.reversed.join('\n')}'
        '\n-----------';
  }
}
