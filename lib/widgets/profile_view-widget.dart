import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/post_api_user_data_screen.dart';

class ProfileViewWidget extends StatefulWidget {
  final UserModel userData;
  const ProfileViewWidget({super.key, required this.userData});

  @override
  State<ProfileViewWidget> createState() => _ProfileViewWidgetState();
}

class _ProfileViewWidgetState extends State<ProfileViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("User Data"),
      ),
      body: Column(
        children: [
          Text("Name : ${widget.userData.name}"),
          Text("Email : ${widget.userData.email}"),
          Text("Username : ${widget.userData.username}"),
          Text("Phone# : ${widget.userData.phone}"),
          Text("Website : ${widget.userData.website}"),
          Row(
            children: const [
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
              ),
              Text("Address"),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
              ),
            ],
          ),
          Text("Street : ${widget.userData.address!.street}"),
          Text("Suite : ${widget.userData.address!.suite}"),
          Text("City : ${widget.userData.address!.city}"),
          Text("Zipcode : ${widget.userData.address!.zipcode}"),
          Text(
              "GEO : ${widget.userData.address!.geo!.lat},${widget.userData.address!.geo!.lng} "),
          Row(
            children: const [
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
              ),
              Text("Company"),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
              ),
            ],
          ),
          Text("Name : ${widget.userData.company!.name}"),
          Text("Catch Phrase : ${widget.userData.company!.catchPhrase}"),
          Text("BS : ${widget.userData.company!.bs}"),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PostApiUserDataScreen(
                        userId: widget.userData.id,
                      );
                    },
                  ),
                );
              },
              child: const Text("Create Post"))
        ],
      ),
    );
  }
}
