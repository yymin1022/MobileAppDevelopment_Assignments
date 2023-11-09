import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BasePage(),
        '/coffeagain': (context) => const CoffeeAgainPage(),
        '/juice': (context) => const JuicePage(),
        '/measure': (context) => const MeasurePage(),
        '/milk': (context) => const MilkPage(),
        '/sweet': (context) => const SweetPage(),
        '/result': (context) => const ResultPage()
      },
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Choose Beverage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("I want to help you choose the beverage.", style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            const Text("Let's Start!", style: TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed((context), '/measure');
              },
              child: const Text("Go")
            )
          ],
        )
      )
    );
  }
}

class CoffeeAgainPage extends StatefulWidget {
  const CoffeeAgainPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoffeeAgainPageState();
}

class _CoffeeAgainPageState extends State<CoffeeAgainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("Coffee Again")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Do you want some more coffee?", style: TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/sweet');
                    },
                    child: const Text("Yes")
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/result', arguments: "Sweet Potato Latte");
                    },
                    child: const Text("No")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class JuicePage extends StatefulWidget {
  const JuicePage({super.key});

  @override
  State<StatefulWidget> createState() => _JuicePageState();
}

class _JuicePageState extends State<JuicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Juice or Latte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Since you drank 2 cup of coffee,\nyou may not want coffee.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            const Text("Do you want juice or latte?", style: TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/result', arguments: "Grapefruit Juice");
                    },
                    child: const Text("Juice")
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/coffeagain');
                    },
                    child: const Text("Latte")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MeasurePage extends StatefulWidget {
  const MeasurePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeasurePageState();
}

class _MeasurePageState extends State<MeasurePage> {
  int _coffee = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Measure your coffee"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("How many cups of coffee did you drink?", style: TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20.0),
          Text("$_coffee cups", style: const TextStyle(fontSize: 30.0)),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    _coffee--;
                  });
                },
                child: const Text("-")
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    _coffee++;
                  });
                },
                child: const Text("+")
              )
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              if(_coffee <= 1){
                Navigator.pushNamed(context, '/milk', arguments: _coffee.toString());
              }else{
                Navigator.pushNamed(context, '/juice');
              }
            },
            child: const Text("Next")
          )
        ],
      ),
    );
  }
}

class MilkPage extends StatefulWidget {
  const MilkPage({super.key});

  @override
  State<StatefulWidget> createState() => _MilkPageState();
}

class _MilkPageState extends State<MilkPage> {
  @override
  Widget build(BuildContext context) {
    final coffee = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Milk")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Since you drank $coffee cup of coffee,\nyou may want coffee.", textAlign: TextAlign.center, style: const TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            const Text("Do you want milk in the coffee?", style: TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/sweet');
                  },
                  child: const Text("Yes")
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/result', arguments: "Americano");
                  },
                  child: const Text("No")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SweetPage extends StatefulWidget {
  const SweetPage({super.key});

  @override
  State<StatefulWidget> createState() => _SweetPageState();
}

class _SweetPageState extends State<SweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Sweet Coffee"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Do you want sweet coffee?", style: TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/result', arguments: "Mocha Latte");
                  },
                  child: const Text("Yes")
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/result', arguments: "Caffe Latte");
                  },
                  child: const Text("No")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your best beverage is", style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            Text(result, style: const TextStyle(fontSize: 30.0)),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}