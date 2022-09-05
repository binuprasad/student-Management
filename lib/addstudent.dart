import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details/home_screen.dart';
import 'package:student_details/models/data_model.dart';
import 'package:student_details/student_list/cubit/event/student_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formkey = GlobalKey<FormState>();

  final _username = TextEditingController();

  final _age = TextEditingController();

  final _place = TextEditingController();

  final  _phone = TextEditingController();

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add student'),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: (() {
                      pickImage();
                    }),
                    child: imageProfile()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Username';
                    } else {
                      return null;
                    }
                  },
                  controller: _username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.red,
                  validator: (value) {
                    
                    if (value == null || value.isEmpty || value.length != 2) {
                      return 'Invalid age';
                    } else {
                      return null;
                    }
                  },
                  controller: _age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Place Name';
                    } else {
                      return null;
                    }
                  },
                  controller: _place,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'place'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Invalid Phone Number';
                    } else {
                      return null;
                    }
                  },
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        checkValidation(context);
                      }
                    },
                    child: const Text('Submit')),
              )
            ],
          )),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: MemoryImage(const Base64Decoder().convert(_image)),
          ),
          const Positioned(
            bottom: 40,
            right: 40,
            child: Icon(
              Icons.add_a_photo,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  String _image = '';
  String imageToString = '';

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();

      setState(
        () {
          imageToString = base64Encode(imageTemporary);
          _image = imageToString;
        },
      );
    }
  }

  checkValidation(BuildContext context) {
    final name = _username.text.trim();
    final age = _age.text.trim();
    final place = _place.text.trim();
    final phone = _phone.text.trim();

    final student = StudentModel(
        age: age,
        name: name,
        place: place,
        phone: phone,
        image: imageToString);

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        phone.isEmpty ||
        imageToString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('All Field Required')));
    } else {
      context.read<StudentListCubit>().addStudentData(student);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    }
  }
}