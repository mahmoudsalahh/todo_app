import 'package:flutter/material.dart';

class DoneTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity ,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children: [
          Text(
            'DONE TASKS' ,
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
