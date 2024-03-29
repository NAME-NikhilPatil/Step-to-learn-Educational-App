// ignore_for_file: unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/Screens/Login/LoginScreen.dart';
import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:educational_app/Screens/Welcome/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  final Function? onTap;
  const DrawerScreen(
      {super.key, this.onTap, this.username, this.email, this.image});
  final String? username, email, image;
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance;
  String? username, email, image;

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userId');
      print(prefs.containsKey("userId"));
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      //print(e.toString());
    }
  }

  void getData() {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    if (firebaseUser.uid.isEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    } else {
      databaseReference
          .collection("User")
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        Map<String, dynamic>? data = value.data();
        setState(() {
          username = data!["username"];
          email = data["email"];
          image = data["photourl"];
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      padding: EdgeInsets.only(top: 50.h, bottom: 70.h, left: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.r,
                backgroundColor: const Color(0xFF62B9BF),
                child: ClipOval(
                  child: SizedBox(
                    width: 50.0.w,
                    height: 50.0.h,
                    child: (image != null)
                        ? Image.network(
                            image!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            "https://previews.123rf.com/images/lineartist/lineartist1907/lineartist190702409/127623033-doing-office-work-on-laptop-cute-girl-cartoon-character-vector-illustration.jpg",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    email != null ? email! : "hexhackathon30@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    username != null ? username! : "Learn With AI",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(1);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        FontAwesomeIcons.bookReader,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.courses.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(2);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.profile.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(3);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.book,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.materials.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(4);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.event,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.events.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(5);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.laptop_chromebook,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.quiz.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(6);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.Study_Center.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(7);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.people_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.mentors.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap!(8);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.contacts,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        LocaleData.contact.getString(context),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _logout(context);
              },
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    LocaleData.logout.getString(context),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
