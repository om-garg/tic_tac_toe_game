import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/game_data.dart';
import 'package:tic_tac_toe_game/screens/intro_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => GameData(),
        builder: (context, child) => const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: IntroScreen(),
            ));
  }
}
