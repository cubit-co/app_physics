import 'package:app_physics/services/dashboard_service.dart';
import 'package:app_physics/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_physics/widget/card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoading = true;
  final dashboardService = new DashboardService();
  dynamic data;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    DateTime date = DateTime.now();
    if (date.day > 12) {
      _tabController.animateTo(2);
    } else if (date.day > 11) {
      _tabController.animateTo(1);
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Congreso 2020'),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: "Dia 1",
                ),
                Tab(
                  text: "Dia 2",
                ),
                Tab(
                  text: "Dia 3",
                ),
              ],
            )),
        drawer: AccountDrawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return CardList(
                          id: data[0][index]['_id'],
                          name: data[0][index]['name'],
                          date:
                              DateTime.parse(data[0][index]['date']).toLocal(),
                          url: data[0][index]['url'],
                          author: data[0][index]['author'],
                          zoomId: data[0][index]['zoomId'],
                        );
                      },
                      itemCount: data[0].length),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return CardList(
                          id: data[1][index]['_id'],
                          name: data[1][index]['name'],
                          date:
                              DateTime.parse(data[1][index]['date']).toLocal(),
                          url: data[1][index]['url'],
                          author: data[1][index]['author'],
                          zoomId: data[1][index]['zoomId'],
                        );
                      },
                      itemCount: data[1].length),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return CardList(
                          id: data[2][index]['_id'],
                          name: data[2][index]['name'],
                          date:
                              DateTime.parse(data[2][index]['date']).toLocal(),
                          url: data[2][index]['url'],
                          author: data[2][index]['author'],
                          zoomId: data[2][index]['zoomId'],
                        );
                      },
                      itemCount: data[2].length),
                ],
              ));
  }

  getData() async {
    try {
      dynamic d = await dashboardService.getDashboard();
      setState(() {
        data = d;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
