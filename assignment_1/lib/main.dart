import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Soccer Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _scoreTeamA = 0;
  int _scoreTeamB = 0;
  int _setScoreDraw = 0;
  int _setScoreTeamA = 0;
  int _setScoreTeamB = 0;

  void _gameOver() {
    setState(() {
      if(_scoreTeamA > _scoreTeamB){
        _setScoreTeamA++;
      }else if(_scoreTeamA < _scoreTeamB){
        _setScoreTeamB++;
      }else{
        _setScoreDraw++;
      }
      _scoreTeamA = _scoreTeamB = 0;
    });
  }

  void _goalTeamA() {
    setState(() {
      _scoreTeamA++;
    });
  }

  void _goalTeamB() {
    setState(() {
      _scoreTeamB++;
    });
  }

  void _resetAll() {
    setState(() {
      _scoreTeamA = 0;
      _scoreTeamB = 0;
      _setScoreDraw = 0;
      _setScoreTeamA = 0;
      _setScoreTeamB = 0;
    });
  }

  void _resetGame() {
    setState(() {
      _scoreTeamA = 0;
      _scoreTeamB = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child:
                const Image(
                  image: AssetImage('assets/soccer.png'),
                  width: 150.0
                )
            ),
            ElevatedButton(onPressed: _resetGame, child: const Text('Reset Game')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                      'Your Team'
                    ),
                    Text(
                      style: const TextStyle(
                        fontSize: 40.0
                      ),
                      _scoreTeamA.toString()
                    ),
                    ElevatedButton(onPressed: _goalTeamA, child: const Text('Goal'))
                  ],
                ),
                const Text(
                  style: TextStyle(
                    fontSize: 40.0
                  ),
                  ':'
                ),
                Column(
                  children: [
                    const Text(
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                      'Your Rival'
                    ),
                    Text(
                      style: const TextStyle(
                          fontSize: 40.0
                      ),
                        _scoreTeamB.toString()
                    ),
                    ElevatedButton(onPressed: _goalTeamB, child: const Text('Goal'))
                  ],
                )
              ],
            ),
            ElevatedButton(onPressed: _gameOver, child: const Text('Game Over')),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: const Text(
                style: TextStyle(
                  fontSize: 30.0
                ),
                  'Set Score'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                  'Win: $_setScoreTeamA'
                ),
                Text(
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                  'Draw: $_setScoreDraw'
                ),
                Text(
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                  'Lose: $_setScoreTeamB'
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetAll,
        tooltip: 'Reset All',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
