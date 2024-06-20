import 'package:flutter/material.dart';
import 'main.dart';

class DetailArtikelPage extends StatelessWidget {
  final Artikel artikel;

  DetailArtikelPage({required this.artikel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artikel.title),
        leading: IconButton(
          icon: Image.asset('assets/back.png'), // Menggunakan ikon bawaan Flutter
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artikel.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.asset(
              artikel.imagePath,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              artikel.isiartikels,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}