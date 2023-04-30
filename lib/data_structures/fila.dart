
abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

/// Filas seguem o padrão FIFO então o primeiro a entrar será o primeiro a sair.
/// isEmpty: O(1), enqueue: O(n) - pior caso, dequeue: 0(n) - pior caso, peek: O(1)
class QueueList<E> implements Queue<E> {
  final _list = <E>[];

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => (isEmpty) ? null : _list.first;

  @override
  bool enqueue(E element) {
    _list.add(element);
    return true;
  }

  @override
  E? dequeue() => (isEmpty) ? null : _list.removeAt(0);
}
