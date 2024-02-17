import 'package:educational_app/Screens/HomePage/home_page.dart';
import 'package:educational_app/Screens/Signup/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  SharedPreferences? prefs;

  bool visible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((var user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
  }

  Future<void> signIn(BuildContext context) async {
    if (kDebugMode) {
      print("function called");
    }

    try {
      setState(() {
        isLoading = true;
      });

      User? user;
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = result.user;

      prefs = await SharedPreferences.getInstance();

      if (FirebaseAuth.instance.currentUser != null) {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        prefs!.setString('userId', userId);
        if (kDebugMode) {
          print(FirebaseAuth.instance.currentUser?.uid);
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'The user account has been disabled.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.lightBlue, // Change the color to red for errors
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                  padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
                  width: double.infinity,
                  height: size.height * 0.45,
                  child: Image.asset("assets/images/login.png"),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: size.height * 0.05,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                    bottom: 10,
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
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
                    controller: emailController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                    bottom: 10,
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
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
                    controller: passwordController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: size.width * 0.85,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      signIn(context);
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 2,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don’t have an Account ? ",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
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
