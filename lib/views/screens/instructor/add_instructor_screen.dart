import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/instructor_controller.dart';
import '../../../models/instructor_model.dart';
import '../../../utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddInstructurScreen extends StatefulWidget {
  const AddInstructurScreen({super.key});

  @override
  State<AddInstructurScreen> createState() => _AddInstructurScreenState();
}

class _AddInstructurScreenState extends State<AddInstructurScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final InstructorController _instructorController = InstructorController();

  String selectedDepartment = "Please select a department*";
  String selectedGender = "Please select a gender*";
  String selectedDegree = "Please select a degree*";
  bool isActive = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: primaryColor,
        title: Text(
          "Add new instructor",
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
                      if (value == "Please select a degree*") {
                        return "Please select a degree";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: selectedDegree,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: degrees.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDegree = newValue!;
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
                  keyboardType: TextInputType.number,
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

                        Instructor newInstructor = Instructor(
                          name: nameController.text,
                          surname: surnameController.text,
                          degree: selectedDegree != "Please select a degree*"
                              ? selectedDegree
                              : null,
                          gender: selectedGender != "Please select a gender*"
                              ? selectedGender
                              : null,
                          department: selectedDepartment !=
                                  "Please select a department*"
                              ? selectedDepartment
                              : null,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          adress: addressController.text == ""
                              ? null
                              : addressController.text,
                          imageUrl: imageUrlController.text == ""
                              ? null
                              : imageUrlController.text,
                          isActive: isActive ? 1 : 0,
                        );

                        try {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  "Instructor ${newInstructor.name} ${newInstructor.surname} created successfully!",
                            ),
                          );
                          Navigator.of(context).pop();
                          await _instructorController
                              .createInstructor(newInstructor);
                        } catch (e) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  "An error occured while creating instructor!",
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
