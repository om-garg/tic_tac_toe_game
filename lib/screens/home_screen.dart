import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/game_data.dart';
import 'package:tic_tac_toe_game/widgets/custom_dailog_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          'TIC TAC TOE',
          style: myNewFontWhite,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomDialogBox(
                      title: "Rules",
                      descriptions:
                          "1. The game is played on a grid that's 3 squares by 3 squares. \n 2. You are O, your friend (or the computer in this case) is X. Players take turns putting their marks in empty squares. \n 3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner. \n 4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.",
                      text: "Ok",
                      img: 'assets/tictactoelogo.png',
                    );
                  });
            },
            icon: const Icon(
              Icons.help,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            context.read<GameData>().clearData();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Player O',
                        style: myNewFontWhite,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<GameData>(
                        builder: (context, value, child) {
                          return Text(
                            value.ohScore.toString(),
                            style: myNewFontWhite,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Player X',
                        style: myNewFontWhite,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<GameData>(
                        builder: (context, value, child) {
                          return Text(
                            value.exScore.toString(),
                            style: myNewFontWhite,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Text(
                  'Your symbol is O',
                  style: myNewFontWhite,
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                    itemCount: 9,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer<GameData>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              value.tapped(index, context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[700]!)),
                              child: Center(
                                child: Text(
                                  value.displayExOh[index],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(30, 50)),
                      ),
                      onPressed: () {
                        context.read<GameData>().clearBoard();
                      },
                      icon: Icon(
                        Icons.refresh_outlined,
                        color: Colors.grey[900],
                        size: 30,
                      ),
                      label: Text(
                        'Refresh',
                        style: myNewFont,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
