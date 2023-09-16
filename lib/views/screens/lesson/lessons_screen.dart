import 'package:flutter/material.dart';
import '../../../controllers/lesson_controller.dart';
import '../../../models/lesson_model.dart';
import '../../widgets/my_dialog_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  final LessonController _lessonController = LessonController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Lesson>>(
      future: _lessonController.fetchLessons(),
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
                _lessonController.fetchLessons();
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
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            //0dialog.show();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text(
                                      'You want to delete this lesson?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        print("lesson siliniyor...");
                                        int? lessonIdToDelete =
                                            lessons![index].id;

                                        try {
                                          await _lessonController
                                              .deleteLesson(lessonIdToDelete!);
                                        } catch (e) {
                                          debugPrint('Hata: $e');
                                        }

                                        setState(() {
                                          Navigator.of(context).pop();
                                          _lessonController.fetchLessons();
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            const CustomSnackBar.success(
                                              message:
                                                  "Lesson deleted successfully!",
                                            ),
                                          );
                                        });
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_forever,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 3.0,
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
                  ),
                );
              },
              padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
            ),
          );
        }
      },
    );
  }
}
