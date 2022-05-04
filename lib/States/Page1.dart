import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  StaffModel? _staffModel;

  String fullName = "";

  @override
  void initState() {
    // TODO: implement initState
    findUser();
    super.initState();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = preferences.getString('fullName')!;
    });
    if(fullName=="" || fullName.isEmpty){
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //_staffModel = Provider.of<StaffModel>(context).getInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text("page 1"),
      ),
      body: Column(
        children: [
          Text("${fullName}"),
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
