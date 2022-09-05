
import 'package:flutter/material.dart';
import 'package:student_details/DB/functions/db_functions.dart';
import 'package:student_details/addstudent.dart';
import 'package:student_details/search.dart';
import 'package:student_details/student_list/view/student_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
    
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProfile(),
              );
            },
            icon: const Icon(Icons.search,color: Color.fromARGB(255, 245, 221, 8),),
          )
        ],
      ),
      body:   const StudentList(),
        floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudent(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}