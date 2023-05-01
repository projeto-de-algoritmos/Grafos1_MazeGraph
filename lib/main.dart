import 'package:app/components/matriz.dart';
import 'package:app/controller/personage_controller.dart';
import 'package:app/data_structures/lista_de_adjacencia.dart';
import 'package:app/utils/routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

late GameController personagemPositionController;

late Tuple2<ListaDeAdjacencia<Color>, List<List<Color>>> matrizes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  matrizes = criarMatrizDeAdjacenciaEDecolor(
    30,
    30,
    Colors.black,
    const Tuple2(1, 1),
    const Tuple2(28, 28),
  );
  personagemPositionController =
      GameController(initialCharposition, matrizes.value2);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorSchemeSeed: Colors.black,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
    );
  }
}
