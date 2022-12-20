import 'dart:convert';
import 'package:api_call/models/user_model.dart';
import 'package:api_call/widgets/profile_view-widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileListView extends StatefulWidget {
  const ProfileListView({super.key});

  @override
  State<ProfileListView> createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getPosts() async {
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    http.Response response = await http.get(uri);
    var decodedBody = jsonDecode(response.body) as List;
    for (int i = 0; i < decodedBody.length; i++) {
      userList.add(UserModel.fromJson(decodedBody[i]));
    }
    setState(() {});
    //var list=List<UserModel>.from(decodedBody.map((i)=>UserModel.fromJson(i))).toList();
    return userList;
  }

  @override
  void initState() {
    super.initState();
    var resPosts = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      style: ListTileStyle.list,
                      tileColor: Colors.green,
                      horizontalTitleGap: 20,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileViewWidget(
                                  userData: userList[index]);
                            },
                          ),
                        );
                      },
                      title: Text(
                        "${userList[index].name}",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 248, 5, 86),
                                  Colors.deepPurpleAccent,
                                  Color.fromARGB(255, 202, 34, 34)
                                  //add more color here.
                                ],
                              ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
                      ),
                      subtitle: Text("${userList[index].email}"),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
