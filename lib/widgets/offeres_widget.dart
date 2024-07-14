import 'dart:convert';

import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/data/offers_card_data.dart';
import 'package:bkash_ui/widgets/offers_card_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/home_page_first_part_data.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({Key? key}) : super(key: key);

  @override
  State<OffersWidget> createState() => _MyBkashWidgetState();
}

class _MyBkashWidgetState extends State<OffersWidget> {
  List<dynamic> beritaList = [];
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Ganti dengan URL lokal kamu
    try {
      final response = await dio.get('${urllokal}beritas');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          beritaList = data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.grey),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Berita',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   'Lihat Semua',
                  //   style: TextStyle(
                  //       color: Color.fromARGB(255, 11, 226, 65), fontWeight: FontWeight.w500),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            width: 900,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.grey),
            ),
            height: 290,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: beritaList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var berita = beritaList[index];
                  return OffersCard(
                    title: berita['title'],
                    content: berita['content'],
                    photoUrl: '${urllokalImage}/${berita['photo']}',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
