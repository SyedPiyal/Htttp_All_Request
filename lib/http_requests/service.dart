import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';

class PostService {
  //------------------------------
  // Method to fetch posts/get request
  //------------------------------

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load posts');
    }
  }

  //------------------------------
  // Method to make a post request
  //------------------------------

  Future<void> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),

      ///---------------
      /// headers: This is a map containing the request headers.
      /// In this case, we're specifying the 'Content-Type'
      /// header as 'application/json; charset=UTF-8'.
      /// This tells the server that the request body is in
      /// JSON format and encoded using UTF-8.
      ///---------------
      ///
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      ///---------------
      /// body: This is the request body.
      /// We're using jsonEncode to convert a map representing
      /// the post data into a JSON string. The map contains
      /// the data for the new post, including userId, id,
      /// title, and body. This JSON string will be sent as
      /// the body of the POST request.
      ///---------------

      body: jsonEncode(<String, dynamic>{
        'userId': post.userId,
        'id': post.id,
        'title': post.title,
        'body': post.body,
      }),
    );

    if (response.statusCode == 201) {
      // If the server returns a 201 Created response, the post request was successful.
      print('Post request successful');
    } else {
      // If the server did not return a 201 Created response, throw an exception.
      throw Exception('Failed to create post');
    }
  }

  //------------------------------
  // Method to make an update request
  //------------------------------

  Future<void> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com//posts/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': post.userId,
        'id': post.id,
        'title': post.title,
        'body': post.body,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the update request was successful.
      print('Update request successful');
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to update post');
    }
  }

  //------------------------------
  // Method to make a delete request
  //------------------------------

  Future<void> deletePost(int postId) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/posts/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the delete request was successful.
      print('Delete request successful');
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to delete post');
    }
  }
}
