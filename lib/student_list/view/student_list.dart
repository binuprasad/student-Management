import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_details/DB/functions/db_functions.dart';
import 'package:student_details/models/data_model.dart';
import 'package:student_details/student_list/cubit/event/student_list_cubit.dart';
import 'package:student_details/student_list/cubit/state/student_list_state.dart';
import 'package:student_details/view_screen.dart';


ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class StudentList extends StatelessWidget {
   const StudentList({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<StudentListCubit, StudentListState>(
      builder: (context, state) {
        if(state is LoadedState){
          return ListView.separated(
              itemBuilder: (context, index) {
                final data = state.studentList[index];
                return ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      context.read<StudentListCubit>().deleteStudentData(index);
                    },
                    icon: const Icon(Icons.delete,color: Colors.red,),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewScreen(data: data, index: index)));
                  },
                  leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                      radius: 30),
                  title: Text(data.name),
                  subtitle: Text(data.age),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.studentList.length);
        }
        else if(state is LoadingState ){
          return const Center(child:  CircularProgressIndicator());
        }else if(state is EmptyState){
          return const Center(child: Text('Add Students'),);
          
        }else{
          return TextButton(onPressed: (){
            context.read<StudentListCubit>().fetchData();
          }, child:const Text('Refresh'));
        }
      },
    );
  }
}