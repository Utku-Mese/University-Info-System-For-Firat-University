import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_uni/models/lesson_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_uni/views/widgets/my_dialog_widget.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  List<Lesson> parseLessons(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Lesson>((json) => Lesson.fromJson(json)).toList();
  }

  Future<List<Lesson>> fetchLessons() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/lessons'));

    if (response.statusCode == 200) {
      return parseLessons(response.body);
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Lesson>>(
      future: fetchLessons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Could not retrieve data: ${snapshot.error}');
        } else {
          final lessons = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchLessons();
              });
            },
            child: ListView.builder(
              itemCount: lessons?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    MyDilog.showMyDialog(
                      context: context,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${lessons?[index].shortName} - ${lessons?[index].name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                lessons?[index].descriptions ??
                                    'No description',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "${lessons?[index].shortName} - ${lessons?[index].name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instructor: ${lessons?[index].instructor}'),
                          Text('Department: ${lessons?[index].department}'),
                          Text('Grade: ${lessons?[index].grade}'),
                          Text('Credit: ${lessons?[index].credit}'),
                          Text(
                              'Obligation: ${lessons?[index].obligation == 1 ? 'Obligatory' : 'Elective'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.only(bottom: 20.0),
            ),
          );
        }
      },
    );
  }
}
