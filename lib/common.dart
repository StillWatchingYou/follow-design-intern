import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<List<ImageCenter>> createImageCenter() async {
  final response = await http.post(
      Uri.parse(
          'https://services-test.theraise.app/pubservices/s/content/getTrial'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        "collectionlist": {"pagesize": 10, "pageindex": 1}
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
    var x = jsonResponse.map((data) => new ImageCenter.fromJson(data)).toList();
    print(x);
    return x;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class ImageCenter {
  final String nameVi;
  final String banner;
  final dynamic id;
  const ImageCenter(
      {required this.nameVi, required this.banner, required this.id});
  factory ImageCenter.fromJson(Map<String, dynamic> json) {
    return ImageCenter(
        nameVi: json['nameVi'], banner: json['banner'], id: json['_id']);
  }
}

Future<List<FetchData>> createFetchData(String id) async {
  final response = await http.post(
      Uri.parse(
          'https://services-test.theraise.app/pubservices/s/content/searchreturnmoreinfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        "contentlist": {
          "content": {"_id": id},
          "pagesize": 0,
          "pageindex": 0
        }
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;

    return jsonResponse.map((data) => new FetchData.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class FetchData {
  final String coverimage;
  final String nameVi;
  final String description;
  final List tag;
  final int time;
  final int frequency;
  final int timesuggest;
  final List listplace;
  final List listactiongroup;
  final List listage;
  final List listpartner;
  final dynamic tool;
  final dynamic target;
  const FetchData({
    required this.coverimage,
    required this.nameVi,
    required this.description,
    required this.tag,
    required this.time,
    required this.frequency,
    required this.timesuggest,
    required this.listplace,
    required this.listactiongroup,
    required this.listage,
    required this.listpartner,
    required this.tool,
    required this.target,
  });
  factory FetchData.fromJson(Map<String, dynamic> json) {
    return FetchData(
      coverimage: json['banner'],
      nameVi: json['nameVi'],
      description: json['description'],
      tag: json['tag'],
      time: json['time'],
      frequency: json['frequency'],
      timesuggest: json['timesuggest'],
      listplace: json['listplace'],
      listactiongroup: json['listactiongroup'],
      listage: json['listage'],
      listpartner: json['listpartner'],
      tool: json['tool'],
      target: json['target']
    );
  }
}

Future<List<SlideContent>> createSlideContent() async {
  final response = await http.post(
      Uri.parse(
          'https://services-test.theraise.app/pubservices/s/collection/getrecommendtrial'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        "collectionlist": {"pagesize": 10, "pageindex": 1}
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
    var x =
        jsonResponse.map((data) => new SlideContent.fromJson(data)).toList();
    print(x);
    return x;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class SlideContent {
  final String nameVi;
  final List listContent;
  final dynamic collid;
  final dynamic id;
  const SlideContent(
      {required this.nameVi,
      required this.listContent,
      required this.collid,
      required this.id});
  factory SlideContent.fromJson(Map<String, dynamic> json) {
    return SlideContent(
        nameVi: json['nameVi'],
        listContent: json['listContent'],
        collid: json['collid'],
        id: json['_id']);
  }
}

Future<InDots> createInDots(String collid) async {
  final response = await http.post(
      Uri.parse(
          'https://services-test.theraise.app/pubservices/s/collection/viewallonecoll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        "collectionlist": {"collid": collid, "model": "collection"}
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> jsonResponse =
        json.decode(utf8.decode(response.bodyBytes));
    // var x = jsonResponse.map((data) => new InDots.fromJson(data)).toList();
    var x = InDots.fromJson(jsonResponse);
    print(x);
    return x;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class InDots {
  final String nameVi;
  final List<dynamic> listContent;
  final id;
  const InDots(
      {required this.nameVi, required this.listContent, required this.id});
  factory InDots.fromJson(Map<String, dynamic> json) {
    return InDots(
        nameVi: json['nameVi'],
        listContent: json['listContent'],
        id: json['_id']);
  }
}

Future<List<SlideBanner>> createSlideBanner() async {
  final response = await http.post(
      Uri.parse(
          'https://services-test.theraise.app/pubservices/s/imagecenter/getTrial'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
    var x = jsonResponse.map((data) => new SlideBanner.fromJson(data)).toList();

    return jsonResponse.map((data) => new SlideBanner.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load ');
  }
}

class SlideBanner {
  final String url;
  final dynamic id;
  const SlideBanner({required this.url, required this.id});
  factory SlideBanner.fromJson(Map<String, dynamic> json) {
    return SlideBanner(url: json['url'], id: json['_id']);
  }
}