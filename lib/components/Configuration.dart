import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Colors.lightBlue;
// Color primaryGreen = const Color(0xff00ABFF);
// Color primaryGreen1 = Color(Colors.greenAccent);
Color SecondaryColor = const Color(0xFF62B9BF);

List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10))
];

List<Map> categories = [
  {
    // 'name': LocaleData.hindi.getString,
    'iconPath': "assets/images/language.svg"
  },
  {
    // 'name': LocaleData.maths.getString,
    'iconPath': "assets/images/maths.svg"
  },
  {
    // 'name': LocaleData.science.getString,
    'iconPath': "assets/images/science.svg"
  },
  {
    // 'name': LocaleData.english.getString,
    'iconPath': "assets/images/english.svg"
  },
  {
    // 'name': LocaleData.history.getString,
    'iconPath': "assets/images/history.svg"
  }
];

List<Map> drawerItems = [
  {'icon': Icons.person_outline, 'title': 'Profile'},
  {'icon': FontAwesomeIcons.bookOpenReader, 'title': 'Courses'},
  {'icon': Icons.book, 'title': 'Materials'},
  {'icon': Icons.event, 'title': 'Events'},
  {'icon': Icons.laptop_chromebook, 'title': 'Quiz'},
  {'icon': Icons.people_outline, 'title': 'Mentors'},
  {'icon': Icons.contacts, 'title': 'Contact'},
];
