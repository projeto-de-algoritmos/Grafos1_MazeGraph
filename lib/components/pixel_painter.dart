import 'package:flutter/material.dart';

///Classe Alternativa para GridView.Builder()
class PixelPainter extends CustomPainter {
  final List<List<Color>> pixelMatrix;

  PixelPainter(this.pixelMatrix);

  @override
  void paint(Canvas canvas, Size size) {
    // Define "pixel" size based on matrix.legth and device size
    final pixelSize = Size(
        size.width / pixelMatrix[0].length, size.height / pixelMatrix.length);
    //Paint pixel per pixel
    for (int row = 0; row < pixelMatrix.length; row++) {
      for (int col = 0; col < pixelMatrix[row].length; col++) {
        final pixelPaint = Paint()..color = pixelMatrix[row][col];
        final rect = Rect.fromLTWH(
          col * pixelSize.width,
          row * pixelSize.height,
          pixelSize.width,
          pixelSize.height,
        );
        canvas.drawRect(
          rect,
          pixelPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(PixelPainter oldDelegate) => true;
}
