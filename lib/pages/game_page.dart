import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GamePage extends StatefulWidget {
  final ListaDeAdjacencia<Color> listaDeAdjacencia;

  const GamePage({
    super.key,
    required this.listaDeAdjacencia,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late RiveAnimation personagem;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: personagemPositionController,
      builder: (context, snapshot, child) {
        return Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    personagemPositionController.colorMatriz.length, // Column
              ),
              itemCount: personagemPositionController.colorMatriz.length *
                  personagemPositionController.colorMatriz.length, // row
              itemBuilder: (BuildContext context, int index) {
                final row =
                    index ~/ personagemPositionController.colorMatriz[0].length;
                final col =
                    index % personagemPositionController.colorMatriz[0].length;

                if (personagemPositionController.colorMatriz[row][col] ==
                    Colors.red) {
                  return const RiveAnimation.asset(
                    'assets/personagem_2.riv',
                    animations: [
                      "Walk sem livro",
                    ],
                  );
                }
                return Container(
                  color: personagemPositionController.colorMatriz[row][col],
                );
              },
            ),
            CustomButtom(
              backGroundColor: Colors.orange,
              title: "Toda BFS",
              left: MediaQuery.of(context).size.height / 20,
              bottom: MediaQuery.of(context).size.height / 20,
              onPressed: () async {
                await personagemPositionController.rodaAllBFS();
                personagemPositionController.comecaAandar(Colors.orange);
              },
            ),
            CustomButtom(
              backGroundColor: Colors.purple,
              title: "Resolver DFS",
              right: MediaQuery.of(context).size.height / 20,
              bottom: MediaQuery.of(context).size.height / 20,
              onPressed: () async {
                await personagemPositionController.rodaDFS();
                personagemPositionController.comecaAandar(Colors.purple);
              },
            ),
            CustomButtom(
              backGroundColor: Colors.green,
              title: "Caminho BFS",
              bottom: MediaQuery.of(context).size.height / 10,
              left: MediaQuery.of(context).size.width / 3,
              right: MediaQuery.of(context).size.width / 3,
              onPressed: () async {
                await personagemPositionController.rodaBFSpath();
                personagemPositionController.comecaAandar(Colors.green);
              },
            ),
          ],
        );
      },
    );
  }
}

class CustomButtom extends StatelessWidget {
  final double? left;
  final double? right;
  final double? bottom;
  final void Function()? onPressed;
  final String title;

  final Color backGroundColor;
  const CustomButtom({
    this.bottom,
    this.left,
    this.right,
    this.onPressed,
    required this.title,
    super.key,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 40,
      left: left,
      right: right,
      bottom: bottom,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backGroundColor)),
        onPressed: onPressed,
        child: SizedBox(
          height: 40,
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.play_arrow_sharp),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
