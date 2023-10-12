import 'package:flutter/material.dart';
import 'package:assignment_2/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Assignment 2'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.CustomGreen,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          )
        ],
      ),
      drawer: const Drawer(
        child: Center(child: Text('20194094 Yongmin Yoo')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: const Image(
                        image: AssetImage('assets/warning.jpeg'),
                      )
                    )
                  )
                ),
                const Center(
                  child: Text('This page does not include contents')
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0, bottom: 5.0),
                                child: Icon(Icons.home)
                              ),
                              Text('Home')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.navigate_next)
                          ),
                        ],
                      )
                    )
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0, bottom: 5.0),
                                child: Icon(Icons.search)
                              ),
                              Text('Error Search')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.navigate_next)
                          ),
                        ],
                      )
                    )
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0, bottom: 5.0),
                                child: Icon(Icons.refresh)
                              ),
                              Text('Refresh')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.navigate_next)
                          ),
                        ],
                      )
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
