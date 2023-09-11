import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_uni/utils/constants.dart';
import 'package:my_uni/views/screens/instructors_screen.dart';
import 'package:my_uni/views/screens/lessons_screen.dart';
import 'package:my_uni/views/screens/students_screen.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({super.key});

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  dynamic selected;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 50,
        ),
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
        ),
        items: [
          BottomBarItem(
            icon: const FaIcon(
              FontAwesomeIcons.home,
              size: 25,
            ),
            selectedColor: primaryColor,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: FaIcon(
                FontAwesomeIcons.book,
                size: 25,
              ),
            ),
            selectedColor: primaryColor,
            title: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text('Lessons'),
            ),
          ),
          BottomBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: FaIcon(
                  FontAwesomeIcons.graduationCap,
                  size: 25,
                ),
              ),
              selectedColor: primaryColor,
              title: const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Students'),
              )),
          BottomBarItem(
              icon: const FaIcon(
                FontAwesomeIcons.personChalkboard,
                size: 25,
              ),
              selectedColor: primaryColor,
              title: const Text('instructors')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // ToDo: fü hakkında sayfasına gidicek
            controller.jumpToPage(0);
            selected = 0;
          });
        },
        elevation: 6,
        backgroundColor: primaryColor,
        child: Image.asset("assets/logo.png", height: 40, width: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: const [
            Center(child: Text('Home')),
            LessonsScreen(),
            StudentsScreen(),
            InstructorsScreen(),
          ],
        ),
      ),
    );
  }
}
