import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_uni/utils/constants.dart';
import 'package:my_uni/views/widgets/counter_card_widgets.dart';
import 'package:my_uni/views/widgets/my_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CounterCard(
              title: "Students",
              count: 100,
            ),
            CounterCard(
              title: "Instructors",
              count: 10,
            ),
            CounterCard(
              title: "Lessons",
              count: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        MyButton(size: size, text: "Add Student", onPressed: () {}),
        const SizedBox(
          height: 20,
        ),
        MyButton(size: size, text: "Add Instructor", onPressed: () {}),
        const SizedBox(
          height: 20,
        ),
        MyButton(size: size, text: "Add Lesson", onPressed: () {}),
      ],
    );
  }
}
