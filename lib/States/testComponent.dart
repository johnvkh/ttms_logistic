import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttms_logistic/Utility/Constants.dart';

class TextComponent extends StatefulWidget {
  @override
  _TextComponentState createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 123, 255, 1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Quick Example",style: TextStyle(color: Colors.white),textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
