// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:educational_app/Screens/Quiz_Page/resultpage.dart';
import 'package:educational_app/components/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class getjson extends StatelessWidget {
  // accept the langname as a parameter

  String langname;
  getjson(this.langname, {super.key});
  String? assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    if (langname == "Maths" || langname == "गणित" || langname == "ریاضی") {
      // || subject == 'गणित' || subject == 'ریاضی'
      assettoload = "assets/maths.json";
    } else if (langname == "English" ||
        langname == "अंग्रेज़ी" ||
        langname == "انگریزی") {
      // subject == 'अंग्रेज़ी' ||
      // subject == 'انگریزی'
      assettoload = "assets/English.json";
    } else if (langname == "Science" ||
        langname == "विज्ञान" ||
        langname == 'سائنس') {
      // || subject == 'विज्ञान' || subject == 'سائنس'
      assettoload = "assets/science.json";
    } else if (langname == "Hindi" ||
        langname == "हिंदी" ||
        langname == 'اردو') {
      assettoload = "assets/hindi.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload!, cache: true),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        print(mydata);
        return quizpage(mydata: mydata);
      },
    );
  }
}

class quizpage extends StatefulWidget {
  var mydata;

  quizpage({Key? key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  var mydata;
  _quizpageState(this.mydata);

  Color colortoshow = primaryGreen;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  // extra varibale to iterate
  int j = 1;
  int timer = 30;
  String showtimer = "30";
  var random_array;

  Map<String, Color> btncolor = {
    "a": primaryGreen,
    "b": primaryGreen,
    "c": primaryGreen,
    "d": primaryGreen,
  };

  bool canceltimer = false;

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  genrandomarray() {
    var distinctIds = [];
    var rand = Random();
    for (int i = 0;;) {
      distinctIds.add(rand.nextInt(10) + 1);
      random_array = distinctIds.toSet().toList();
      if (random_array.length < 10) {
        continue;
      } else {
        break;
      }
    }
    print(random_array);
  }

  //   var random_array;
  //   var distinctIds = [];
  //   var rand = new Random();
  //     for (int i = 0; ;) {
  //     distinctIds.add(rand.nextInt(10));
  //       random_array = distinctIds.toSet().toList();
  //       if(random_array.length < 10){
  //         continue;
  //       }else{
  //         break;
  //       }
  //     }
  //   print(random_array);

  // ----- END OF CODE
  // var random_array = [1, 6, 7, 2, 4, 10, 8, 3, 9, 5];

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    starttimer();
    genrandomarray();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (j < 10) {
        i = random_array[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = primaryGreen;
      btncolor["b"] = primaryGreen;
      btncolor["c"] = primaryGreen;
      btncolor["d"] = primaryGreen;
    });
    starttimer();
  }

  void checkanswer(String k) {
    // in the previous version this was
    // mydata[2]["1"] == mydata[1]["1"][k]
    // which i forgot to change
    // so nake sure that this is now corrected
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
      marks = marks + 5;
      // changing the color variable to be green
      colortoshow = right;
    } else {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
      colortoshow = wrong;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    // changed timer duration to 1 second
    Timer(const Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0.h,
        horizontal: 20.0.w,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        color: btncolor[k],
        splashColor: primaryGreen,
        highlightColor: primaryGreen,
        minWidth: 200.0.w,
        height: 45.0.h,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0.sp,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Learn With AI",
                  ),
                  content: const Text("You Can't Go Back At This Stage."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Ok',
                      ),
                    )
                  ],
                ));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  choicebutton('a'),
                  choicebutton('b'),
                  choicebutton('c'),
                  choicebutton('d'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    "Timer- $showtimer",
                    style: TextStyle(
                      fontSize: 35.0.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
