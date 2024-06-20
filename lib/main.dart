import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugarcareapp/profil.dart';
import 'record_page.dart';
import 'diamedpage.dart'; // Import halaman DiaMed
import 'diashare_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailartikel.dart';
import 'profil.dart';

void main() {
  runApp(SugarCareApp());
}

class SugarCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MaterialApp(
        title: 'sugarcare',
        theme: ThemeData(
          primaryColor: Color(0xFFFFDFEB),
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
        ),
        home: HomePage(), // Menetapkan HomePage sebagai halaman utama
        routes: {
          '/record': (context) => RecordPage(),
          '/diamed': (context) => DiaMedPage(), // Menambahkan route untuk DiaMed
          '/diashare': (context) => DiaSharePage(),
          '/profil': (context) => ProfilePage(),
        },
      ),
    );
  }
}

class DiaTrack extends StatefulWidget {
  @override
  _DiaTrackState createState() => _DiaTrackState();
}

class _DiaTrackState extends State<DiaTrack> {
  Color _backgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  Color _iconColor = Color.fromARGB(255, 200, 96, 120);
  String _label = 'DiaTrack';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MaterialApp(
        title: 'DiaTrack',
        theme: ThemeData(
          primaryColor: Color(0xFF489D26),
          secondaryHeaderColor: Color(0xFF9D0063),
          scaffoldBackgroundColor: _backgroundColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Color(0xFF489D26)),
            bodyText2: TextStyle(color: Color(0xFF9D0063)),
          ),
          appBarTheme: AppBarTheme(
            color: Color(0xFF489D26),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF9D0063),
          ),
        ),
        home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Track your blood sugar',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Mengubah warna teks judul AppBar
          ),
          leading: IconButton(
            icon: Image.asset('assets/back.png'), // Menambahkan ikon gambar aset back.png
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
          backgroundColor: Colors.white, // Mengubah warna latar belakang AppBar
        ),
        body: RecordPage(),
      ),
      ),
    );
  }

  void _changeUI() {
    setState(() {
      _backgroundColor = Colors.greenAccent;
      _iconColor = Colors.white;
      _label = 'DiaTrack Clicked';
    });
  }
}


class DiaSharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DiaShare'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Image.asset('assets/back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange[50],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punya Pertanyaan Terkait Kelola Gula Darah dan Lainnya?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Silahkan bahas & tanyakan di forum'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumDetailPage(
                            name: 'Aminah',
                            tag: 'Diabetesesi',
                            date: '2 Jun 2024, 06:36',
                            title: 'Diet DM',
                            content: 'Saya DM dgn HBA1C NGSP 6,6 dan NGSP IFCC 49, mau tanya brp kalori perhari? Tks',
                            responses: [
                              {
                                'name': 'dr. Muhammad Rizqan Ramadhan, Sp.PD',
                                'tag': 'Ahli',
                                'date': '2 Jun 2024, 07:40',
                                'content': 'Salam Sehat. Untuk pengaturan Diet pada pasien DM hampir sama dengan pengaturan diet untuk masyarakat pada umumnya, dengan gizi seimbang dengan memperhatikan keteraturan jadwal makan dan jenis makanan sesuai kebutuhan masing-masing. Sebaiknya dikonsultasikan dengan ahli gizi (Nutrisionis/dietisian) atau dokter spesialis Gizi Klinik untuk lebih rinci dalam mengatur kalori dan takaran masing-masing zat makanan. Semoga membantu. Salam Sehat.',
                              },
                              {
                                'name': 'dr. Siti Maemunah, Sp.GK',
                                'tag': 'Ahli Gizi',
                                'date': '2 Jun 2024, 08:00',
                                'content': 'Selamat pagi. Pada pasien diabetes, penting untuk menjaga asupan kalori sesuai dengan kebutuhan harian yang dihitung berdasarkan berat badan, tinggi badan, usia, dan tingkat aktivitas fisik. Biasanya, kebutuhan kalori harian untuk wanita dewasa dengan aktivitas ringan sekitar 1.800-2.000 kalori, namun sebaiknya dilakukan konsultasi dengan ahli gizi untuk penyesuaian yang lebih tepat. Salam sehat.',
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    child: ForumPost(
                      name: 'Aminah',
                      tag: 'Diabetesesi',
                      date: '2 Jun 2024, 06:36',
                      title: 'Diet DM',
                      content: 'Saya DM dgn HBA1C NGSP 6,6 dan NGSP IFCC 49, mau tanya brp kalori perhari? Tks',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumDetailPage(
                            name: 'Muhamad Umar Chatab',
                            tag: 'Diabetesesi',
                            date: '19 Mei 2024, 13:58',
                            title: 'Olahraga angkat beban bisa menurunkan gula darah dgn cepat?',
                            content: 'Assalamualaikum dokter dan kawan-kawan diabetasi semuanya! Pagi ini saya seperti biasa suntik insulin Novomix 20 unit & minum 1 tablet Gliguodine 30 mg sebelum sarapan.',
                            responses: [
                              {
                                'name': 'dr. Ahmad Kusuma, Sp.OT',
                                'tag': 'Dokter Spesialis Endokrinologi',
                                'date': '20 Mei 2024, 09:30',
                                'content': 'Olahraga angkat beban memang bisa membantu dalam mengendalikan gula darah, tetapi tidak serta merta menurunkan gula darah dengan cepat. Penting untuk rutin melakukan aktivitas fisik dan menjaga pola makan yang sehat. Konsultasikan dengan dokter Anda untuk mendapatkan saran yang sesuai dengan kondisi kesehatan Anda.',
                              },
                              {
                                'name': 'dr. Laila Rahman, Sp.KO',
                                'tag': 'Dokter Spesialis Endrokrinolofi',
                                'date': '20 Mei 2024, 10:00',
                                'content': 'Waalaikumsalam. Olahraga angkat beban dapat meningkatkan sensitivitas insulin dan membantu kontrol gula darah dalam jangka panjang. Namun, efeknya mungkin tidak instan. Pastikan juga untuk memonitor gula darah sebelum dan setelah latihan untuk menghindari hipoglikemia. Salam sehat.',
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    child: ForumPost(
                      name: 'Muhamad Umar Chatab',
                      tag: 'Diabetesesi',
                      date: '19 Mei 2024, 13:58',
                      title: 'Olahraga angkat beban bisa menurunkan gula darah dgn cepat?',
                      content: 'Assalamualaikum dokter dan kawan-kawan diabetasi semuanya! Pagi ini saya seperti biasa suntik insulin Novomix 20 unit & minum 1 tablet Gliguodine 30 mg sebelum sarapan.',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumDetailPage(
                            name: 'Budi Wibowo',
                            tag: 'Diabetesesi',
                            date: '5 Mei 2024, 09:15',
                            title: 'Penggunaan insulin dan kontrol gula darah',
                            content: 'Halo dokter, saya baru saja diagnostik diabetes dan dimulai dengan insulin. Apakah setiap kali suntik insulin harus mencatat gula darah atau cukup dengan rutin memeriksa? Terima kasih.',
                            responses: [
                              {
                                'name': 'dr. Indah Puspitasari, Sp.PD-KEMD',
                                'tag': 'Dokter Spesialis Penyakit Dalam',
                                'date': '5 Mei 2024, 09:45',
                                'content': 'Halo Budi, penting untuk memonitor gula darah secara teratur, terutama setelah suntikan insulin, untuk memastikan bahwa pengaturan dosis insulin tepat. Konsultasikan dengan dokter Anda untuk mendapatkan rekomendasi yang sesuai dengan kondisi Anda. Semoga sehat selalu.',
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    child: ForumPost(
                      name: 'Budi Wibowo',
                      tag: 'Diabetesesi',
                      date: '5 Mei 2024, 09:15',
                      title: 'Penggunaan insulin dan kontrol gula darah',
                      content: 'Halo dokter, saya baru saja diagnostik diabetes dan dimulai dengan insulin. Apakah setiap kali suntik insulin harus mencatat gula darah atau cukup dengan rutin memeriksa? Terima kasih.',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumDetailPage(
                            name: 'Rini Susanti',
                            tag: 'Diabetesesi',
                            date: '29 April 2024, 14:20',
                            title: 'Makanan yang dianjurkan untuk pengidap diabetes',
                            content: 'Halo, saya baru saja diberitahu bahwa saya memiliki diabetes. Apa saja makanan yang sebaiknya saya konsumsi dan hindari? Terima kasih atas bantuannya.',
                            responses: [
                              {
                                'name': 'dr. Dewi Kartika, Sp.GK',
                                'tag': 'Dokter Spesialis Gizi Klinik',
                                'date': '29 April 2024, 14:50',
                                'content': 'Halo Rini, dalam mengatur pola makan untuk diabetes, penting untuk memperhatikan karbohidrat kompleks, serat, protein tanpa lemak, serta membatasi gula dan lemak jenuh. Konsumsi makanan rendah glikemik dan seimbangkan dengan sayuran hijau, buah-buahan segar, dan lemak sehat. Konsultasikan lebih lanjut dengan ahli gizi untuk menu makanan yang sesuai dengan kondisi Anda. Semoga membantu.',
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    child: ForumPost(
                      name: 'Rini Susanti',
                      tag: 'Diabetesesi',
                      date: '29 April 2024, 14:20',
                      title: 'Makanan yang dianjurkan untuk pengidap diabetes',
                      content: 'Halo, saya baru saja diberitahu bahwa saya memiliki diabetes. Apa saja makanan yang sebaiknya saya konsumsi dan hindari? Terima kasih atas bantuannya.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForumPost extends StatelessWidget {
  final String name;
  final String tag;
  final String date;
  final String title;
  final String content;

  ForumPost({
    required this.name,
    required this.tag,
    required this.date,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(name[0]),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(date),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
  TextButton.icon(
    onPressed: () {},
    icon: Container(
      width: 20,  // Atur lebar sesuai keinginan
      height: 20, // Atur tinggi sesuai keinginan
      child: Image.asset('assets/reply.png',
        fit: BoxFit.contain, // Mengatur bagaimana gambar dipasang
      ),
    ),
    label: Text('2 Balasan'),
  ),
],

            ),
          ],
        ),
      ),
    );
  }
}

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tanya Dokter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari dokter, spesialis',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: FilterChipWidget(label: 'Filter')),
                SizedBox(width: 5),
                Expanded(child: FilterChipWidget(label: 'Harga Konsultasi')),
                SizedBox(width: 5),
                Expanded(child: FilterChipWidget(label: 'Pengalaman Kerja')),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiaMedPage()),
                );
              },
              child: Text('Go to DiaMed Page'),
            ),
            Expanded(
              child: ListView(
                children: [
                  DoctorCard(
                    name: 'dr. Diana Iswardhani Rahmawati',
                    specialization: 'Dokter Umum',
                    rating: 93,
                    experience: 8,
                    price: 10000,
                    originalPrice: 15000,
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  DoctorCard(
                    name: 'dr. Dimas Widi Anugrah',
                    specialization: 'Dokter Umum',
                    rating: 96,
                    experience: 7,
                    price: 10000,
                    originalPrice: 15000,
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  DoctorCard(
                    name: 'dr. Neny Setyaning Asihani',
                    specialization: 'Dokter Umum',
                    rating: 99,
                    experience: 7,
                    price: 10000,
                    originalPrice: 15000,
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  DoctorCard(
                    name: 'dr. Osvaldo Williamson',
                    specialization: 'Dokter Umum',
                    rating: 90,
                    experience: 5,
                    price: 10000,
                    originalPrice: 15000,
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialization;
  final int rating;
  final int experience;
  final int price;
  final int originalPrice;
  final String imageUrl;

  DoctorCard({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(specialization, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.thumb_up, size: 14, color: Colors.grey),
                      SizedBox(width: 5),
                      Text('$rating %', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 10),
                      Icon(Icons.lock, size: 14, color: Colors.grey),
                      SizedBox(width: 5),
                      Text('$experience Tahun', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Rp $price', style: TextStyle(fontSize: 16, color: Colors.orange)),
                      SizedBox(width: 5),
                      Text('Rp $originalPrice', style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Mulai Konsultasi'),
            ),
          ],
        ),
      ),
    );
  }
}

class DiaMedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiaMedPage(),
    );
  }
}

class Artikel {
  final int id;
  final String title;
  final String snippet;
  final int likes;
  final int views;
  final String imagePath;
  final String isiartikels;

  Artikel({
    required this.id,
    required this.title,
    required this.snippet,
    required this.likes,
    required this.views,
    required this.imagePath,
    required this.isiartikels,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      likes: json['likes'] ?? 0,
      views: json['views'] ?? 0,
      imagePath: json['imagepath'] ?? '',
      isiartikels: json['isiartikels'] ?? '',
    );
  }
}

class HomePage extends StatelessWidget {
  Future<List<Artikel>> fetchArtikels() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/artikels/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Artikel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artikels');
    }
  }

  Widget buildFeatureButton(String iconPath, String label, VoidCallback onTap) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 151, 222, 157),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Image.asset(
                  iconPath,
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(width: 8),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nikmati hidup sehat dengan gula darah stabil 😊',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildFeatureButton(
                        'assets/diatrack.png',
                        'DiaTrack',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DiaTrack()),
                          );
                        },
                      ),
                      buildFeatureButton(
                        'assets/diamed.png',
                        'DiaMed',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DiaMedPage()),
                          );
                        },
                      ),
                      buildFeatureButton(
                        'assets/diashare.png',
                        'DiaShare',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DiaSharePage()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'DiaTips - popular article',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<List<Artikel>>(
                    future: fetchArtikels(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        if (snapshot.hasData) {
                          List<Artikel> artikels = snapshot.data!;
                          return Column(
                            children: artikels.map((artikel) {
                              return ArticleCard(
                                title: artikel.title ?? 'No Title',
                                snippet: artikel.snippet ?? 'No Snippet',
                                views: '${artikel.views ?? 0} views',
                                likes: '${artikel.likes ?? 0} likes',
                                imagePath: artikel.imagePath.isNotEmpty
                                    ? artikel.imagePath
                                    : 'assets/default_image.png',
                                isiartikels: artikel.isiartikels ?? '',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailArtikelPage(artikel: artikel),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        } else {
                          return Center(child: Text('No articles available'));
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/profile.png', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFF9D0063),
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}


class BloodSugarForm extends StatefulWidget {
  @override
  _BloodSugarFormState createState() => _BloodSugarFormState();
}

class _BloodSugarFormState extends State<BloodSugarForm> {
  final _formKey = GlobalKey<FormState>();
  final _sugarLevelController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedPeriod = 'Breakfast';
  bool _beforeMeal = true;

  @override
  void dispose() {
    _sugarLevelController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _sugarLevelController,
            decoration: InputDecoration(labelText: 'Blood Sugar Level (mg/dL)'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your blood sugar level';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedPeriod,
            items: ['Breakfast', 'Lunch', 'Dinner'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedPeriod = newValue!;
              });
            },
            decoration: InputDecoration(labelText: 'Period'),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _beforeMeal,
                onChanged: (value) {
                  setState(() {
                    _beforeMeal = value!;
                  });
                },
              ),
              Text('Before Meal'),
            ],
          ),
          TextFormField(
            controller: _notesController,
            decoration: InputDecoration(labelText: 'Notes'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Submit form
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const FeatureButton({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.red); // Error handler for image
              },
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String views;
  final String likes;
  final String snippet;
  final String imagePath;
  final String isiartikels;
  final VoidCallback onTap;

  const ArticleCard({
    required this.title,
    required this.views,
    required this.likes,
    required this.snippet,
    required this.imagePath,
    required this.isiartikels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for shadow effect
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      snippet,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          views,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          likes,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaTipsPage extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  const DiaTipsPage({
    required this.title,
    required this.content,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                content,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}