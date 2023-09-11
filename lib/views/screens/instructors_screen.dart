import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_uni/models/instructor_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_uni/views/screens/instructor_info_screen.dart';

class InstructorsScreen extends StatefulWidget {
  const InstructorsScreen({super.key});

  @override
  State<InstructorsScreen> createState() => _InstructorsScreenState();
}

class _InstructorsScreenState extends State<InstructorsScreen> {
  List<Instructor> parseInstructors(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Instructor>((json) => Instructor.fromJson(json)).toList();
  }

  Future<List<Instructor>> fetchInstructors() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/instructors'));

    if (response.statusCode == 200) {
      //return parseInstructors(response.body);
      final instructors = parseInstructors(response.body);
      // isActive değeri 1 olan öğretim görevlilerini filtreler
      final activeInstructors =
          instructors.where((instructor) => instructor.isActive == 1).toList();
      return activeInstructors;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Instructor>>(
      future: fetchInstructors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Could not retrieve data: ${snapshot.error}');
        } else {
          final instructors = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                fetchInstructors();
              });
            },
            child: ListView.builder(
              itemCount: instructors?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return InstructorsInfoScreen(
                          instructor: instructors[index],
                        );
                      },
                    ));
                  },
                  title: Flexible(
                    child: Text(
                        "${instructors?[index].degree ?? ""} ${instructors?[index].name}  ${instructors?[index].surname}"),
                  ),
                  subtitle: Text(instructors![index].department.toString()),
                  leading: CircleAvatar(
                    child: instructors[index].imageUrl == null
                        ? Text(instructors[index].name![0])
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl: instructors[index].imageUrl!,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: instructors[index].imageUrl!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
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
