import 'package:bkash_ui/baseurl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BigBannerWidget extends StatefulWidget {
  const BigBannerWidget({Key? key}) : super(key: key);

  @override
  State<BigBannerWidget> createState() => _BigBannerWidgetState();
}

class _BigBannerWidgetState extends State<BigBannerWidget> {
  String? beritaList = '';
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Ganti dengan URL lokal kamu
    try {
      final response = await dio.get('${urllokal}banners');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        setState(() {
          beritaList = data[0]['photo'];
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
    print("${urllokalImage}/${beritaList}");
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(
        '${urllokalImage}/${beritaList}', // Ganti dengan path big banner di assets kamu
        height: 120,
        width: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/big_banner.jpg', // Ganti dengan path big banner di assets kamu
            height: 120,
            width: 200,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
