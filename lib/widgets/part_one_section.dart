import 'dart:convert';

import 'package:bkash_ui/pages/SendMoney_Page.dart';
import 'package:bkash_ui/pages/akun/akun_page.dart';
import 'package:bkash_ui/pages/edukasi_sampah/edukasi_sampah.dart';
import 'package:bkash_ui/pages/inbox_page.dart';
import 'package:bkash_ui/pages/jenis_sampah/jenis_sampah.dart';
import 'package:bkash_ui/pages/koin/koin.dart';
import 'package:bkash_ui/pages/lokasi/lokasi.dart';
import 'package:bkash_ui/pages/magot/magot_model.dart';
import 'package:bkash_ui/pages/magot/magot_page.dart';
import 'package:bkash_ui/pages/pupuk/pupuk_model.dart';
import 'package:bkash_ui/pages/pupuk/pupuk_screen.dart';
import 'package:bkash_ui/pages/sampah/sampah.dart';
import 'package:bkash_ui/pages/transaksi/transaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home_page_first_part_data.dart';

class PartOneHome extends StatefulWidget {
  const PartOneHome({Key? key}) : super(key: key);

  @override
  State<PartOneHome> createState() => _PartOneHomeState();
}

class _PartOneHomeState extends State<PartOneHome> {
  bool isExpanded = false;
  String? role;
  int? id;
//see more toggle
  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRole();
  }

  //loading part
  void showLoadingAnimation(BuildContext context, int index, String role) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (context) {
        return Center(
          child: Image(image: AssetImage('assets/loading.gif')),
        );
      },
    );

    // Simulate a short delay before navigating
    Future.delayed(Duration(seconds: 1), () {
      // Hide the loading animation dialog
      Navigator.of(context).pop();

      // Determine the destination page based on index and role
      Widget destinationPage;
      if (role == 'admin') {
        // Define your admin menu destinations here
        switch (index) {
          case 0:
            destinationPage =
                EdukasiSampah(); // Example destination for admin index 0
            break;
          case 1:
            destinationPage =
                JenisSampah(); // Example destination for admin index 1
            break;
          case 2:
            destinationPage =
                SampahPage(); // Example destination for admin index 1
            break;
          case 3:
            destinationPage =
                TransaksiPage(); // Example destination for admin index 1
            break;
          case 4:
            destinationPage =
                LokasiPage(); // Example destination for admin index 1
            break;
          case 5:
            destinationPage = UserDataPage(
              userData: id.toString(),
            ); // Example destination for admin index 1
            break;
          case 6:
            destinationPage =
                KoinPage(); // Example destination for admin index 1
            break;
          default:
            destinationPage = EdukasiSampah(); // Default to EdukasiSampah page
        }
      } else {
        // Define your user menu destinations here
        switch (index) {
          case 0:
            destinationPage =
                EdukasiSampah(); // Example destination for admin index 0
            break;
          case 1:
            destinationPage =
                JenisSampah(); // Example destination for admin index 1
            break;
          case 2:
            destinationPage =
                SampahPage(); // Example destination for admin index 1
            break;
          case 3:
            destinationPage =
                TransaksiPage(); // Example destination for admin index 1
            break;
          case 4:
            destinationPage =
                LokasiPage(); // Example destination for admin index 1
            break;
          case 5:
            destinationPage = UserDataPage(
              userData: id.toString(),
            ); // Example destination for admin index 1
            break;
          case 6:
            destinationPage =
                KoinPage(); // Example destination for admin index 1
            break;
          case 7:
            destinationPage =
                MagotScreen(); // Example destination for admin index 1
            break;
          case 8:
            destinationPage =
                PupukScreen(); // Example destination for admin index 1
            break;
          default:
            destinationPage = EdukasiSampah(); // Default to EdukasiSampah page
        }
      }
      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );
    });
  }

  Future<void> _loadRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? userDataString = prefs.getString('userData');
      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          role = userData['data']['role'];
          id = userData['data']['id'];
        });
      } else {
        role = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight =
        isExpanded ? 550 : 240; // Adjust the heights as needed
    return Container(
      height: containerHeight,
      padding: EdgeInsets.all(0.0), // Add padding for the shadow effect
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                child: GridView.builder(
                  physics:
                      NeverScrollableScrollPhysics(), //cannot scroll the gridview section
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Check if the first item is tapped (index 0)
                        showLoadingAnimation(context, index, role ?? '');
                        // You can add similar navigation logic for other items here
                      },
                      child: Container(
                        child: role == 'admin'
                            ? menuodelAdmin[index]
                            : menuodelUser[index],
                      ),
                    );
                  },
                  itemCount: role == 'admin'
                      ? menuodelAdmin.length
                      : menuodelUser.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                ),
              ),
            ),
            if (isExpanded)
              Positioned(
                top: 500.0,
                right: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .white, // Set the button background color to white
                    elevation: 1, // Remove the default button elevation
                    shadowColor: Colors
                        .transparent, // Make the button's shadow transparent
                  ),
                  onPressed: toggleExpansion,
                  child: Text(isExpanded ? 'Sembunyikan' : 'Lihat Semua',
                      style:
                          TextStyle(color: Color.fromARGB(255, 11, 226, 65))),
                ),
              )
            else
              Positioned(
                top: 190.0,
                right: 130,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(2, 6),
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 96,
                          spreadRadius: 3),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .white, // Set the button background color to white
                      elevation: 1, // Remove the default button elevation
                      shadowColor: Colors
                          .transparent, // Make the button's shadow transparent
                    ),
                    onPressed: toggleExpansion,
                    child: Text(isExpanded ? 'Sembunyikan' : 'Lihat Semua',
                        style:
                            TextStyle(color: Color.fromARGB(255, 11, 226, 65))),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
