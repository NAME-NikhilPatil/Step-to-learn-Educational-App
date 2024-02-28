import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/Screens/Translation/localization/locals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appPadding = 10.0;

    getevents() {
      var firestore = FirebaseFirestore.instance;
      Stream<QuerySnapshot> querySnapshot =
          firestore.collection("Events").snapshots();
      return querySnapshot;
    }

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
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
          _container(0.0.w, 30.0.h, 10.0.w, Colors.lightBlue,
              LocaleData.events.getString(context), "assets/images/event.png"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: StreamBuilder(
                stream: getevents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: double.maxFinite,
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: appPadding,
                                  vertical: appPadding / 2),
                              child: Container(
                                height: size.height * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0.r),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 30.0,
                                          offset: const Offset(10, 15))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(appPadding),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.3,
                                        height: size.height * 0.2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            (snapshot.data!.docs[index].data()
                                                    as Map<String, dynamic>)[
                                                'image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: appPadding / 2,
                                              top: appPadding / 1.5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String,
                                                        dynamic>)['title'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                                maxLines: 2,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _launchevent((snapshot
                                                          .data!.docs[index]
                                                          .data()
                                                      as Map<String,
                                                          dynamic>)['link']);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.link,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Click Here for Information",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.event,
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.01,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    (snapshot.data!.docs[index]
                                                            .data()
                                                        as Map<String,
                                                            dynamic>)['date'],
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ),
          )
        ],
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
          borderRadius: BorderRadius.circular(20.r),
          color: color,
        ),
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
            SizedBox(
              height: 10.h,
            ),
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

void _launchevent(data) async {
  assert(data != null);
  var eventlink = "https://$data";
  // ignore: deprecated_member_use
  if (await canLaunch(eventlink)) {
    // ignore: deprecated_member_use
    await launch(eventlink);
  } else {
    throw 'Could not Email';
  }
}
