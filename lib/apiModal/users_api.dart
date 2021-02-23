import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'users_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/users")
  Future<List<Users>> getUsers();
}

@JsonSerializable()
class Users {
  String name;
  String website;
  String username;
  Map address;
  String email;
  int id;

  Users(
      {this.id,
      this.username,
      this.name,
      this.website,
      this.email,
      this.address});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
