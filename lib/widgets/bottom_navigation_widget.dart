import 'package:bkash_ui/pages/inbox_page.dart';
import 'package:bkash_ui/widgets/appbar_widget.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      activeColor: Color.fromARGB(255, 11, 226, 65),
      inActiveColor: Colors.black45,
      appBarItems: [
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.home,
              size: 30,
              color: Color.fromARGB(255, 11, 226, 65),
            ),
            inActiveIcon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black26,
            ),
            text: 'Home'),
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.insert_comment,
              size: 30,
              color: Color.fromARGB(255, 11, 226, 65),
            ),
            inActiveIcon: Icon(
              Icons.insert_comment,
              size: 30,
              color: Colors.black26,
            ),
            text: 'Informasi'),
      ],
      bodyItems: [
        AppBarWidget(),
        InboxPage(),
      ],
      actionBarView: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.orange,
      ),
    );
  }
}
