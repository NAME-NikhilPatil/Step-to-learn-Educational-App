import 'package:educational_app/Screens/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final databaseReference = FirebaseFirestore.instance;
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool visible = false;
  bool isLoading = false;

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future<void> signup(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      User? user;
      // await user.sendEmailVerification();
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      user = result.user;

      await databaseReference.collection("User").doc(user!.uid).set({
        'email': emailcontroller.text,
        'password': passwordcontroller.text,
        'username': usernamecontroller.text,
        'photourl': null,
      });

      await _navigateToLoginScreen(context);
    } catch (e) {
      print(e);
      String errorMessage = 'An error occurred';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }
      // ignore: use_build_context_synchronously
      _showErrorSnackBar(context, errorMessage);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _navigateToLoginScreen(BuildContext context) async {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Now Enter your Email and Password and Login:)"),
        backgroundColor: Colors.lightBlue,
      ));
    });

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.lightBlue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15.h, left: 30.w, right: 30.w),
                  width: double.infinity,
                  height: size.height * 0.4,
                  child: Image.asset("assets/images/signup.png"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: size.height * 0.05,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 30.w, right: 30.w, top: 20.h, bottom: 10.h),
                  padding: EdgeInsets.only(left: 20.w),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      )),
                  child: TextField(
                    onChanged: null,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.lightBlue,
                      ),
                      hintText: "Username",
                      border: InputBorder.none,
                    ),
                    controller: usernamecontroller,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
                  padding: EdgeInsets.only(left: 20.w),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      )),
                  child: TextField(
                    onChanged: null,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: Colors.lightBlue,
                      ),
                      hintText: "Your Email",
                      border: InputBorder.none,
                    ),
                    controller: emailcontroller,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
                  padding: EdgeInsets.only(left: 20.w),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      )),
                  child: TextField(
                    onChanged: null,
                    obscureText: visible == false ? true : false,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.lightBlue,
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                      suffixIcon: _visible(),
                    ),
                    controller: passwordcontroller,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  width: size.width * 0.85,
                  decoration:  BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      )),
                  child: TextButton(
                    onPressed: () async {
                      await signup(context);
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        :  Text(
                            "SIGNUP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              letterSpacing: 2,
                            ),
                          ),
                  ),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Have an Account ? ",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                // ... rest of the code remains unchanged
              ],
            ),
          ),
        ),
      ),
    );
  }

  _visible() {
    return GestureDetector(
      onTap: () {
        setState(() {
          visible = !visible;
        });
      },
      child: visible == true
          ? const Icon(
              Icons.visibility_off,
              color: Colors.lightBlue,
            )
          : const Icon(
              Icons.visibility,
              color: Colors.lightBlue,
            ),
    );
  }
}
