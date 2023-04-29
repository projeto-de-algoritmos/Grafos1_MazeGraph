import 'package:flutter/material.dart';

/// Generate a pixelMatrix and fill it
List<List<Color>> createMatrix(
    int rows, int cols, Color borderColor, Color fillColor) {
  final matrix = List.generate(rows, (_) => List.filled(cols, borderColor));

  for (int row = 1; row < rows - 1; row++) {
    for (int col = 1; col < cols - 1; col++) {
      if (row == 4 && col == 4) {
        matrix[row][col] = Colors.red;
      } else {
        matrix[row][col] = fillColor;
      }
    }
  }

  return matrix;
}
