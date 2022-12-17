import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/collection-slide.dart';

import './detail.dart';
import '../components/callapi.dart';

class MyApp extends StatelessWidget {
  var boxshadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(1),
      // spreadRadius: 5,
      blurRadius: 10,
      offset: Offset(0, 0.75), // changes position of shadow
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
        InkWell(
            child: Container(
                padding: EdgeInsets.only(top: 105),
                child: InkWell(
                    child: Text(
                  'Đăng ký/đăng nhập',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(74, 74, 74, 1),
                  ),
                )))),
        FutureBuilder<List<ImageCenter>>(
            future: createImageCenter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ImageCenter> data = snapshot.data!;
                List<String> dataimagecenter = [];
                List<dynamic> dataid = [];
                dataid = data.map((item) => item.id).toList();
                dataimagecenter = data.map((item) => item.banner).toList();

                return Container(
                    padding: EdgeInsets.only(
                        left: 29, right: 30, top: 18, bottom: 0),
                    child: CarouselSlider(
                      items: data
                          .map((e) => ClipRRect(
                                child: Stack(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(1),
                                              // spreadRadius: 5,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  0.75), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          // do something
                                                          DetailPage(
                                                              dataKey: e.id)));
                                            },
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child:
                                                    Image.network(e.banner))))
                                  ],
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 220,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
        FutureBuilder<List<SlideBanner>>(
            future: createSlideBanner(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SlideBanner> dataSlideBanner = snapshot.data!;

                return Container(
                    // height: 80,
                    padding: EdgeInsets.only(top: 24),
                    child: CarouselSlider(
                      items: dataSlideBanner
                          .map((e) => ClipRRect(
                                child: Stack(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              // spreadRadius: 5,
                                              blurRadius: 10,
                                              offset: Offset(0,
                                                  0.75), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(e.url)))
                                  ],
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 80,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
        FutureBuilder<List<SlideContent>>(
            future: createSlideContent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SlideContent> dataSlideContent = snapshot.data!;
                return Column(
                  children: dataSlideContent
                      .map((data) => CollectionSlide(collectionData: data))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
      ]),
    )));
  }
}
