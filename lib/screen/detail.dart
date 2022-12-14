import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../components/callapi.dart';

class DetailPage extends StatelessWidget {
  final dataKey;
  DetailPage({Key? key, required this.dataKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (dataKey != 0) {
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
                                  child:
                                      Image.asset('assets/images/Clock.png')),
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
                                  child:
                                      Image.asset('assets/images/Group.png')),
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
                                              color: Color.fromRGBO(
                                                  226, 4, 190, 1),
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
                                              color: Color.fromRGBO(
                                                  226, 4, 190, 1),
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
                              child:
                                  Text('${getdata.target['ops'][i]['insert']}',
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
                                for (var i = 0;
                                    i < getdata.listplace.length;
                                    i++)
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
        //
        // ]),
      ));
    } else {
      return Container(
        child: Text('d'),
      );
    }
  }
}
