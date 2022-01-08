import 'dart:math';

import 'package:flutter/material.dart';

class GameData with ChangeNotifier {
  List<String> _displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<String> get displayExOh => _displayExOh;

  bool _ohTurn = true; // the first player is O!
  bool get ohTurn => _ohTurn;

  int _ohScore = 0;
  int get ohScore => _ohScore;

  int _exScore = 0;
  int get exScore => _exScore;

  int _filledBoxes = 0;
  int get filledBoxes => _filledBoxes;
  void increaseFilledBoxes() {
    _filledBoxes += 1;
    notifyListeners();
  }

  void tapped(int index, BuildContext context) {
    int flag = 0;

    if (_ohTurn && _displayExOh[index] == '') {
      _displayExOh[index] = 'o';
      _filledBoxes += 1;
    }
    flag = _checkWinner(context);
    _ohTurn = !_ohTurn;
    if (flag != 1) {
      if (!_ohTurn && _filledBoxes != 9) {
        var random = Random();
        int i;
        while (true) {
          i = random.nextInt(8);
          if (_displayExOh[i] == '' && i != index) {
            break;
          }
        }
        _displayExOh[i] = 'x';
        _filledBoxes += 1;
        _checkWinner(context);
      }
    }
    _ohTurn = !_ohTurn;
    notifyListeners();
  }

  int _checkWinner(BuildContext context) {
    // checks 1st row
    if (_displayExOh[0] == _displayExOh[1] &&
        _displayExOh[0] == _displayExOh[2] &&
        _displayExOh[0] != '') {
      _showWinDialog(_displayExOh[0], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks 2nd row
    if (_displayExOh[3] == _displayExOh[4] &&
        _displayExOh[3] == _displayExOh[5] &&
        _displayExOh[3] != '') {
      _showWinDialog(_displayExOh[3], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks 3rd row
    if (_displayExOh[6] == _displayExOh[7] &&
        _displayExOh[6] == _displayExOh[8] &&
        _displayExOh[6] != '') {
      _showWinDialog(_displayExOh[6], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks 1st column
    if (_displayExOh[0] == _displayExOh[3] &&
        _displayExOh[0] == _displayExOh[6] &&
        _displayExOh[0] != '') {
      _showWinDialog(_displayExOh[0], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks 2nd column
    if (_displayExOh[1] == _displayExOh[4] &&
        _displayExOh[1] == _displayExOh[7] &&
        _displayExOh[1] != '') {
      _showWinDialog(_displayExOh[1], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks 3rd column
    if (_displayExOh[2] == _displayExOh[5] &&
        _displayExOh[2] == _displayExOh[8] &&
        _displayExOh[2] != '') {
      _showWinDialog(_displayExOh[2], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks diagonal
    if (_displayExOh[6] == _displayExOh[4] &&
        _displayExOh[6] == _displayExOh[2] &&
        _displayExOh[6] != '') {
      _showWinDialog(_displayExOh[6], context);
      _filledBoxes = 0;
      return 1;
    }

    // checks diagonal
    if (_displayExOh[0] == _displayExOh[4] &&
        _displayExOh[0] == _displayExOh[8] &&
        _displayExOh[0] != '') {
      _showWinDialog(_displayExOh[0], context);
      _filledBoxes = 0;
      return 1;
    } else if (_filledBoxes == 9) {
      _showDrawDialog(context);
      return 1;
    } else {
      return 0;
    }
  }

  void _showDrawDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('DRAW'),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Play Again!',
                  style: TextStyle(fontSize: 18, color: Color(0xff6A0000)),
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS: ' + winner),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Play Again!',
                  style: TextStyle(fontSize: 18, color: Color(0xff6A0000)),
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'o') {
      _ohScore += 1;
    } else if (winner == 'x') {
      _exScore += 1;
    }
    notifyListeners();
  }

  void clearBoard() {
    for (int i = 0; i < 9; i++) {
      _displayExOh[i] = '';
    }
    _filledBoxes = 0;
    notifyListeners();
  }

  void clearData() {
    clearBoard();
    _ohTurn = true;
    _ohScore = 0;
    _exScore = 0;
    _filledBoxes = 0;
    notifyListeners();
  }
}
