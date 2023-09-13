import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_uni/controllers/instructor_controller.dart';
import 'package:my_uni/models/instructor_model.dart';
import 'package:my_uni/views/screens/instructor/instructor_info_screen.dart';

class InstructorsScreen extends StatefulWidget {
  const InstructorsScreen({super.key});

  @override
  State<InstructorsScreen> createState() => _InstructorsScreenState();
}

class _InstructorsScreenState extends State<InstructorsScreen> {
  final InstructorController _instructorController = InstructorController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Instructor>>(
      future: _instructorController.fetchInstructors(),
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
                _instructorController.fetchInstructors();
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
                        "${instructors?[index].degree ?? ""} ${instructors?[index].name} ${instructors?[index].surname}"),
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
