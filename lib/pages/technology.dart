import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:news/utils/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TechnologyList {
  final int id;
  final String url;
  final String title;

  TechnologyList({this.id, this.url, this.title});

  TechnologyList.fromJson(Map json)
      : id = json['id'],
        url = json['url'],
        title = json['title'];

  Map toJson() {
    return {'id': id, 'url': url, 'title': title};
  }
}

class TechnologyPage extends StatefulWidget {
  TechnologyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TechnologyPageState createState() => _TechnologyPageState();
}

class _TechnologyPageState extends State<TechnologyPage>
    with TickerProviderStateMixin {
  var technologyList = new List<TechnologyList>();

  bool isLoading = false;

  _getNewList() {
    isLoading = true;
    API.getNewList().then((response) {
      setState(() {
        isLoading = false;
        Iterable list = json.decode(response.body);
        technologyList =
            list.map((model) => TechnologyList.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getNewList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitFadingCircle(
            color: Colors.pink[200],
            size: 50.0,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
          )
        : Scaffold(
            body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: technologyList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(technologyList[index].title),
                    onTap: () => launch(technologyList[index].url),
                  ),
                  Divider()
                ],
              );
            },
          ));
  }
}
