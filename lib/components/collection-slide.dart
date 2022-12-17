import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/callapi.dart';
import 'package:flutter_application_1/components/slider.dart';

import '../screen/more.dart';

class CollectionSlide extends StatelessWidget {
  const CollectionSlide({required this.collectionData, super.key});

  final SlideContent collectionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
            padding: EdgeInsets.only(left: 31, top: 18, right: 26, bottom: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${collectionData.nameVi}',
                    style: const TextStyle(
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
                                    Clickdots(dataKey: collectionData.collid)));
                      },
                      child: const Text(
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
              listImage: collectionData.listContent,
              height: 142,
              id: 'id',
              image: 'thumnail',
              viewportFraction: 0.3,
            ))
      ]),
    );
  }
}
