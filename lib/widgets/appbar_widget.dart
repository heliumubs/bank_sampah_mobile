import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/utilis/curved_navbar_utilis.dart';
import 'package:bkash_ui/widgets/banner_widget.dart';
import 'package:bkash_ui/widgets/big_banner_widget.dart';
import 'package:bkash_ui/widgets/bottom_navigation_widget.dart';
import 'package:bkash_ui/widgets/drawerHead_widget.dart';
import 'package:bkash_ui/widgets/last_section.dart';
import 'package:bkash_ui/widgets/more_section_widget.dart';
import 'package:bkash_ui/widgets/my_Bkash_widget.dart';
import 'package:bkash_ui/widgets/part_one_section.dart';
import 'package:bkash_ui/widgets/suggestion.widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'offeres_widget.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> {
  final GlobalKey<AppBarWidgetState> appBar_key =
      new GlobalKey<AppBarWidgetState>();
  bool _isAnimation = false;
  bool _isBalanceShown = false;
  bool _isBalance = true;
  String? nama = '';
  String? id = '';
  String? koin = '';
  final dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? userDataString = prefs.getString('userData');
      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          nama = userData['data']['name'];
          id = userData['data']['id'].toString();
        });
      } else {
        nama = '';
      }
    });
    try {
      print("${urllokal}koins/$id");
      final response = await dio.get('${urllokal}koins/total/$id');
      print("++++++++++++++++++++++++++++++++++");
      print(response.data[0]['total_jumlah']);
      print("++++++++++++++++++++++++++++++++++");
      if (response.statusCode == 200) {
        final data = response.data;
        koin = data[0]['total_jumlah'] ?? "0";
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: CurvedAppBarShape(),
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 11, 226, 65),
        key: appBar_key,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 12.0, bottom: 4.0),
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage('assets/logo/akun.png'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //User Name
                    Text(
                      ' $nama',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    //Button
                    InkWell(
                        onTap: animate,
                        child: Container(
                            width: 150,
                            height: 28,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child:
                                Stack(alignment: Alignment.center, children: [
                              //Amount
                              AnimatedOpacity(
                                  opacity: _isBalanceShown ? 1 : 0,
                                  duration: Duration(milliseconds: 500),
                                  child: Text('Rp . $koin',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 11, 226, 65),
                                          fontSize: 14))),

                              //Balance
                              AnimatedOpacity(
                                  opacity: _isBalance ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Text('Lihat Nominal',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 11, 226, 65),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800))),

                              //Circle
                              AnimatedPositioned(
                                  duration: const Duration(milliseconds: 1100),
                                  left: _isAnimation == false ? 5 : 130,
                                  curve: Curves.fastOutSlowIn,
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      // padding: const EdgeInsets.only(bottom: 4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 11, 226, 65),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const FittedBox(
                                          child: Text('Tap',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17)))))
                            ])))
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 12.0, right: 12.0),
          //   child: InkWell(
          //     child: SizedBox(
          //         width: 34,
          //         height: 34,
          //         child: Image.asset('assets/rewards.png')),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 12.0),
            child: InkWell(
              onTap: () {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.closeEndDrawer();
                  //close drawer, if drawer is open
                } else {
                  scaffoldKey.currentState!.openEndDrawer();
                  //open drawer, if drawer is closed
                }
              },
              child: SizedBox(
                  width: 34,
                  height: 34,
                  child: Image.asset('assets/logo/logo.png')),
            ),
          )
        ],
      ),
      endDrawer: DrawerWidget(),
      body: ListView(
        children: [
          PartOneHome(),
          SizedBox(
            height: 9,
          ),
          // MyBkashWidget(),
          SizedBox(
            height: 3,
          ),
          // BannerWidget(),
          SizedBox(
            height: 9,
          ),
          // SuggestionWidget(),
          OffersWidget(),
          // MoreSectionWidtget(),
          // BigBannerWidget(),
          // LastSectionWidget(),
        ],
      ),
    );
  }

  void animate() async {
    _isAnimation = true;
    _isBalance = false;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 800),
        () => setState(() => _isBalanceShown = true));
    await Future.delayed(
        Duration(seconds: 3), () => setState(() => _isBalanceShown = false));
    await Future.delayed(Duration(milliseconds: 200),
        () => setState(() => _isAnimation = false));
    await Future.delayed(
        Duration(milliseconds: 800), () => setState(() => _isBalance = true));
  }
}
