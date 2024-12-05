// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool P1 = true;
  List var01 = ['', '', '', '', '', '', '', '', ''];
  int Oscore = 0;
  int Xscore = 0;
  int filledbox = 0;

  void _tapped(int index) {
    setState(() {
      if (var01[index] == '') {
        var01[index] = P1 ? 'o' : 'x'; // Set 'o' if P1 is true, otherwise 'x'
        filledbox++;
        P1 = !P1; // Toggle between players
        _checkwinner();
      }
    });
  }

  void _showdialgo(String Winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER! is ' + Winner),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearboard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!'))
            ],
          );
        });

    if (Winner == 'o') {
      Oscore += 1;
    } else if (Winner == 'x') {
      Xscore += 1;
    }
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        var01[i] = '';
      }
    });
    filledbox = 0;
  }

  void _checkwinner() {
    if (var01[0] == var01[1] && var01[0] == var01[2] && var01[0] != '') {
      _showdialgo(var01[0]);
    }
    if (var01[3] == var01[4] && var01[3] == var01[5] && var01[3] != '') {
      _showdialgo(var01[3]);
    }
    if (var01[6] == var01[7] && var01[6] == var01[8] && var01[6] != '') {
      _showdialgo(var01[6]);
    }
    if (var01[0] == var01[3] && var01[0] == var01[6] && var01[0] != '') {
      _showdialgo(var01[0]);
    }
    if (var01[1] == var01[4] && var01[1] == var01[7] && var01[1] != '') {
      _showdialgo(var01[1]);
    }
    if (var01[2] == var01[5] && var01[2] == var01[8] && var01[2] != '') {
      _showdialgo(var01[2]);
    }
    if (var01[6] == var01[4] && var01[6] == var01[2] && var01[6] != '') {
      _showdialgo(var01[6]);
    }
    if (var01[0] == var01[4] && var01[0] == var01[8] && var01[0] != '') {
      _showdialgo(var01[0]);
    } else if (filledbox == 9) {
      _showdrawdialgo();
    }
  }

  void _showdrawdialgo() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearboard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!'))
            ],
          );
        });
  }

  var mystyle = TextStyle(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: Container(
                  child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PLAYER 1',
                        style: mystyle,
                      ),
                      Text(
                        Oscore.toString(),
                        style: mystyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PLAYER 2', style: mystyle),
                      Text(
                        Xscore.toString(),
                        style: mystyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          var01[index],
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
