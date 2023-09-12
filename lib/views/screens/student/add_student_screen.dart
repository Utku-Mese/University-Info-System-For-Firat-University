import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_uni/controllers/student_controller.dart';
import 'package:my_uni/models/student_model.dart';
import 'package:my_uni/utils/constants.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  final StudentController _studentController = StudentController();

  String selectedDepartment = "Please select a department*";
  String selectedGender = "Please select a gender*";
  bool isActive = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
    surnameController.clear();
    phoneNumberController.clear();
    addressController.clear();
    gpaController.clear();
    imageUrlController.clear();
    emailController.clear();
    gradeController.clear();
    selectedDepartment = "Please select a department*";
    selectedGender = "Please select a gender*";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: primaryColor,
        title: Text(
          "Add new student",
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name*',
                    hintText: "Ex: Utku",
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: surnameController,
                  decoration: const InputDecoration(
                    labelText: 'Surname*',
                    hintText: "Ex: Meşe",
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
                Flexible(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == "Please select a gender*") {
                        return "Please select a gender";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: selectedGender,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: genders.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: gradeController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.contains('@') || value.contains('.')) {
                      return 'Do not use the @ and . char';
                    } else if (value.length > 3 || value.length < 3) {
                      return 'Please enter a valid grade';
                    } else if (value[1] != "/") {
                      return 'Please enter a valid grade';
                    } else if (value[0] == "0") {
                      return 'Please enter a valid grade';
                    } else if (value[2] == "0") {
                      return 'Please enter a valid grade';
                    } else if (value[1] != "/") {
                      return 'Please enter a valid grade';
                    } else if (int.parse(value[0]) > int.parse(value[2])) {
                      return 'Please enter a valid grade';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Grade*',
                    hintText: "Ex: 3/4",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email*',
                    hintText: "Ex: example@example.com",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneNumberController,
                  validator: (value) {
                    String pattern = r'^[0-9]+$';
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length != 11) {
                      return 'Please enter a valid phone number';
                    } else if (!RegExp(pattern).hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone Number*',
                    hintText: "Ex: 05555555555",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: "Ex: Folower street No:55 /Denizli, Turkey",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: gpaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.contains('@') || value.contains('/')) {
                      return 'Do not use the @ and / char';
                    } else if (double.parse(value) > 4.0 ||
                        double.parse(value) < 0.0) {
                      return 'Please enter a valid GPA';
                    } else if (value.length > 4 || value.length < 3) {
                      return 'Please enter a valid GPA';
                    } else if (value[1] != ".") {
                      return 'Please enter a valid GPA';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'GPA*',
                    hintText: "Ex: 3.55 or 3.0",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Profile Picture URL',
                    hintText:
                        "Ex: https://randomuser.me/api/portraits/lego/5.jpg",
                    border: OutlineInputBorder(),
                  ),
                ),
                CheckboxListTile(
                  title: const Text("Is Active?"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isErr = false;
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        Student newStudent = Student(
                          name: nameController.text,
                          surname: surnameController.text,
                          gender: selectedGender != "Please select a gender"
                              ? selectedGender
                              : null,
                          department:
                              selectedDepartment != "Please select a department"
                                  ? selectedDepartment
                                  : null,
                          grade: gradeController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          adress: addressController.text,
                          gpa: double.parse(gpaController.text),
                          imageUrl: imageUrlController.text,
                          isActive: isActive ? 1 : 0,
                        );

                        try {
                          Student createdStudent = await _studentController
                              .createStudent(newStudent);
                          debugPrint(
                              'Öğrenci oluşturuldu: ${createdStudent.name}');
                        } catch (e) {
                          isErr = true;
                          debugPrint('Hata: $e');
                        }

                        if (isErr) {
                          // ignore: use_build_context_synchronously
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text("An error occured"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Student created"),
                                content: Text(
                                    "${newStudent.name} ${newStudent.surname} is created"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                          dispose();
                          Navigator.pop(context);
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
