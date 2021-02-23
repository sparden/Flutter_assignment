import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nxgenpro/apiModal/posts_api.dart';
import 'package:nxgenpro/apiModal/users_api.dart';
import 'package:nxgenpro/screens/comments.dart';
import 'package:nxgenpro/screens/userDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Posts', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Account',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _widgetOptions.elementAt(_selectedIndex),
          backgroundColor: Colors.green),
      body: (_selectedIndex == 0) ? _postBody(context) : _account(context),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add,
              ),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Account',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(128, 0, 255, 0.8),
          unselectedItemColor: Colors.black38,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  // build Post list view & manage states
  FutureBuilder<List<Post>> _postBody(BuildContext context) {
    final client =
        RestClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<Post>>(
      future: client.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Post> posts = snapshot.data;
          return _postListView(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build Post list view & its tile
  Widget _postListView(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
            child: Container(
          child: Column(
            children: <Widget>[
              Text(
                posts[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(posts[index].body),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    child: Text('- Username'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetail(
                                  index: posts[index].userId,
                                ))),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Comments(commentTitle: posts[index].title))))
                ],
              ),
            ],
          ),
        ));
      },
    );
  }

  // build Account view & manage states
  FutureBuilder<List<Users>> _account(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<List<Users>>(
      future: client.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Users> users = snapshot.data;
          return _accountView(context, users);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build account view
  Widget _accountView(BuildContext context, List<Users> users) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            users[0].name,
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
              Text(users[0].username),
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
              Text(users[0].email),
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
              Text(users[0].address['city']),
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
              Text(users[0].website),
            ],
          ),
        ],
      ),
    );
  }
}
