import 'package:assignment_7/ListPage.dart';
import 'package:assignment_7/Student.dart';
import 'package:assignment_7/StudentListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentListProvider(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputNameController = TextEditingController();
  final inputNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Add Team Member"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
            },
            icon: const Icon(Icons.list))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'The number of our teams is',
            ),
            Text(
              context.watch<StudentListProvider>().studentList.length.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: (){
                showBottomSheet(context);
              },
              child: const Text("Add")
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      builder: (BuildContext context) {
        if(ctx.watch<StudentListProvider>().studentList.length < 3){
          return SizedBox(
            height: 900,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Student No. : ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: inputNumberController,
                        )),
                      const Text(
                        "Name : ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: inputNameController,
                        )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(inputNameController.text.isNotEmpty && inputNumberController.text.isNotEmpty){
                        var student = Student(name: inputNameController.text, id: inputNumberController.text);
                        ctx.read<StudentListProvider>().addStudent(student);
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    child: const Text("Add")
                  )
                ]
              ),
            )
          );
        }else{
          return const SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Text("The team is already full.")
            )
          );
        }
      },
    ).then((value){
      setState((){});
    });
  }
}