import 'package:flutter/material.dart';
import 'package:my_uni/controllers/instructor_controller.dart';
import 'package:my_uni/controllers/lesson_controller.dart';
import 'package:my_uni/controllers/student_controller.dart';
import 'package:my_uni/views/screens/instructor/add_instructor_screen.dart';
import 'package:my_uni/views/screens/lesson/add_lesson_screen.dart';
import 'package:my_uni/views/screens/student/add_student_screen.dart';
import 'package:my_uni/views/widgets/counter_card_widgets.dart';
import 'package:my_uni/views/widgets/my_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentController _studentController = StudentController();
  final LessonController _lessonController = LessonController();
  final InstructorController _instructorController = InstructorController();

  int studentsCount = 0;
  int instructorsCount = 0;
  int lessonsCount = 0;

  @override
  void initState() {
    super.initState();
    _instructorController.fetchInstructors().then((value) {
      setState(() {
        instructorsCount = value.length;
      });
    });
    _lessonController.fetchLessons().then((value) {
      setState(() {
        lessonsCount = value.length;
      });
    });
    _studentController.fetchStudents().then((value) {
      setState(() {
        studentsCount = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logo2.png',
            height: 200,
          ),
        ),
        /* Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome!',
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ), */
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CounterCard(
              title: "Students",
              count: studentsCount,
            ),
            CounterCard(
              title: "Instructors",
              count: instructorsCount,
            ),
            CounterCard(
              title: "Lessons",
              count: lessonsCount,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        MyButton(
          size: size,
          text: "Add Student",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudentScreen(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        MyButton(
            size: size,
            text: "Add Instructor",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddInstructurScreen(),
                ),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        MyButton(
            size: size,
            text: "Add Lesson",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddLessonScreen(),
                ),
              );
            }),
      ],
    );
  }
}
