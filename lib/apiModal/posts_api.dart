import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'posts_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/posts")
  Future<List<Post>> getPosts();
}

@JsonSerializable()
class Post {
  String title;
  String body;
  int userId;
  int id;

  Post({this.userId, this.title, this.body, this.id});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
