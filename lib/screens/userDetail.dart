import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nxgenpro/apiModal/users_api.dart';

class UserDetail extends StatelessWidget {
  final index;
  UserDetail({this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: _account(context, index),
    );
  }
}

// build Account view & manage states
FutureBuilder<List<Users>> _account(BuildContext context, int index) {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<List<Users>>(
    future: client.getUsers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<Users> users = snapshot.data;
        return _accountView(context, users, index);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

// build account view
Widget _accountView(BuildContext context, List<Users> users, int index) {
  return Container(
    child: Column(
      children: <Widget>[
        Text(
          users[index - 1].name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Name:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(users[index - 1].username),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(users[index - 1].email),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'City:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(users[index - 1].address['city']),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Website:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(users[index - 1].website),
          ],
        ),
      ],
    ),
  );
}
