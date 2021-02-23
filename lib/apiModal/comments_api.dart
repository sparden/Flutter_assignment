import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'comments_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestCommentClient {
  factory RestCommentClient(Dio dio) = _RestCommentClient;

  @GET("/comments")
  Future<List<UserComments>> getUserComments();
}

@JsonSerializable()
class UserComments {
  String name;
  String body;
  String email;
  int postId;
  int id;

  UserComments({this.postId, this.email, this.body, this.id, this.name});

  factory UserComments.fromJson(Map<String, dynamic> json) =>
      _$UserCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$UserCommentsToJson(this);
}
