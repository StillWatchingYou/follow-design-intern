import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../components/callapi.dart';
import './detail.dart';

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