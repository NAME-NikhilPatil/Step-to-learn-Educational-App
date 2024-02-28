import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:educational_app/components/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MentorPage extends StatefulWidget {
  const MentorPage({super.key});

  @override
  _MentorPageState createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  SizedBox(
                    width: 50.w,
                  ),
                  const Column(
                    children: [
                      //Text('Mentor',style: TextStyle(color: primaryGreen,fontWeight: FontWeight.bold,fontSize: 32),),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.red,
                      //     image: DecorationImage(image: AssetImage("assets/images/logo.png")),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            _container(
                0.0.w,
                30.0.h,
                10.0.w,
                Colors.lightBlue,
                LocaleData.mentors.getString(context),
                "assets/images/mentor.png"),
            SizedBox(
              height: 50.h,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: 300.w,
                  height: 160.h,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        "Nikhil Patil",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Founder",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text("nikhilpatilhaha@gmail.com "),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/nikhil.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: 300.w,
                  height: 160.h,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        "Yash Bandbe",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Co-Founder",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text("yash@gmail.com "),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/yash.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: 300.w,
                  height: 160.h,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        "Siddharth ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Developer",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text("siddharthhihi@gmail.com"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/siddharth.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: 300.w,
                  height: 160.h,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        "Abdul Bari",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Tester",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text("abdulbarigmail.com "),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/success.png"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _container(left, top, right, color, text, image) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   //builder: (context) => SelectedWork()
        // ));
      },
      child: Container(
        margin: EdgeInsets.only(left: left, right: right, top: top),
        height: 180.h,
        width: (MediaQuery.of(context).size.width - 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r), color: color),
        child: Column(
          children: <Widget>[
            Container(
              height: 132.h,
              width: (MediaQuery.of(context).size.width - 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
            ),
            SizedBox(height: 10.h),
            Text(
              text,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
