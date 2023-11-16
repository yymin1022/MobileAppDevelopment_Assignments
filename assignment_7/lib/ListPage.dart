import 'package:assignment_7/StudentListProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Team Member List"),
      ),
      body: ListView.builder(
        itemCount: context.watch<StudentListProvider>().studentList.length,
        itemBuilder: (_, idx) {
          return Dismissible(
            key: UniqueKey(),
            child: ListTile(
              title: Text("${context.watch<StudentListProvider>().studentList[idx].name} (${context.watch<StudentListProvider>().studentList[idx].id})"),
            ),
            onDismissed: (_) => {
              context.read<StudentListProvider>().removeStudent(idx)
            },
          );
        }
      )
    );
  }
}