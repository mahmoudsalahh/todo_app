import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salahh/models/user/user_model.dart';


class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id : 1,
      name : 'mahmoud',
      phone: 01012356225,
    ),
    UserModel(
      id : 2,
      name : 'ahmoen',
      phone: 0101268225,
    ),
    UserModel(
      id : 3,
      name : 'samrod',
      phone: 01012356225,
    ),
    UserModel(
      id : 1,
      name : 'mahmoud',
      phone: 01012356225,
    ),
    UserModel(
      id : 2,
      name : 'ahmoen',
      phone: 0101268225,
    ),
    UserModel(
      id : 3,
      name : 'samrod',
      phone: 01012356225,
    ),
    UserModel(
      id : 1,
      name : 'mahmoud',
      phone: 01012356225,
    ),
    UserModel(
      id : 2,
      name : 'ahmoen',
      phone: 0101268225,
    ),
    UserModel(
      id : 3,
      name : 'samrod',
      phone: 01012356225,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),

      ),
      body: ListView.separated(
          itemBuilder: (context , index )=> buildUserItem(users[index]) ,
          separatorBuilder: (context , index) => Container(
            width: double.infinity,
            height: 1.0,
            color : Colors.grey,

          ),
          itemCount: users.length,
      ),

    );
  }
  Widget buildUserItem(UserModel user)=> Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.teal,
          child: Text('${user.id}' ,
              style : TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),

        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${user.name}' ,
                  style : TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold)),
              Text('${user.phone}' ,
                  style : TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold , color: Colors.grey)),

            ],
          ),
        ),

      ],
    ),
  );
}
