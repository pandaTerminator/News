import 'package:flutter/material.dart';
import 'package:news/pages/home.dart';
import 'package:news/pages/technology.dart';

class TabBarMain extends StatefulWidget {
  const TabBarMain({Key key}) : super(key: key);
  @override
  _TabBarMainState createState() => _TabBarMainState();
}

class _TabBarMainState extends State<TabBarMain>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'All'),
    Tab(text: 'Technology'),
  ];

  final tabChildren = [
    MyHomePage(),
    TechnologyPage(title: 'Home'),
  ];

  TabController _tabController;

  String _titleText = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_clickChangeTab);
  }

  _clickChangeTab() {
    setState(() {
      _titleText = myTabs[_tabController.index].text;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
        title: Text(_titleText),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabChildren,
      ),
    );
  }
}
