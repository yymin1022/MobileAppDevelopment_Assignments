import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Assignment 3'),
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.image)),
              Tab(icon: Icon(Icons.how_to_vote)),
              Tab(icon: Icon(Icons.upload))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: "album"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings")
          ],
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ),
              itemBuilder: (BuildContext context, int index) {
                return Image(image: AssetImage(getDogPictures()[index]));
              }
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Candidate",
                    style: TextStyle(fontSize: 20.0)
                  )
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Card(
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Dog1",
                              style: TextStyle(color: Colors.red),
                            )
                          )
                        )
                      )
                    ),
                    Flexible(
                      flex: 1,
                      child: Card(
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Dog2",
                              style: TextStyle(color: Colors.blue),
                            )
                          )
                        )
                      )
                    ),
                    Flexible(
                      flex: 1,
                      child: Card(
                        child: SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Dog3",
                              style: TextStyle(color: Colors.green),
                            )
                          )
                        )
                      )
                    ),
                  ]
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Vote rate",
                    style: TextStyle(fontSize: 20.0)
                  )
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 100.0,
                        color: Colors.red,
                        child: Center(child: Text("50%"))
                      )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 100.0,
                            color: Colors.blue,
                            child: Center(child: Text("20%"))
                        )
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                            height: 100.0,
                            color: Colors.green,
                            child: Center(child: Text("20%"))
                        )
                    ),
                  ],
                )
              ],
            ),
            const Center(
              child: LinearProgressIndicator(),
            )
          ],
        )
      ),
    );
  }
}

List<String> getDogPictures() {
  List<String> dogPics = [];
  
  for(var i = 1; i <= 16; i++){
    dogPics.add("assets/dog_$i.jpeg");
  }
  
  return dogPics;
}