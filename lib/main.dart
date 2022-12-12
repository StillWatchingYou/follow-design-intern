import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'common.dart';

void main() => runApp(MaterialApp(home: MyApp()));

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

                for (var i = 0; i < dataSlideBanner.length; i++)
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
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                List<List> listContent = [];
                nameVi = dataSlideContent.map((item) => item.nameVi).toList();
                collid = dataSlideContent.map((item) => item.collid).toList();
                listContent =
                    dataSlideContent.map((item) => item.listContent).toList();

                return Container(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: nameVi.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Column(children: [
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
                                            color:
                                                Color.fromRGBO(74, 74, 74, 1),
                                          ),
                                        ))
                                  ])),
                          Container(
                              height: 142,
                              padding: EdgeInsets.only(left: 0, top: 2),
                              child: CarouselSlider(
                                items: listContent[i]
                                    .map((e) => ClipRRect(
                                          child: Stack(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(1),
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
                                                                builder:
                                                                    (context) =>
                                                                        // do something
                                                                        DetailPage(
                                                                            dataKey:
                                                                                e['_id'])));
                                                      },
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                              e['thumnail']))))
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  height: 142,
                                  viewportFraction: 0.3,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                ),
                              ))
                        ]);
                      }),
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

class Clickdots extends StatelessWidget {
  final dataKey;
  Clickdots({Key? key, required this.dataKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: FutureBuilder<InDots>(
        future: createInDots(dataKey),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            InDots dataindots = snapshot.data!;
            return Column(children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 80, left: 35),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      )),
                  Container(
                    padding: EdgeInsets.only(
                        top: 80,
                        left:
                            (MediaQuery.of(context).size.width - 71) / 2 - 83),
                    alignment: Alignment.center,
                    child: Text(
                      '${dataindots.nameVi}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 7 / 6,
                        color: Color.fromRGBO(74, 74, 74, 1),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 48,
                  children: <Widget>[
                    for (var i = 0; i < dataindots.listContent.length; i++)
                      if (dataindots.listContent[i]['thumnail'] != null)
                        Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  // spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 0.75), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                    onTap: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // do something
                                                  DetailPage(
                                                    dataKey: dataindots
                                                        .listContent[i]['_id'],
                                                  )));
                                    }),
                                    child: Image.network(
                                        dataindots.listContent[i]['thumnail'],
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    120) /
                                                3))))
                  ],
                ),
              )
            ]);
          } else if (snapshot.hasError) {
            return Text('${snapshot}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ))),
    );
  }
}

