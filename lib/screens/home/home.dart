import 'package:bakeryapp/screens/home/home_tab.dart';
import 'package:bakeryapp/screens/history/history.dart';
import 'package:bakeryapp/screens/menu/menu.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 0;
  List<StatefulWidget> pages = [HomeTab(), MenuTab(), HistoryTab()];

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.black87,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.black87,
                  primaryColor: Colors.white,
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: TextStyle(color: Colors.white54))),
              child: BottomNavigationBar(
                currentIndex: page,
                onTap: (int index) {
                  setState(() {
                    CircularProgressIndicator();
                    page = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), title: Text("Order")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), title: Text("History")),
                ],
              ),
            ),
            body: pages[page],
        )
    );
  }
}
