import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_details/edit_screen.dart';
import 'package:student_details/models/data_model.dart';

// ignore: must_be_immutable
class ViewScreen extends StatelessWidget {
  StudentModel data;
  int? index;

  final _name = TextEditingController();
  final _age = TextEditingController();
  final _place = TextEditingController();
  final _phone = TextEditingController();
  ViewScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _name.text = data.name.toString();
    _age.text = data.age.toString();
    _place.text = data.place.toString();
    _phone.text = data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('View'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                              data: data,
                              index: index,
                            )));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage:
                    MemoryImage(const Base64Decoder().convert(data.image)),
                radius: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
               enabled: false,
              controller: _name,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
              controller: _age,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
              controller: _place,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
              controller: _phone,
              readOnly: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}