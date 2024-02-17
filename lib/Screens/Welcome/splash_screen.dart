import 'package:educational_app/Screens/Login/LoginScreen.dart';
import 'package:educational_app/components/step_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<StepModel> list = StepModel.list;
  final _controller = PageController();
  var initialPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page!.round();
      });
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _appbar(size),
            SizedBox(
              height: size.height * 0.03,
            ),
            _body(_controller),
            SizedBox(
              height: size.height * 0.03,
            ),
            _indicator(),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  _appbar(Size size) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (initialPage > 0) {
                  _controller.animateToPage(initialPage - 1,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                }
              },
              child: Container(
                width: size.width * 0.12,
                height: size.height * 0.075,

                // decoration: BoxDecoration(
                //     color: Colors.grey.withAlpha(50),
                //     borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
          controller: controller,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                index == 1
                    ? _displayText(list[index].text!)
                    : _displayImage(list[index].id!),
                const SizedBox(
                  height: 10,
                ),
                index == 1
                    ? _displayImage(list[index].id!)
                    : _displayText(list[index].text!),
              ],
            );
          }),
    );
  }

  _indicator() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.lightBlue),
                value: (initialPage + 1) / (list.length + 1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print(initialPage);
                }
                if (kDebugMode) {
                  print(list.length);
                }
                if (initialPage < (list.length - 1)) {
                  _controller.animateToPage(initialPage + 1,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                } else if (initialPage == (list.length - 1))
                  // ignore: curly_braces_in_flow_control_structures
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _displayText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  // _displayImage(int path) {
  //   return SvgPicture.asset(
  //     "assets/splashscreen/$path.svg",
  //     height: MediaQuery.of(context).size.height * .5,
  //   );
  // }
  _displayImage(int path) {
    return Image.asset(
      "assets/splashscreen/$path.png",
      height: MediaQuery.of(context).size.height * .5,
      width: MediaQuery.of(context).size.width,
    );
  }
}
