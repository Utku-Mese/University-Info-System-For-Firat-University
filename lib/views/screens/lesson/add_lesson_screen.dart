import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_uni/controllers/lesson_controller.dart';
import 'package:my_uni/models/lesson_model.dart';
import 'package:my_uni/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({super.key});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shortNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instructorController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  final LessonController _lessonController = LessonController();

  String selectedDepartment = "Please select a department*";
  String selectedGrade = "Please select a grade*";
  bool isObligatory = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: primaryColor,
        title: Text(
          "Add new lesson",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name*',
                    hintText: "Ex: maths",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if ((value != null && value.contains('@'))) {
                      return 'Do not use the @ char';
                    } else if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: shortNameController,
                  decoration: const InputDecoration(
                    labelText: 'Short Name*',
                    hintText: "Ex: MATH101",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if ((value != null && value.contains('@'))) {
                      return 'Do not use the @ char';
                    } else if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: "Ex: Basic math learning",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if ((value != null && value.contains('@'))) {
                      return 'Do not use the @ char';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == "Please select a grade*") {
                        return "Please select a grade";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: selectedGrade,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: grades.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGrade = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == "Please select a department*") {
                        return "Please select a department";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: selectedDepartment,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: departments.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: creditController,
                  validator: (value) {
                    String pattern = r'^[0-9]+$';
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length > 1) {
                      return 'Please enter a valid value';
                    } else if (!RegExp(pattern).hasMatch(value)) {
                      return 'Please enter a valid value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Credit*',
                    hintText: "Ex: 4",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: instructorController,
                  decoration: const InputDecoration(
                    labelText: 'Instructor',
                    hintText: "Ex: Prof. Dr. John Doe",
                    border: OutlineInputBorder(),
                  ),
                ),
                CheckboxListTile(
                  title: const Text("Is Obligatory?"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: isObligatory,
                  onChanged: (value) {
                    setState(() {
                      isObligatory = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        /* ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              dismissDirection: DismissDirection.up,
                              content: Text('Processing Data')),
                        ); */

                        Lesson newLesson = Lesson(
                          name: nameController.text,
                          shortName: shortNameController.text,
                          descriptions: descriptionController.text == ""
                              ? null
                              : descriptionController.text,
                          department: selectedDepartment !=
                                  "Please select a department*"
                              ? selectedDepartment
                              : null,
                          grade: selectedGrade != "Please select a grade*"
                              ? int.parse(selectedGrade)
                              : null,
                          instructor: instructorController.text,
                          credit: int.parse(creditController.text),
                          obligation: isObligatory ? 1 : 0,
                        );

                        try {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  "Lesson ${newLesson.shortName} - ${newLesson.name} created successfully!",
                            ),
                          );
                          Navigator.of(context).pop();
                          await _lessonController.createLesson(newLesson);
                        } catch (e) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  "An error occured while creating lesson!",
                            ),
                          );
                          debugPrint('Hata: $e');
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      "Done",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
