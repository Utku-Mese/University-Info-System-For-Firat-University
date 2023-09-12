import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_uni/controllers/student_controller.dart';
import 'package:my_uni/models/student_model.dart';
import 'package:my_uni/views/screens/student/student_info_screen.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final StudentController _studentController = StudentController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: _studentController.fetchStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Could not retrieve data: ${snapshot.error}');
        } else {
          final students = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _studentController.fetchStudents();
              });
            },
            child: ListView.builder(
              itemCount: students?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return StudentInfoScreen(student: students[index]);
                      },
                    ));
                  },
                  title: Text(
                      " ${students?[index].name}  ${students?[index].surname}"),
                  subtitle: Text(students![index].department.toString()),
                  leading: CircleAvatar(
                    child: students[index].imageUrl == null
                        ? Text(students[index].name![0])
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
                                        imageUrl: students[index].imageUrl!,
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
                                imageUrl: students[index].imageUrl!,
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
