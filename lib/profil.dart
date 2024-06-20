import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    Container(), // Placeholder for HomePage
    ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Image.asset('assets/back.png'), // Gambar back sebagai leading icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _children[_currentIndex],
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
        selectedItemColor: Colors.blue,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        _currentIndex = index;
      }
    });
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SizedBox(height: 16.0),
        pinterestProfileCard(
          imagePath: 'assets/endah.jpg',
          name: 'Endah',
          phone: '081234567890',
          email: 'endahmaharani@gmail.com',
          typeofdiabetes: 'Type 1',
          weight: '70 kg',
          cardColor: Colors.white,
        ),
        SizedBox(height: 16.0),
        profileCard(
          imagePath: 'assets/farel.jpg',
          name: 'Farelco Felda Akbar',
          phone: '085162660650',
          email: '22082010030@student.upnjatim.ac.id',
          cardColor: Color(0xFFFFDFEB),
        ),
        SizedBox(height: 16.0),
        profileCard(
          imagePath: 'assets/hanim.jpg',
          name: 'Hanim Rachma Nur Haliza',
          phone: '085704873018',
          email: '22082010010@student.upnjatim.ac.id',
          cardColor: Color(0xFFFFDFEB),
        ),
      ],
    );
  }

  Widget pinterestProfileCard({
    required String imagePath,
    required String name,
    required String phone,
    required String email,
    required String typeofdiabetes,
    required String weight,
    required Color cardColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0), // Add margin for spacing
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Phone: $phone',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            'Email: $email',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    typeofdiabetes,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Type of Diabetes',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    weight,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Weight',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileCard({
    required String imagePath,
    required String name,
    required String phone,
    required String email,
    required Color cardColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0), // Add margin for spacing
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Phone: $phone',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Email: $email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
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
