import 'package:equatable/equatable.dart';
import 'package:student_details/models/data_model.dart';

abstract class StudentListState extends Equatable {}

class InitialState extends StudentListState {
  @override
  List<Object> get props => [];
}

class ErrorState extends StudentListState {
  @override
  List<Object> get props => [];
}

class LoadingState extends StudentListState {
  @override
  List<Object> get props => [];
}

class EmptyState extends StudentListState {
  @override
  List<Object> get props => [];
}

class LoadedState extends StudentListState {
  final List<StudentModel> studentList;

  LoadedState(this.studentList);
  @override
  List<Object> get props => [studentList];
}
