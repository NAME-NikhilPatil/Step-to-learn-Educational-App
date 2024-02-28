import 'package:educational_app/Screens/Quiz_Page/quizpage.dart';
import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  List<String> images = [
    "assets/images/maths.svg",
    "assets/images/english.svg",
    "assets/images/science.svg",
    "assets/images/language.svg"
  ];

  List<String> des = [
    "Explore the world of numbers and shapes in 1st-grade math – a fun journey of learning and discovery awaits you! Test your math skills and watch your understanding grow!",
    "Dive into the world of words and sentences in 1st-grade English – explore, learn, and challenge yourself with the wonders of language!",
    "Dive into the wonders of the natural world with 1st-grade science – explore, discover, and test your knowledge in a fun and exciting learning adventure!",
    "खोजो हिंदी की दुनिया को पहली कक्षा में - एक मजेदार और शिक्षात्मक सफर में, जानो और अपनी जानकारी का परीक्षण करो!",
  ];

  Widget customcard(String langname, String image, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0.h,
        horizontal: 30.0.w,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file
            // for a particular language
            builder: (context) => getjson(langname),
          ));
        },
        child: Material(
          color: Colors.lightBlue,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.0.h,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(100.0.r),
                  child: SizedBox(
                    // changing from 200 to 150 as to look better
                    height: 150.0.h,
                    width: 150.0.w,
                    child: ClipOval(
                      child: SvgPicture.asset(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  langname,
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    color: Colors.white,
                    fontFamily: "Quando",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  des,
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    color: Colors.white,
                    fontFamily: "Alike",
                  ),
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
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
                    width: 100.w,
                  ),
                ],
              ),
            ),
            _container(
              0.0.w,
              30.0.h,
              10.0.w,
              Colors.lightBlue,
              LocaleData.quiz.getString(context),
              "assets/images/quiz.png",
            ),
            customcard(LocaleData.maths.getString(context), images[0], des[0]),
            customcard(
                LocaleData.english.getString(context), images[1], des[1]),
            customcard(
                LocaleData.science.getString(context), images[2], des[2]),
            customcard(LocaleData.hindi.getString(context), images[3], des[3]),
          ],
        ),
      ),
    );
  }

  _container(left, top, right, color, text, image) {
    return GestureDetector(
      onTap: () {},
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
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
