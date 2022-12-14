import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../components/callapi.dart';
import './detail.dart';
import './more.dart';
import 'package:flutter_application_1/components/slider.dart';

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
                    child: 
                      
                    CarouselSlider(
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
                    )
                    );
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
                List<String> nameVi = [];
                List<dynamic> collid = [];
                List<dynamic> listContent = [];
                nameVi = dataSlideContent.map((item) => item.nameVi).toList();
                collid = dataSlideContent.map((item) => item.collid).toList();
                listContent =
                    dataSlideContent.map((item) => item.listContent).toList();

                return Column(children: [
                  for (var i = 0; i < nameVi.length; i++)
                    Container(
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 31, top: 18, right: 26, bottom: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${nameVi[i]}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      height: 7 / 6,
                                      color: Color.fromRGBO(74, 74, 74, 1),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    // do something
                                                    Clickdots(
                                                        dataKey: collid[i])));
                                      },
                                      child: Text(
                                        '...',
                                        style: TextStyle(
                                          fontSize: 48,
                                          height: 7 / 16,
                                          color: Color.fromRGBO(74, 74, 74, 1),
                                        ),
                                      ))
                                ])),
                        Container(
                            height: 142,
                            padding: EdgeInsets.only(left: 0, top: 2),
                            child: SliderImage1(
                              listImage: listContent[i],
                              height: 142,
                              id: 'id',
                              image: 'thumnail',
                              viewportFraction: 0.3,
                            )

                            //  CarouselSlider(
                            //   items: listContent[i]
                            //       .map((e) => ClipRRect(
                            //             child: Stack(
                            //               children: [
                            //                 Container(
                            //                     padding:
                            //                         EdgeInsets.only(bottom: 10),
                            //                     decoration: BoxDecoration(
                            //                       borderRadius:
                            //                           BorderRadius.all(
                            //                               Radius.circular(50)),
                            //                       boxShadow: [
                            //                         BoxShadow(
                            //                           color: Colors.grey
                            //                               .withOpacity(1),
                            //                           // spreadRadius: 5,
                            //                           blurRadius: 20,
                            //                           offset: Offset(0,
                            //                               0.75), // changes position of shadow
                            //                         ),
                            //                       ],
                            //                     ),
                            //                     child: InkWell(
                            //                         onTap: () {
                            //                           Navigator.push(
                            //                               context,
                            //                               MaterialPageRoute(
                            //                                   builder:
                            //                                       (context) =>
                            //                                           // do something
                            //                                           DetailPage(
                            //                                               dataKey:
                            //                                                   e['_id'])));
                            //                         },
                            //                         child: ClipRRect(
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .circular(10),
                            //                             child: Image.network(
                            //                                 e['thumnail']))))
                            //               ],
                            //             ),
                            //           ))
                            //       .toList(),
                            //   options: CarouselOptions(
                            //     height: 142,
                            //     viewportFraction: 0.3,
                            //     enlargeCenterPage: false,
                            //     enableInfiniteScroll: true,
                            //     autoPlay: true,
                            //   ),
                            // ))
                            )
                      ]),
                    )
                ]);
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
