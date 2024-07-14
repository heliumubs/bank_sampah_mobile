import 'package:bkash_ui/baseurl.dart';
import 'package:bkash_ui/pages/pupuk/pupuk_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PupukScreen extends StatefulWidget {
  // PupukScreen({required this.pupuk});

  @override
  State<PupukScreen> createState() => _PupukScreenState();
}

class _PupukScreenState extends State<PupukScreen> {
  bool isLoading = true;
  List<PupukModel> pupukList = [];

  // Instance Dio
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchPupuk();
  }

  Future<void> _fetchPupuk() async {
    try {
      final response = await dio.get('${urllokal}pupuks');
      if (response.statusCode == 200) {
        setState(() {
          // Konversi respons JSON menjadi list of PupukModel
          pupukList = (response.data as List)
              .map((item) => PupukModel.fromJson(item))
              .toList();
          isLoading = false;
        });
      } else {
        print('Gagal mengambil data Pupuk');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Daftar Pupuk'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pupukList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pupukList[index].nama),
                  subtitle: Text(pupukList[index].jenis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PupukDetailScreen(pupuk: pupukList[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PupukDetailScreen extends StatelessWidget {
  final PupukModel pupuk;

  PupukDetailScreen({required this.pupuk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Pupuk Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 16.0),
            Text(
              'Nama: ${pupuk.nama}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Jenis: ${pupuk.jenis}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Deskripsi: ${pupuk.deskripsi}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Fungsi: ${pupuk.fungsi}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Updated At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(pupuk.updatedAt)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            Text(
              'Created At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(pupuk.createdAt)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
