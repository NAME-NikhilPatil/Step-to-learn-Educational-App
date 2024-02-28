// ignore_for_file: deprecated_member_use
import 'package:educational_app/Screens/Contact_us_Page/faqs.dart';
import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:educational_app/components/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

const String lat = "19.0212891";
const String lng = "72.8305975";

class HelpSection extends StatefulWidget {
  const HelpSection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HelpSectionState createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {
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
                  Column(
                    children: [
                      Text(
                        LocaleData.contactus.getString(context),
                        style: TextStyle(
                          color: primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 27.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
                child: Image.asset(
              'assets/images/contactus2.png',
              height: 210.h,
            )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              LocaleData.feedback.getString(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _createEmail();
                    },
                    child: Container(
                      height: 120.h,
                      width: 130.w,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.alternate_email,
                            color: primaryGreen,
                            size: 50,
                          ),
                          Text(
                            'Write to us :',
                            style: TextStyle(color: primaryGreen),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text('learnwithai.help@gmail.com'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      //_makePhoneCall('tel: 7486918587');
                      _makeCall();
                    },
                    child: Container(
                      height: 120.h,
                      width: 130.w,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: primaryGreen,
                            size: 50,
                          ),
                          Text('Call us :',
                              style: TextStyle(color: primaryGreen)),
                          const Text('+919325369502')
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FAQPage()),
                      );
                    },
                    child: Container(
                      height: 120.h,
                      width: 130.w,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.help_outline,
                            color: primaryGreen,
                            size: 50,
                          ),
                          Text('FAQs :', style: TextStyle(color: primaryGreen)),
                          const Text(
                            'Frequently asked questions',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _getlocation();
                    },
                    child: Container(
                      height: 120.h,
                      width: 130.w,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10))
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                            size: 50,
                          ),
                          Text('Locate to us :',
                              style: TextStyle(color: primaryGreen)),
                          const Text(
                            'Find us on Google Maps',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            const Text('Copyright (c) 2023 learn with ai'),
            const Text('All rights reserved')
          ],
        ),
      ),
    );
  }
}

void _makeCall() async {
  const phonenumber = "tel:9325369502";

  if (await canLaunch(phonenumber)) {
    await launch(phonenumber);
  } else {
    throw 'Could not call';
  }
}

void _createEmail() async {
  const emailaddress =
      'mailto:hexhackathon23@gmail.com?subject=From App&body=Write your query over here';

  if (await canLaunch(emailaddress)) {
    await launch(emailaddress);
  } else {
    throw 'Could not Email';
  }
}

void _getlocation() async {
  const String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
  const String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  }
  if (await canLaunch(appleMapsUrl)) {
    await launch(appleMapsUrl, forceSafariVC: false);
  } else {
    throw "Couldn't launch URL";
  }
}
