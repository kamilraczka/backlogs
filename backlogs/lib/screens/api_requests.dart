import 'dart:convert';

import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ApiRequestsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApiRequestsScreenState();
}

class _ApiRequestsScreenState extends State<ApiRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.accentColor0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: ApiDataSource.fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Post> posts = snapshot.data;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return FloatingComment(post: posts[index]);
                    },
                  );
                }
              } else if (snapshot.hasError) {
                return Text('Nowy Future nie poleciał');
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text('Leci nowy Future...'),
                  ),
                  LinearProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FloatingComment extends StatelessWidget {
  final Post post;

  FloatingComment({@required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.title,
              style: TextStyle(
                color: ColorsLibrary.textColorMedium,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              post.body,
              style: TextStyle(
                color: ColorsLibrary.textColorLight,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: ColorsLibrary.backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorsLibrary.shadowColors,
              blurRadius: 8.0,
              spreadRadius: 4.0,
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class ApiDataSource {
  static Future<List<Post>> fetchPosts() async {
    final url = 'https://jsonplaceholder.typicode.com/posts?userId=5';
    final delay = await Future.delayed(Duration(seconds: 2), null);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final List<Post> decodedData =
          data.map((el) => Post.fromJson(el)).toList();
      return decodedData;
    } else {
      throw Exception('Failed to load');
    }
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post(this.id, this.userId, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['id'],
      json['userId'],
      json['title'],
      json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'title': this.title,
        'body': this.body,
      };
}
