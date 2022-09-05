

import 'package:flutter/material.dart';
import 'package:student_details/models/data_model.dart';
import 'package:student_details/view_screen.dart';
import 'package:student_details/student_list/view/student_list.dart';
class SearchProfile extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentData,
            Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentData[index];
              if (query == data.name.toLowerCase() ||
                  query == data.name.toUpperCase()) {
                return ListTile(
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          (MaterialPageRoute(builder: (ctx) {
                            return ViewScreen(data: data, index: index);
                          })),
                          (route) => false);
                    },
                    title: Text(data.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        )));
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (context, value) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
            itemCount: studentData.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentData,
            Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentData[index];
              if (data.name.toLowerCase().contains(query) ||
                  data.name.toUpperCase().contains(query)) {
                return ListTile(
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        (MaterialPageRoute(builder: (ctx) {
                          return ViewScreen(data: data, index: index);
                        })),
                      );
                    },
                    title: Text(data.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        )));
              } else {
                return Container();
              }
            },
            separatorBuilder: (context, value) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
            itemCount: studentData.length,
          );
        });
  }
}