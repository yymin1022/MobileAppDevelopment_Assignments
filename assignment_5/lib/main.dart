import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grade Calculator",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();

  final List<Student> _studentArr = [];
  int _addPoint = -1;
  int _point = 0;
  String _name = "";

  final _nameInputController = TextEditingController();
  final _pointInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Grade Calculator"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Information"),
              Tab(text: "List")
            ]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameInputController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name"),
                          onSaved: (name) => _name = name!,
                          validator: (String? name) {
                            if(name == null || name.isEmpty || name.contains(RegExp(r"\d"))){
                              return "Please enter some string, not a number.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _pointInputController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Project Point"),
                          onSaved: (point) => _point = int.parse(point!),
                          validator: (String? point) {
                            if(point == null || point.isEmpty || point.contains(RegExp(r"\D"))){
                              return "Please enter some integer.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Choose the additional point"),
                          items: List.generate(11, (idx) {
                              if(idx == 0){
                                return DropdownMenuItem(
                                  value: idx - 1,
                                  child: const Text("Choose the additional point"),
                                );
                              }
                              return DropdownMenuItem(
                                value: idx - 1,
                                child: Text("${idx - 1} point")
                              );
                            }
                          ),
                          onChanged: (val){
                            setState(() {
                              _addPoint = val!;
                            });
                          },
                          validator: (int? addPoint) {
                            if(_addPoint == -1){
                              return "Please select the point.";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    child: Container(
                      color: Colors.blue,
                      height: 75,
                      width: double.infinity,
                      child: const Center(child: Text("Enter")),
                    ),
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          _formKey.currentState!.save();
                          _studentArr.add(Student(_name, _point + _addPoint));
                        });
                      }
                    },
                  )
                ]
              ),
            ),
            ReorderableListView.builder(
              itemCount: _studentArr.length,
              itemBuilder: (_, idx) {
                return Dismissible(
                  key: ValueKey(_studentArr[idx]),
                  child: ListTile(
                      leading: const Icon(Icons.home),
                      title: Text("${_studentArr[idx].name}: ${_studentArr[idx].point}")
                  ),
                  onDismissed: (_){
                    setState(() {
                      _studentArr.removeAt(idx);
                    });
                  },
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if(oldIndex < newIndex) {
                    newIndex--;
                  }
                  var tmp = _studentArr[oldIndex];
                  _studentArr[oldIndex] = _studentArr[newIndex];
                  _studentArr[newIndex] = tmp;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class Student{
  String name;
  int point;
  Student(var this.name, var this.point);
}