class DetailPage extends StatelessWidget {
  final dataKey;
  DetailPage({Key? key, required this.dataKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder<List<FetchData>>(
          future: createFetchData(dataKey),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<FetchData> data = snapshot.data!;
              var getdata = data[0];
              return Container(
                child: Column(children: [
                  Container(
                    child: new Stack(
                      children: <Widget>[
                        new Container(
                            alignment: Alignment.center,
                            child: Image.network(getdata.coverimage)),
                        //cover photo
                        new Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              padding: EdgeInsets.only(top: 43, left: 13),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(137, 0, 140, 0.87),
                      child: Column(
                        children: [
                          Wrap(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                padding: EdgeInsets.only(
                                    left: 30, top: 5, right: 10),
                                child: Text('${getdata.nameVi}', //title
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 18,
                                      height: 45 / 32,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 40,
                              padding: EdgeInsets.only(
                                  left: 30, top: 2, bottom: 18, right: 10),
                              child: Text(
                                '${getdata.description}',
                                textAlign: TextAlign.left, //description
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 13,
                                  height: 65 / 52,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: 80, right: 90, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Row(children: [
                            Container(
                                padding: EdgeInsets.only(right: 4),
                                child: Image.asset('assets/images/Clock.png')),
                            Text('${getdata.time}',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 5 / 4,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ))
                          ])),
                          Container(
                              child: Row(children: [
                            Container(
                                padding: EdgeInsets.only(right: 4),
                                child: Image.asset('assets/images/Group.png')),
                            Text('${getdata.frequency} tuần/ lần',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 5 / 4,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ))
                          ])),
                          Container(
                              child: Row(children: [
                            Image.asset('assets/images/Group 8700.png'),
                          ])),
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(235, 235, 235, 1),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 7, bottom: 7),
                        child: Text('Mô Tả',
                            style: TextStyle(
                              fontSize: 16,
                              height: 5 / 4,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            )),
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: 50, right: 56, top: 4, bottom: 13),
                      child: Wrap(
                        children: <Widget>[
                          for (var i = 0; i < getdata.tag.length; i++)
                            Text(' #${getdata.tag[i]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  height: 7 / 6,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(135, 33, 176, 1),
                                  fontFamily: 'Roboto',
                                )),
                        ],
                      )
                      // Text(
                      //     '#reggioemilia #merrychristmas #trendingwinter2022 #boyscout #newyeariscoming',
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       fontStyle: FontStyle.italic,
                      //       height: 7 / 6,
                      //       fontWeight: FontWeight.w400,
                      //       color: Color.fromRGBO(135, 33, 176, 1),
                      //       fontFamily: 'Roboto',
                      //     ))
                      ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 46,
                      padding: EdgeInsets.only(left: 7, right: 7),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Mời bạn đăng ký để học chơi nhé',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 13,
                                height: 65 / 52,
                                fontWeight: FontWeight.w500,
                              )))),
                  Container(
                      padding: EdgeInsets.only(top: 20, bottom: 23),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text('Đóng góp bởi',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 5 / 4,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ))),
                        Container(
                            width: 46,
                            height: 51,
                            child: Image.network(
                                getdata.listpartner[0]['impartner']))
                      ])),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nhóm kỹ năng',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                height: 5 / 4,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 11, bottom: 0),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 11,
                                runSpacing: 10,
                                children: <Widget>[
                                  for (var i = 0;
                                      i < getdata.listactiongroup.length;
                                      i++)
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(226, 4, 190, 1),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 20,
                                                top: 6,
                                                bottom: 6),
                                            child: Text(
                                              '${getdata.listactiongroup[i]['nameVi']}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    233, 4, 194, 1),
                                                fontSize: 14,
                                                height: 3 / 2,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )))
                                ],
                              )),
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 25, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Độ tuổi',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                height: 5 / 4,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 11, bottom: 19),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 11,
                                runSpacing: 10,
                                children: <Widget>[
                                  for (var i = 0;
                                      i < getdata.listage.length;
                                      i++)
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(226, 4, 190, 1),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 20,
                                                top: 6,
                                                bottom: 6),
                                            child: Text(
                                              '${getdata.listage[i]['age']['nameVi']}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    233, 4, 194, 1),
                                                fontSize: 14,
                                                height: 3 / 2,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )))
                                ],
                              )),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 30),
                    child: Column(children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 11),
                          child: Text('Mục tiêu',
                              style: TextStyle(
                                fontSize: 16,
                                height: 5 / 4,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ))),
                      for (var i = 0;
                          i < getdata.target['ops'].length;
                          i = i + 2)
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('${getdata.target['ops'][i]['insert']}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 5 / 4,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )))
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 30),
                    child: Column(children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 11),
                          child: Text('Công cụ',
                              style: TextStyle(
                                fontSize: 16,
                                height: 5 / 4,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ))),
                      if (getdata.tool != '')
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('${getdata.tool}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 5 / 4,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )))
                      else if (getdata.tool == '')
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Không cần công cụ gì',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 5 / 4,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )))
                    ]),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 17, left: 30, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 17),
                              child: Text('Vị trí',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 5 / 4,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ))),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 34,
                            children: [
                              for (var i = 0; i < getdata.listplace.length; i++)
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Image.network(
                                          getdata.listplace[i]['icon']),
                                    ),
                                    Container(
                                        child: Text(
                                            '${getdata.listplace[i]['nameVi']}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              height: 7 / 6,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                              color: Color.fromRGBO(
                                                  233, 4, 196, 1),
                                            )))
                                  ],
                                )
                            ],
                          )
                        ],
                      ))
                ]),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }),
      // child: Column(children: [
      //   Container(
      //     child: new Stack(
      //       children: <Widget>[
      //         new Container(
      //             alignment: Alignment.center,
      //             child: Image.network(
      //                 'https://s3-alpha-sig.figma.com/img/439e/6e55/489702b658f81ef35f57335a1b65e4ff?Expires=1670803200&Signature=SgMVzOLDkAYK8ODJlSdVeSvHN42zcXRz-PfBrSgduoIfG73~-g~z6qITbvdNAslzduiHvImgpiYdbL7CnqqerCNfVXr~X7VDkjbUMClGtunHj-vr-CPsOj3J002earh7FKCNzFHItN4nPJrAc-Dz7Bay27z7WD3RVYY7X6tHmMmSsbq79VteESNuCpyizmqp8digikvG5kOHw5LzR39ryfxvmRKUSWKl9fyHZFmZyFhYeezK4WPy9IVN4O9c6ic6WtCj0PAUkskKM89ur~jqcX6SQQnMoATTsR29Lqhf4vAQzq9JvlGFts78v37psndElBFUKvzvASmkGIe378CoKg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA')),
      //         //cover photo
      //         new Align(
      //           alignment: Alignment.topLeft,
      //           child: Container(
      //               padding: EdgeInsets.only(top: 43, left: 13),
      //               child: IconButton(
      //                   icon: Icon(
      //                     Icons.arrow_back,
      //                     color: Colors.white,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                   })),
      //         )
      //       ],
      //     ),
      //   ),
      //   Container(
      //       color: Color.fromRGBO(137, 0, 140, 0.87),
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Container(
      //                 padding: EdgeInsets.only(left: 30, top: 5, right: 10),
      //                 child: Text('Nhà sản xuất âm nhạc nhí', //title
      //                     style: TextStyle(
      //                       color: Color.fromRGBO(255, 255, 255, 1),
      //                       fontSize: 18,
      //                       height: 45 / 32,
      //                       fontWeight: FontWeight.w700,
      //                     )),
      //               ),
      //               Container(
      //                   padding: EdgeInsets.only(top: 5),
      //                   child: Image.asset('assets/images/Group1.png')),
      //             ],
      //           ),
      //           Container(
      //               padding: EdgeInsets.only(
      //                   left: 30, top: 2, bottom: 18, right: 30),
      //               child: Text(
      //                 'Cùng con làm nhà sản xuất âm nhạc từ các dụng cụ đơn giản hoặc đồ chơi quanh nhà', //description
      //                 style: TextStyle(
      //                   color: Color.fromRGBO(255, 255, 255, 1),
      //                   fontSize: 13,
      //                   height: 65 / 52,
      //                   fontWeight: FontWeight.w500,
      //                 ),
      //               )),
      //         ],
      //       )),
      //   Container(
      //       padding: EdgeInsets.only(left: 80, right: 90, top: 10, bottom: 10),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Container(
      //               child: Row(children: [
      //             Container(
      //                 padding: EdgeInsets.only(right: 4),
      //                 child: Image.asset('assets/images/Clock.png')),
      //             Text('15 phút',
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   height: 5 / 4,
      //                   fontWeight: FontWeight.w700,
      //                   color: Color.fromRGBO(0, 0, 0, 1),
      //                 ))
      //           ])),
      //           Container(
      //               child: Row(children: [
      //             Container(
      //                 padding: EdgeInsets.only(right: 4),
      //                 child: Image.asset('assets/images/Group.png')),
      //             Text('1 tuần/ lần',
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   height: 5 / 4,
      //                   fontWeight: FontWeight.w700,
      //                   color: Color.fromRGBO(0, 0, 0, 1),
      //                 ))
      //           ])),
      //           Container(
      //               child: Row(children: [
      //             Image.asset('assets/images/Group 8700.png'),
      //           ])),
      //         ],
      //       )),
      //   Container(
      //       width: MediaQuery.of(context).size.width,
      //       color: Color.fromRGBO(235, 235, 235, 1),
      //       child: Container(
      //         alignment: Alignment.center,
      //         padding: EdgeInsets.only(top: 7, bottom: 7),
      //         child: Text('Mô Tả',
      //             style: TextStyle(
      //               fontSize: 16,
      //               height: 5 / 4,
      //               fontWeight: FontWeight.w700,
      //               color: Color.fromRGBO(0, 0, 0, 1),
      //             )),
      //       )),
      //   Container(
      //       padding: EdgeInsets.only(left: 50, right: 56, top: 4, bottom: 13),
      //       child: Wrap(
      //         children: <Widget>[
      //           for (var i = 0; i < tagname.length; i++)
      //             Text(' #${tagname[i]}',
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   fontStyle: FontStyle.italic,
      //                   height: 7 / 6,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(135, 33, 176, 1),
      //                   fontFamily: 'Roboto',
      //                 )),
      //         ],
      //       )
      //       // Text(
      //       //     '#reggioemilia #merrychristmas #trendingwinter2022 #boyscout #newyeariscoming',
      //       //     style: TextStyle(
      //       //       fontSize: 12,
      //       //       fontStyle: FontStyle.italic,
      //       //       height: 7 / 6,
      //       //       fontWeight: FontWeight.w400,
      //       //       color: Color.fromRGBO(135, 33, 176, 1),
      //       //       fontFamily: 'Roboto',
      //       //     ))
      //       ),
      //   Container(
      //       width: MediaQuery.of(context).size.width,
      //       height: 46,
      //       padding: EdgeInsets.only(left: 7, right: 7),
      //       child: ElevatedButton(
      //           onPressed: () {},
      //           child: Text('Mời bạn đăng ký để học chơi nhé',
      //               style: TextStyle(
      //                 color: Color.fromRGBO(255, 255, 255, 1),
      //                 fontSize: 13,
      //                 height: 65 / 52,
      //                 fontWeight: FontWeight.w500,
      //               )))),
      //   Container(
      //       padding: EdgeInsets.only(top: 20, bottom: 23),
      //       child: Column(children: [
      //         Container(
      //             padding: EdgeInsets.only(bottom: 8),
      //             child: Text('Đóng góp bởi',
      //                 textAlign: TextAlign.justify,
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   height: 5 / 4,
      //                   color: Color.fromRGBO(0, 0, 0, 1),
      //                 ))),
      //         Container(
      //             width: 46,
      //             height: 51,
      //             child: Image.network(
      //                 'https://s3-alpha-sig.figma.com/img/f7c2/d059/058446b17cda9d9dc023b65aeaf6fb81?Expires=1671408000&Signature=etPvueTeu7DLn3T-kyFrM1AliLlaEmg4uGeQGSr~kv2r8hziCG6RU-CcD--ICp2tfMqYa8RRaSaEx5MBTDwYkiC7hjkntterGbu3UsgbV8LznbDSsHD8ze8U6o0crmH3xndPqJ2OEvnTDY4cj11jwq~LmWVe4qYXVqsYThKlh-iZxWqqnNElJDi4J2m5LvHeaQLW2OamcO0lTHk1aWY~zH~kdkb6VOz8C-roTg0rC~Ubru4tm7TODmBUL3yFFQsylJsVbe117eZIdxqOaP5TxElsMs81WdeYV~FPRw4OMkoL7MqYSjRVltKIPCUQTheE9aw4A58oxr4idKfmMwJnhQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'))
      //       ])),
      //   Container(
      //       width: MediaQuery.of(context).size.width,
      //       padding: EdgeInsets.only(left: 30),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text('Nhóm kỹ năng',
      //               textAlign: TextAlign.left,
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 height: 5 / 4,
      //                 fontWeight: FontWeight.w700,
      //                 color: Color.fromRGBO(0, 0, 0, 1),
      //               )),
      //           Container(
      //               height: 33,
      //               width: MediaQuery.of(context).size.width,
      //               padding: EdgeInsets.only(top: 11, bottom: 0),
      //               child: Wrap(
      //                 crossAxisAlignment: WrapCrossAlignment.start,
      //                 spacing: 11,
      //                 runSpacing: 10,
      //                 children: <Widget>[
      //                   for (var i = 0; i < skill.length; i++)
      //                     Container(
      //                         decoration: BoxDecoration(
      //                           border: Border.all(
      //                             color: Color.fromRGBO(226, 4, 190, 1),
      //                             width: 1,
      //                           ),
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(30)),
      //                         ),
      //                         child: Container(
      //                             padding: EdgeInsets.only(
      //                                 left: 15, right: 20, top: 6, bottom: 6),
      //                             child: Text(
      //                               '${skill[i]}',
      //                               style: TextStyle(
      //                                 color: Color.fromRGBO(233, 4, 194, 1),
      //                                 fontSize: 14,
      //                                 height: 3 / 2,
      //                                 fontWeight: FontWeight.w400,
      //                               ),
      //                             )))
      //                 ],
      //               )),
      //         ],
      //       )),
      //   Container(
      //       width: MediaQuery.of(context).size.width,
      //       padding: EdgeInsets.only(top: 25, left: 30),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text('Độ tuổi',
      //               textAlign: TextAlign.left,
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 height: 5 / 4,
      //                 fontWeight: FontWeight.w700,
      //                 color: Color.fromRGBO(0, 0, 0, 1),
      //               )),
      //           Container(
      //               height: 33,
      //               width: MediaQuery.of(context).size.width,
      //               padding: EdgeInsets.only(top: 11, bottom: 19),
      //               child: Wrap(
      //                 crossAxisAlignment: WrapCrossAlignment.start,
      //                 spacing: 11,
      //                 runSpacing: 10,
      //                 children: <Widget>[
      //                   for (var i = 0; i < age.length; i++)
      //                     Container(
      //                         decoration: BoxDecoration(
      //                           border: Border.all(
      //                             color: Color.fromRGBO(226, 4, 190, 1),
      //                             width: 1,
      //                           ),
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(30)),
      //                         ),
      //                         child: Container(
      //                             padding: EdgeInsets.only(
      //                                 left: 15, right: 20, top: 6, bottom: 6),
      //                             child: Text(
      //                               '${age[i]}',
      //                               style: TextStyle(
      //                                 color: Color.fromRGBO(233, 4, 194, 1),
      //                                 fontSize: 14,
      //                                 height: 3 / 2,
      //                                 fontWeight: FontWeight.w400,
      //                               ),
      //                             )))
      //                 ],
      //               )),
      //         ],
      //       )),
      //   Container(
      //     padding: EdgeInsets.only(top: 24, left: 30),
      //     child: Column(children: [
      //       Container(
      //           width: MediaQuery.of(context).size.width,
      //           padding: EdgeInsets.only(bottom: 11),
      //           child: Text('Mục tiêu',
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 height: 5 / 4,
      //                 fontWeight: FontWeight.w700,
      //                 color: Color.fromRGBO(0, 0, 0, 1),
      //               ))),
      //       for (var i = 0; i < target.length; i++)
      //         Container(
      //             width: MediaQuery.of(context).size.width,
      //             child: Text('- ${target[i]}',
      //                 textAlign: TextAlign.left,
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   height: 5 / 4,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(0, 0, 0, 1),
      //                 )))
      //     ]),
      //   ),
      //   Container(
      //     padding: EdgeInsets.only(top: 24, left: 30),
      //     child: Column(children: [
      //       Container(
      //           width: MediaQuery.of(context).size.width,
      //           padding: EdgeInsets.only(bottom: 11),
      //           child: Text('Công cụ',
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 height: 5 / 4,
      //                 fontWeight: FontWeight.w700,
      //                 color: Color.fromRGBO(0, 0, 0, 1),
      //               ))),
      //       for (var i = 0; i < tools.length; i++)
      //         Container(
      //             width: MediaQuery.of(context).size.width,
      //             child: Text('- ${tools[i]}',
      //                 textAlign: TextAlign.left,
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   height: 5 / 4,
      //                   fontWeight: FontWeight.w400,
      //                   color: Color.fromRGBO(0, 0, 0, 1),
      //                 )))
      //     ]),
      //   ),
      //   Container(
      //       width: MediaQuery.of(context).size.width,
      //       padding: EdgeInsets.only(top: 17, left: 30, bottom: 25),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Container(
      //               padding: EdgeInsets.only(bottom: 17),
      //               child: Text('Vị trí',
      //                   style: TextStyle(
      //                     fontSize: 16,
      //                     height: 5 / 4,
      //                     fontWeight: FontWeight.w700,
      //                     color: Color.fromRGBO(0, 0, 0, 1),
      //                   ))),
      //           Wrap(
      //             crossAxisAlignment: WrapCrossAlignment.start,
      //             spacing: 34,
      //             children: [
      //               for (var i = 0; i < local.length; i++)
      //                 Column(
      //                   children: [
      //                     Container(
      //                       padding: EdgeInsets.only(bottom: 15),
      //                       child: Image.asset('${local[i]['image']}'),
      //                     ),
      //                     Container(
      //                         child: Text('${local[i]['name']}',
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               height: 7 / 6,
      //                               fontWeight: FontWeight.w400,
      //                               fontStyle: FontStyle.italic,
      //                               color: Color.fromRGBO(233, 4, 196, 1),
      //                             )))
      //                   ],
      //                 )
      //             ],
      //           )
      //         ],
      //       )
      //       )
      // ]),
    ));
  }
}