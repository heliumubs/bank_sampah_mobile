import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Content {
  final String title;
  final String category;
  final String author;

  Content({
    required this.title,
    required this.category,
    required this.author,
  });
}

class MyApp extends StatelessWidget {
  final List<Content> contents = [
    Content(
      title: 'Pengelolaan Sampah Rumah Tangga',
      category: 'Rumah Tangga',
      author: 'Anita',
    ),
    Content(
      title: 'Pengurangan Sampah Plastik',
      category: 'Lingkungan',
      author: 'Budi',
    ),
    Content(
      title: 'Komposisi Sampah Organik',
      category: 'Pertanian',
      author: 'Citra',
    ),
    Content(
      title: 'Pengolahan Sampah Elektronik',
      category: 'Teknologi',
      author: 'David',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edukasi Sampah'),
        ),
        body: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(contents[index].title),
              subtitle: Text(
                  '${contents[index].category} oleh ${contents[index].author}'),
              onTap: () {
                // Tambahkan logika untuk menangani ketika item list ditekan
                // Contohnya bisa menampilkan detail konten atau navigasi ke halaman lain.
                print('Tapped ${contents[index].title}');
              },
            );
          },
        ),
      ),
    );
  }
}
