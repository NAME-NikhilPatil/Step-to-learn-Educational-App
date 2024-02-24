import 'package:educational_app/Screens/Contact_us_Page/contactus.dart';
import 'package:educational_app/Screens/EventPage/event.dart';
import 'package:educational_app/Screens/Profile_Page/ProfilePage.dart';
import 'package:educational_app/Screens/Study%20Center/center.dart';
import 'package:educational_app/drawer.dart';
import 'package:educational_app/main_page.dart';
import 'package:flutter/material.dart';
import '../Material_Page/materialpg.dart';
import '../Mentor_Page/mentor.dart';
import '../Quiz_Page/quizhomepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(
            onTap: (int value) {
              setState(() {
                selected = value;
              });
            },
          ),
          selected == 1
              ? const MainScreen()
              : selected == 2
                  ? const ProfilePage()
                  : selected == 3
                      ? const MaterialsPage()
                      : selected == 4
                          ? const EventPage()
                          : selected == 5
                              ? const Quiz()
                              : selected == 6
                                  ? const StudyCenter()
                                  : selected == 7
                                      ? const MentorPage()
                                      : selected == 8
                                          ? const HelpSection()
                                          : const MainScreen(),
        ],
      ),
    );
  }
}
