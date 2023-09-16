import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/instructor_controller.dart';
import '../../../models/instructor_model.dart';
import '../../../utils/constants.dart';
import '../../widgets/my_dialog_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InstructorsInfoScreen extends StatefulWidget {
  const InstructorsInfoScreen({super.key, required this.instructor});

  final Instructor instructor;

  @override
  State<InstructorsInfoScreen> createState() => _InstructorsInfoScreenState();
}

class _InstructorsInfoScreenState extends State<InstructorsInfoScreen> {
  final InstructorController _instructorController = InstructorController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "${widget.instructor.degree ?? ""} ${widget.instructor.name} ${widget.instructor.surname}",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyDilog.showMyDialog(
                context: context,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        title: 'Are you sure?',
                        desc: 'You want to delete this instructor?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);

                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  "Instructor ${widget.instructor.name} ${widget.instructor.surname} deleted successfully!",
                            ),
                          );
                          int instructorIdToDelete = widget.instructor.id!;

                          try {
                            await _instructorController
                                .deleteInstructor(instructorIdToDelete);
                          } catch (e) {
                            debugPrint('Hata: $e');
                          }
                        },
                      ).show();
                    },
                    child: const Text('Delete this instructor'),
                  ),
                  const SizedBox(height: 10),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: widget.instructor.imageUrl == null
                            ? SizedBox(
                                width: 100,
                                height: 100,
                                child: CircleAvatar(
                                  child: Text(
                                    widget.instructor.name![0],
                                    style: const TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: widget.instructor.imageUrl!,
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
                                  imageUrl:
                                      widget.instructor.imageUrl.toString(),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error,
                                          color: Colors.white),
                                ),
                              ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 115,
                          child: Column(
                            children: [
                              Text(
                                "Instructor No",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const Divider(color: Colors.white),
                              const SizedBox(height: 5),
                              Text(
                                widget.instructor.id.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        SizedBox(
                          width: 115,
                          child: Column(
                            children: [
                              Text(
                                "Department",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const Divider(color: Colors.white),
                              const SizedBox(height: 5),
                              Text(
                                widget.instructor.department.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Instructor Info",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: size.width * 0.6,
                        child: Divider(color: primaryColor)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Name:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${widget.instructor.name} ${widget.instructor.surname}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Degree:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.instructor.degree.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Gender:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.instructor.gender.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Department:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            widget.instructor.department.toString(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Email:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.instructor.email.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Phone Number:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.instructor.phoneNumber.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          "Adress:",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.clip,
                            widget.instructor.adress.toString(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
