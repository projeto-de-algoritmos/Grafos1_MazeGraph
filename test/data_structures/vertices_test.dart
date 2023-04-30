import 'package:app/data_structures/vertices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('vertices ', () {
    Vertice<Color> v1 = const Vertice(indexX: 1, indexY: 1, dado: Colors.blue);
    Vertice<Color> expectedV1 =
        const Vertice(indexX: 1, indexY: 1, dado: Colors.blue);

    expect(v1.hashCode, equals(expectedV1.hashCode));
  });
}
