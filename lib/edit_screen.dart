import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details/DB/functions/db_functions.dart';
import 'package:student_details/home_screen.dart';
import 'package:student_details/models/data_model.dart';
import 'package:student_details/student_list/cubit/event/student_list_cubit.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  StudentModel data;
  int? index;
  EditPage({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formkey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _age = TextEditingController();

  final  _place = TextEditingController();

  final _phone = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _name.text = widget.data.name.toString();
    _age.text = widget.data.age.toString();
    _place.text = widget.data.place.toString();
    _phone.text = widget.data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit student'),
      ),
      body: Form(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  backgroundImage: MemoryImage(
                      const Base64Decoder().convert(widget.data.image)),
                  radius: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: Colors.red,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invald Username';
                } else {
                  return null;
                }
              },
              controller: _name,
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
                if (value == null || value.isEmpty) {
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
                  return 'Invalid place';
                } else {
                  return null;
                }
              },
              controller: _place,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Place'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: Colors.red,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid Phone';
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
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  checkValidation(context,widget.index!,widget.data);
                  formkey.currentState?.validate();
                },
                child: const Text('SAVE')),
          )
        ],
      )),
    );
  }

  String? _image;

  String? imageToString;

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
    }

    setState(() {
      _image = imageToString;
    });
  }

  checkValidation(BuildContext context ,int index,StudentModel data) {
    final name = _name.text.trim();
    final age = _age.text.trim();
    final place = _place.text.trim();
    final phone = _phone.text.trim();
    final student = StudentModel(
        age: age, name: name, place:place , phone: phone, image: _image ?? data.image);

    if (name.isEmpty || age.isEmpty || place.isEmpty || phone.isEmpty) {
      return;
    } else {
      context.read<StudentListCubit>().updateStudentData(student, index);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      getAllStudents();
    }
  }
}