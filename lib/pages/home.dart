import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:news/utils/api.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeList {
  final int id;
  final String url;
  final String title;

  HomeList({this.id, this.url, this.title});

  HomeList.fromJson(Map json)
      : id = json['id'],
        url = json['url'],
        title = json['title'];

  Map toJson() {
    return {'id': id, 'url': url, 'title': title};
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var homeList = new List<HomeList>();

  _getUsers() {
    API.getNewList().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        homeList = list.map((model) => HomeList.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: homeList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(homeList[index].title),
                  onTap: () => launch(homeList[index].url),
                ),
                Divider()
              ],
            );
          },
        ));
  }
}
