import 'package:assignment_7/Student.dart';
import 'package:flutter/material.dart';

class StudentListProvider extends ChangeNotifier {
  final List<Student> studentList = [];

  void addStudent(Student s){
    studentList.add(s);
    notifyListeners();
  }

  void removeStudent(int idx){
    studentList.removeAt(idx);
    notifyListeners();
  }
}