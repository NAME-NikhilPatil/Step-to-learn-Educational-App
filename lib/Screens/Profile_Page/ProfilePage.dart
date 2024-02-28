import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:educational_app/components/Configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final databaseReference = FirebaseFirestore.instance;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  String? username, email, method, category, image;

  bool isDrawerOpen = false;

  final usernamecontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  final methodcontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  void getdata() async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    databaseReference
        .collection("User")
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        username = data!["username"];
        email = data["email"];
        method = data["method"];
        category = data["category"];
        image = data["photourl"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    Future uploadPic() async {
      var firebaseUser = FirebaseAuth.instance.currentUser!;
      String filName = p.basename(_image!.path);
      var reference = FirebaseStorage.instance.ref().child(filName);
      var uploadTask = reference.putFile(_image!);
      var taskSnapshot = await uploadTask;
      setState(() {
        print("Image Uploaded");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Image Uploaded"),
        ));
      });
      final String url = await taskSnapshot.ref.getDownloadURL();
      print("downloadurl $url");
      databaseReference.collection("User").doc(firebaseUser.uid).update({
        'photourl': url,
        'category': categorycontroller.text != ""
            ? categorycontroller.text
            : category ?? "Student",
        'method': methodcontroller.text != ""
            ? methodcontroller.text
            : method ?? "Online",
        'username':
            usernamecontroller.text != "" ? usernamecontroller.text : username,
        'email': emailcontroller.text != "" ? emailcontroller.text : email,
      }).then((_) {
        if (kDebugMode) {
          print("success!");
        }
      });
    }

    Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image!.path);
        if (kDebugMode) {
          print("Image path $_image");
        }
      });
      uploadPic();
    }

    Future updatedata() async {
      var firebaseUser = FirebaseAuth.instance.currentUser!;
      databaseReference.collection("User").doc(firebaseUser.uid).update({
        'category': categorycontroller.text != ""
            ? categorycontroller.text
            : category ?? "Student",
        'method': methodcontroller.text != ""
            ? methodcontroller.text
            : method ?? "Online",
        'username':
            usernamecontroller.text != "" ? usernamecontroller.text : username,
        'email': emailcontroller.text != "" ? emailcontroller.text : email,
      }).then((_) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Data Updated"),
            backgroundColor: primaryGreen,
          ));
        });
      });
    }

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.white,
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
                ],
              ),
            ),
            _container(
                0.0,
                30.0,
                10.0,
                Colors.lightBlue,
                LocaleData.profile.getString(context),
                "assets/images/profile.png"),
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 60.w,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 90.r,
                    backgroundColor: Colors.lightBlue,
                    child: ClipOval(
                      child: SizedBox(
                        width: 165.0.w,
                        height: 165.0.w,
                        child: (_image != null)
                            ? Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              )
                            : (image != null)
                                ? Image.network(
                                    image!,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt1MCkcc9N01BCt6q1G12dXL2np82d63podA&usqp=CAU",
                                    fit: BoxFit.fill,
                                  ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0.h, right: 20.w),
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.camera,
                      color: Colors.lightBlue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0.h,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 20.h, bottom: 10.h),
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFDBF3FA),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  )),
              child: TextField(
                onChanged: null,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Colors.lightBlue,
                  ),
                  hintText: username ?? "Learn With AI",
                  border: InputBorder.none,
                ),
                controller: usernamecontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 20.h, bottom: 10.h),
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFDBF3FA),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  )),
              child: TextField(
                onChanged: null,
                decoration: InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.list,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Colors.lightBlue,
                  ),
                  hintText: category ?? "Student",
                  border: InputBorder.none,
                ),
                controller: categorycontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 20.h, bottom: 10.h),
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFDBF3FA),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  )),
              child: TextField(
                onChanged: null,
                decoration: InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.bookOpen,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Colors.lightBlue,
                  ),
                  hintText: method ?? "Online",
                  border: InputBorder.none,
                ),
                controller: methodcontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 20.h, bottom: 10.h),
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFDBF3FA),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  )),
              child: TextField(
                onChanged: null,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Colors.lightBlue,
                  ),
                  hintText: email ?? "code.warriors.help@gmail.com",
                  border: InputBorder.none,
                ),
                controller: emailcontroller,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(
                //   margin: const EdgeInsets.only(top: 10, bottom: 10),
                //   width: MediaQuery.of(context).size.width * 0.25,
                //   decoration: const BoxDecoration(
                //       color: Color(0xFF62B9BF),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(5),
                //       )),
                //   child: TextButton(
                //     onPressed: () {

                //     },
                //     child: const Text(
                //       'Cancel',
                //       style: TextStyle(color: Colors.white, fontSize: 16.0),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      )),
                  child: TextButton(
                    onPressed: () {
                      updatedata();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0.sp),
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
        //     //builder: (context) => SelectedWork()
        //     ));
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
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
