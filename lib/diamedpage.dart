import 'package:flutter/material.dart';

class DiaMedPage extends StatefulWidget {
  @override
  _DiaMedPageState createState() => _DiaMedPageState();
}

class _DiaMedPageState extends State<DiaMedPage> {
  TextEditingController searchController = TextEditingController();
  List<Doctor> doctors = [];
  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    // Initialize doctors list
    doctors = [
      Doctor(
        name: 'dr. Diana Iswardhani Rahmawati',
        specialization: 'Dokter Umum',
        rating: 4.5,
        experience: 8,
        imageUrl: 'assets/dokter cewe.jpg',
        strNumber: '123456789',
        reviewCount: 87,
        satisfactionPercentage: 94,
      ),
      Doctor(
        name: 'dr. Dimas Widi Anugrah',
        specialization: 'Dokter Umum',
        rating: 4.8,
        experience: 7,
        imageUrl: 'assets/dokter cowo.jpg',
        strNumber: '987654321',
        reviewCount: 67,
        satisfactionPercentage: 91,
      ),
      Doctor(
        name: 'dr. Neny Setyaning Asihani',
        specialization: 'Dokter Umum',
        rating: 4.9,
        experience: 7,
        imageUrl: 'assets/dokter cewe.jpg',
        strNumber: '456789123',
        reviewCount: 45,
        satisfactionPercentage: 89,
      ),
      Doctor(
        name: 'dr. Ahmad Fauzi',
        specialization: 'Dokter Umum',
        rating: 4.7,
        experience: 5,
        imageUrl: 'assets/dokter cowo.jpg',
        strNumber: '112233445',
        reviewCount: 55,
        satisfactionPercentage: 92,
      ),
      Doctor(
        name: 'dr. Sri Wahyuni',
        specialization: 'Dokter Umum',
        rating: 4.6,
        experience: 9,
        imageUrl: 'assets/dokter cewe.jpg',
        strNumber: '223344556',
        reviewCount: 70,
        satisfactionPercentage: 88,
      ),
      Doctor(
        name: 'dr. Bambang Susilo',
        specialization: 'Dokter Umum',
        rating: 4.4,
        experience: 6,
        imageUrl: 'assets/dokter cowo.jpg',
        strNumber: '334455667',
        reviewCount: 60,
        satisfactionPercentage: 85,
      ),
      Doctor(
        name: 'dr. Siti Nurhaliza',
        specialization: 'Dokter Umum',
        rating: 4.3,
        experience: 4,
        imageUrl: 'assets/dokter cewe.jpg',
        strNumber: '445566778',
        reviewCount: 40,
        satisfactionPercentage: 80,
      ),
      Doctor(
        name: 'dr. Joko Anwar',
        specialization: 'Dokter Umum',
        rating: 4.5,
        experience: 10,
        imageUrl: 'assets/dokter cowo.jpg',
        strNumber: '556677889',
        reviewCount: 90,
        satisfactionPercentage: 93,
      ),
    ];
    // Set filteredDoctors to all doctors initially
    filteredDoctors = doctors;
  }

  void filterDoctors(String query) {
    final filtered = doctors.where((doctor) {
      final nameLower = doctor.name.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredDoctors = filtered;
    });
  }

  void _showConsultationConfirmation(BuildContext context, String doctorName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yakin konsultasi dengan $doctorName?'),
          content:
              Text('Anda akan masuk ke ruang konsultasi dengan dokter ini.'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(doctorName: doctorName),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tanya Dokter'),
        backgroundColor: Colors.white, // Custom app bar color
        leading: IconButton(
          icon: Image.asset('assets/back.png', color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              onChanged: filterDoctors,
              decoration: InputDecoration(
              hintText: 'Cari dokter, spesialis',
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 24.0, // Sesuaikan dengan lebar yang diinginkan
                  height: 24.0, // Sesuaikan dengan tinggi yang diinginkan
                  child: Image.asset('assets/search.png', fit: BoxFit.contain),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromRGBO(147, 221, 102, 1)), // Warna border ketika tidak terfokus
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: const Color.fromRGBO(147, 221, 102, 1)), // Warna border ketika tidak terfokus
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Color.fromARGB(255, 198, 58, 229)), // Warna border ketika terfokus
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: filteredDoctors[index],
                    onPressed: () {
                      _showConsultationConfirmation(
                          context, filteredDoctors[index].name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onPressed;

  DoctorCard({required this.doctor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctor.imageUrl),
              radius: 30.0,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(doctor.specialization),
                  Row(
                    children: [
                      StarRating(rating: doctor.rating),
                      SizedBox(width: 5.0),
                      Text('(${doctor.rating.toString()})'),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5.0),
                      Text('${doctor.experience} Tahun'),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
  onPressed: onPressed,
  child: Text(
    'Konsultasi',
    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)), // Mengubah warna teks menjadi merah
  ),
  style: TextButton.styleFrom(
    backgroundColor: Colors.green,
  ),
)

          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;  // Parameter untuk ukuran gambar

  StarRating({required this.rating, this.size = 20});  // Nilai default ukuran gambar

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),  // Ubah padding menjadi horizontal saja
          child: Image.asset(
            index < rating.floor() ? 'assets/star.png' : 'assets/favorite.png',  // floor() digunakan untuk membulatkan nilai rating ke bawah
            width: size,
            height: size,
          ),
        );
      }),
    );
  }
}


class Doctor {
  final String name;
  final String specialization;
  final double rating;
  final int experience;
  final String imageUrl;
  final String strNumber;
  final int reviewCount;
  final int satisfactionPercentage;

  Doctor({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.imageUrl,
    required this.strNumber,
    required this.reviewCount,
    required this.satisfactionPercentage,
  });
}

class ChatScreen extends StatefulWidget {
  final String doctorName;

  ChatScreen({required this.doctorName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(
      text: 'Halo, ada yang bisa saya bantu?',
      isSentByMe: false,
      timestamp: '23:31',
    ),
  ];

  TextEditingController messageController = TextEditingController();

  void _sendMessage(String text) {
    setState(() {
      messages.add(ChatMessage(
        text: text,
        isSentByMe: true,
        timestamp: '23:32', // Ini bisa diganti dengan waktu aktual
      ));
      messageController.clear();
    });
    _sendDoctorReply();
  }

  void _sendDoctorReply() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.add(ChatMessage(
          text: 'Gejala yang dialami sama mas nya gimana ya?',
          isSentByMe: false,
          timestamp: '23:33', // Ini bisa diganti dengan waktu aktual
        ));
      });
    });
  }

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
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/dokter cowo.jpg',
              ), // Ganti dengan URL gambar dokter
            ),
            SizedBox(width: 10),
            Text(widget.doctorName),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  text: message.text,
                  isSentByMe: message.isSentByMe,
                  timestamp: message.timestamp,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: Image.asset('assets/send.png'),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        _sendMessage(messageController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final String timestamp;

  ChatBubble({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.green[300] : Colors.white,
              borderRadius: isSentByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isSentByMe ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            timestamp,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}

void main() {
  runApp(MaterialApp(
    home: DiaMedPage(),
  ));
}
