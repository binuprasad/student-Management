import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_details/models/data_model.dart';


Future<bool> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
  return true;
}

Future<List<StudentModel>> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  return studentDB.values.toList();
}

Future<bool> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  return true;
}

Future<bool> updateDetails({required data, required index}) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.putAt(index, data);
  return true;
}
