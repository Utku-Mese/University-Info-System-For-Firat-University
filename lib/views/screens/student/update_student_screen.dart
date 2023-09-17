import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/student_controller.dart';
import '../../../models/student_model.dart';
import '../../../utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen({super.key, required this.student});

  final Student student;

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  TextEditingController nameController = TextEditingController();
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
  void initState() {
    super.initState();

    isActive = widget.student.isActive == 1 ? true : false;
    nameController.text = widget.student.name!;
    surnameController.text = widget.student.surname!;
    gradeController.text = widget.student.grade!;
    /* selectedDepartment = widget.student.department != null
        ? widget.student.department!
        : "Please select a department*";
    selectedGender = widget.student.gender != null
        ? widget.student.gender!
        : "Please select a gender*"; */
    widget.student.phoneNumber != null
        ? phoneNumberController.text = widget.student.phoneNumber!
        : phoneNumberController.text = "";
    widget.student.adress != null
        ? addressController.text = widget.student.adress!
        : addressController.text = "";
    widget.student.gpa != null
        ? gpaController.text = widget.student.gpa.toString()
        : gpaController.text = "";
    widget.student.imageUrl != null
        ? imageUrlController.text = widget.student.imageUrl!
        : imageUrlController.text = "";
    widget.student.email != null
        ? emailController.text = widget.student.email!
        : emailController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: primaryColor,
        title: Text(
          "Edit Student: ${widget.student.name} ${widget.student.surname}",
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
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
                  textInputAction: TextInputAction.next,
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: "Ex: Folower street No:55 /Denizli, Turkey",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
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
                      if (_formKey.currentState!.validate()) {
                        /* ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              dismissDirection: DismissDirection.up,
                              content: Text('Processing Data')),
                        ); */
                        Student newStudent = Student(
                          name: nameController.text,
                          surname: surnameController.text,
                          gender: selectedGender != "Please select a gender*"
                              ? selectedGender
                              : null,
                          department: selectedDepartment !=
                                  "Please select a department*"
                              ? selectedDepartment
                              : null,
                          grade: gradeController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          adress: addressController.text == ""
                              ? null
                              : addressController.text,
                          gpa: double.parse(gpaController.text),
                          imageUrl: imageUrlController.text == ""
                              ? null
                              : imageUrlController.text,
                          isActive: isActive ? 1 : 0,
                        );

                        try {
                          int count = 0;
                          Navigator.of(context)
                              .popUntil((_) => count++ >= 1); //double pop
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  "Student ${newStudent.name} ${newStudent.surname} updating successfully! Please refresh the page.",
                            ),
                          );
                          Navigator.of(context).pop();
                          await _studentController.updateStudent(
                            newStudent,
                            widget.student.id!,
                          );
                        } catch (e) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  "An error occured while updating student!",
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
