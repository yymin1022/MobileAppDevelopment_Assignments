import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Assignment 4",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Grade Calculator"),
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
  final _fExamController = TextEditingController();
  final _mExamController = TextEditingController();

  var _addPoint = 0;
  var _isAbsent = false;
  var _isLeader = false;
  var _resultScore = " ";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mid-term Exam",
                ),
                controller: _mExamController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Final Exam",
                ),
                controller: _fExamController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RadioListTile(
                groupValue: _isLeader,
                value: true,
                title: const Text("Project Team Leader (+10)"),
                onChanged: (bool? isChecked){
                  setState(() {
                    _isLeader = true;
                  });
                },
              )
            ),
            RadioListTile(
              groupValue: _isLeader,
              value: false,
              title: const Text("Project Team Member"),
              onChanged: (bool? isChecked){
                setState(() {
                  _isLeader = false;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Additional Point"),
                DropdownButton(
                  value: _addPoint,
                  items: List.generate(10, (index) => index).map((num) =>
                    DropdownMenuItem(
                      value: num,
                      child: Text("$num point"),
                    )
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _addPoint = value!;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Absence less than 4"),
                Checkbox(
                  value: _isAbsent,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAbsent = value!;
                    });
                  },
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _resultScore,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 40.0
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: const Text("Enter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange
                ),
                onPressed: () {
                  setState(() {
                    var score = double.parse(_mExamController.text.trim());
                    score += double.parse(_fExamController.text.trim());
                    score += _addPoint;
                    score += (_isLeader ? 10 : 0);

                    setState(() {
                      if(_isAbsent || score < 110) {
                        _resultScore = "F";
                      } else if(score >= 170) {
                        _resultScore = "A";
                      } else if(score >= 150) {
                        _resultScore = "B";
                      } else if(score >= 130) {
                        _resultScore = "C";
                      } else {
                        _resultScore = "D";
                      }
                    });
                  });
                },
              )
            ),
          ],
        ),
      )
    );
  }
}