// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserComments _$UserCommentsFromJson(Map<String, dynamic> json) {
  return UserComments(
    postId: json['postId'] as int,
    email: json['email'] as String,
    body: json['body'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserCommentsToJson(UserComments instance) =>
    <String, dynamic>{
      'name': instance.name,
      'body': instance.body,
      'email': instance.email,
      'postId': instance.postId,
      'id': instance.id,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestCommentClient implements RestCommentClient {
  _RestCommentClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://jsonplaceholder.typicode.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<UserComments>> getUserComments() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/comments',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => UserComments.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
