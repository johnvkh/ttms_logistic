import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page 1"),
      ),
      body: Column(
        children: [
          Text("date 1"),
          Text("date 2"),
          RaisedButton(
            onPressed: () {},
            child: Text("Continue"),
          )
        ],
      ),
    );
  }
}
