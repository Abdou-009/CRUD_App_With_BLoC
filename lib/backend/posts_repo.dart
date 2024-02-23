import 'dart:convert';

import 'package:login_with_bloc/backend/postMod.dart';
import 'package:http/http.dart' as http;

// Class General Of Repo
class PostRepository {
  String postUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Get All Posts
  Future<List<PostModel>> getAllPost() async {
    http.Response response = await http.get(Uri.parse(postUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => PostModel.formJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Get By Id Posts
  Future<PostModel> getPostById(int id) async {
    var response = await http.get(Uri.parse('$postUrl/$id'));
    var result = jsonDecode(response.body);
    PostModel postItem = PostModel.formJson(result);
    return postItem;
  }

  // Create Posts
  Future<bool> createPost(PostModel post) async {
    var response = await http.post(
      Uri.parse(postUrl),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    return response.statusCode == 200;
  }

  // Update Posts
  Future<bool> updatePost(PostModel post) async {
    var response = await http.put(
      Uri.parse('$postUrl/${post.id}'),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    return response.statusCode == 200;
  }

  // Delete Posts
  Future<bool> deletePost(int id) async {
    var response = await http.delete(Uri.parse('$postUrl/$id'));
    print("Status code : ${response.statusCode}");
    print("item id deleted is : $id");
    return response.statusCode == 200;
  }
}
