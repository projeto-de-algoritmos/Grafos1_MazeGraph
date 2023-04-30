import 'package:equatable/equatable.dart';

class Vertice<E> extends Equatable {
  final int indexX;
  final int indexY;
  final E dado;

  const Vertice({
    required this.indexX,
    required this.indexY,
    required this.dado,
  });

  @override
  String toString() {
    final string = "$indexX x $indexY $dado";
    return string;
  }

  Vertice<E> copyWith({
    int? indexX,
    int? indexY,
    E? dado,
  }) {
    return Vertice<E>(
      indexX: indexX ?? this.indexX,
      indexY: indexY ?? this.indexY,
      dado: dado ?? this.dado,
    );
  }

  @override
  List<Object?> get props => [indexX, indexY, dado];
}
