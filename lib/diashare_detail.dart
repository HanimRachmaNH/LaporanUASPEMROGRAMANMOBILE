import 'package:flutter/material.dart';

class ForumDetailPage extends StatelessWidget {
  final String name;
  final String tag;
  final String date;
  final String title;
  final String content;
  final List<Map<String, String>> responses;

  ForumDetailPage({
    required this.name,
    required this.tag,
    required this.date,
    required this.title,
    required this.content,
    required this.responses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Forum'),
        backgroundColor: Color(0xFF9D0063),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(content),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: responses
                    .map((response) => Comment(
                          name: response['name']!,
                          tag: response['tag']!,
                          date: response['date']!,
                          content: response['content']!,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String name;
  final String tag;
  final String date;
  final String content;

  Comment({
    required this.name,
    required this.tag,
    required this.date,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
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
            Text(content),
          ],
        ),
      ),
    );
  }
}