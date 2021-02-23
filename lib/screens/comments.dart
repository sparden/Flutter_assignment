import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nxgenpro/apiModal/comments_api.dart';

class Comments extends StatefulWidget {
  final commentTitle;
  Comments({this.commentTitle});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: Column(
          children: [
            Text(
              widget.commentTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Container(
                child: _commentBody(context),
              ),
            )
          ],
        ));
  }
}
//  Text(widget.commentTitle),

// build Comment list view & manage states
FutureBuilder<List<UserComments>> _commentBody(BuildContext context) {
  final client =
      RestCommentClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<List<UserComments>>(
    future: client.getUserComments(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<UserComments> userComments = snapshot.data;
        return _commentListView(context, userComments);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

// build Comment list view & its tile
Widget _commentListView(BuildContext context, List<UserComments> userComments) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: userComments.length,
    itemBuilder: (context, index) {
      return Card(
          child: Container(
        child: Column(
          children: <Widget>[
            Text(
              userComments[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(userComments[index].body),
            SizedBox(
              height: 5.0,
            ),
            Text(
              '- ' + userComments[index].email,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
    },
  );
}
