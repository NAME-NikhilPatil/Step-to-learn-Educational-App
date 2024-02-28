import 'package:educational_app/Screens/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key? key, required this.marks}) : super(key: key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

// ignore: camel_case_types
class _resultpageState extends State<resultpage> {
  List<String> images = [
    "assets/images/success.png",
    "assets/images/good.png",
    "assets/images/bad.png",
  ];

  String? message;
  String? image;

  @override
  void initState() {
    if (marks < 20) {
      image = images[2];
      message = "You Should Try Hard..\n" "You Scored $marks";
    } else if (marks < 35) {
      image = images[1];
      message = "You Can Do Better..\n" "You Scored $marks";
    } else {
      image = images[0];
      message = "You Did Very Well..\n" "You Scored $marks";
    }
    super.initState();
  }

  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Material(
                    child: SizedBox(
                      width: 300.0.w,
                      height: 300.0.h,
                      child: ClipRect(
                        child: Image(
                          image: AssetImage(
                            image!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0.h,
                        horizontal: 15.0.w,
                      ),
                      child: Center(
                        child: Text(
                          message!,
                          style: TextStyle(
                            fontSize: 18.0.sp,
                            fontFamily: "Quando",
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0.sp,
                      color: Colors.lightBlue,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
