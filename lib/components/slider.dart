import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/screen/detail.dart';

class SliderImage1 extends StatelessWidget {
  final List<dynamic> listImage;
  final double height;
  final dynamic id;
  final String image;
  final double viewportFraction;
  const SliderImage1(
      {Key? key,
      required this.listImage,
      required this.height,
      required this.id,
      required this.image,
      required this.viewportFraction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: listImage
            .map((e) => ClipRRect(
                  child: Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                // spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(
                                    0, 0.75), // changes position of shadow
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
                                            DetailPage(dataKey: e[id])));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(e[image]))))
                    ],
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: height,
          viewportFraction: viewportFraction,
          enlargeCenterPage: false,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
      ),
    );
  }
}


class SliderImage2 extends StatelessWidget {
  final List<dynamic> listImage;
  final double height;
  final dynamic id;
  final String image;
  final double viewportFraction;
  const SliderImage2(
      {Key? key,
      required this.listImage,
      required this.height,
      required this.id,
      required this.image,
      required this.viewportFraction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: listImage
            .map((e) => ClipRRect(
                  child: Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                // spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(
                                    0, 0.75), // changes position of shadow
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
                                            DetailPage(dataKey: e.id)));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(e.image))))
                    ],
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: height,
          viewportFraction: viewportFraction,
          enlargeCenterPage: false,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
      ),
    );
  }
}
