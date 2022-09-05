import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_details/DB/functions/db_functions.dart';
import 'package:student_details/models/data_model.dart';
import 'package:student_details/student_list/cubit/state/student_list_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  StudentListCubit() : super(InitialState()) {
    fetchData();
  }
  void fetchData() async {
    emit(LoadingState());
    final response = await getAllStudents();
    if (response.isEmpty) {
      emit(EmptyState());
    } else if (response.isNotEmpty) {
      emit(LoadedState(response));
    } else {
      emit(ErrorState());
    }
  }

  void deleteStudentData(int index) {
    deleteStudent(index).then((value) {
      if (value == true) {
        fetchData();
      }
    });
  }

  void addStudentData(StudentModel studentModel) {
    addStudent(studentModel).then((value) {
      if (value == true) {
        fetchData();
      }
    });
  }

  void updateStudentData(StudentModel studentModel, int index) {
    updateDetails(data: studentModel, index: index).then((value) {
      if (value == true) {
        fetchData();
      }
    });
  }
}
