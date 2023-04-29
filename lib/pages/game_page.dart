import 'dart:math';
import 'package:app/components/pixel_painter.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final List<List<Color>> cenarioMatrix;

  const GamePage({
    super.key,
    required this.cenarioMatrix,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final column = Random().nextInt(5);
        final row = Random().nextInt(5);
        setState(() {
          widget.cenarioMatrix[row][column] = Colors.blue;
        });
      },
      child: /*  Stack(
        children: [ */
          CustomPaint(
        painter: PixelPainter(widget.cenarioMatrix),
      ),

      //!Not working
      /* const RiveAnimation.asset('assets/personagem_2.riv', animations: [
            "Walk sem livro",
          ]), 
        ],
      ),*/
    );
  }
}
