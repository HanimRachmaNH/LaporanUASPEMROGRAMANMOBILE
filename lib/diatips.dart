// artikel.dart

import 'dart:convert';

class Artikel {
  int? id;
  String title;
  String snippet;
  int likes;
  int views;
  String imagepath;

  Artikel({
    this.id,
    required this.title,
    required this.snippet,
    required this.likes,
    required this.views,
    required this.imagepath,
  });

  // Factory constructor to create an Artikel instance from a map
  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'],
      title: json['title'],
      snippet: json['snippet'],
      likes: json['likes'],
      views: json['views'],
      imagepath: json['imagepath'],
    );
  }

  // Method to convert an Artikel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'snippet': snippet,
      'likes': likes,
      'views': views,
      'imagepath': imagepath,
    };
  }

  // Optional: Method to convert an Artikel instance to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }

  // Optional: Factory constructor to create an Artikel instance from a JSON string
  factory Artikel.fromJsonString(String jsonString) {
    return Artikel.fromJson(json.decode(jsonString));
  }
}
