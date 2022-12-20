import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PostApiUserDataScreen extends StatefulWidget {
  final int? userId;
  const PostApiUserDataScreen({super.key, required this.userId});

  @override
  State<PostApiUserDataScreen> createState() => _PostApiUserDataScreenState();
}

class _PostApiUserDataScreenState extends State<PostApiUserDataScreen> {
  bool isLoading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<bool> addPostOfUser() async {
    setState(() {
      isLoading = true;
    });
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    Map<String, dynamic> body = {
      "userId": widget.userId,
      "title": _titleController.text,
      "body": _descriptionController.text,
    };
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    http.Response response =
        await http.post(uri, body: jsonEncode(body), headers: header);
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Enter Title"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 7,
                controller: _descriptionController,
                decoration:
                    const InputDecoration(hintText: "Enter Description"),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          bool status = await addPostOfUser();
                          if (status) {
                            const snackBar = SnackBar(
                              content: Text('Post created'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Error Occured'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: const Text("POST")),
            ],
          ),
        ),
      ),
    );
  }
}
