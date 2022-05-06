// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';
import 'package:ttms_logistic/Model/UserModel.dart';
import 'package:ttms_logistic/ProviderClass/StaffProviderModel.dart';
import 'package:ttms_logistic/States/HomePage.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:ttms_logistic/Utility/DialogPopup.dart';
import 'package:ttms_logistic/Utility/ResponceCode.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadProcessBar = true;
  late String userName;
  late String password;
  late StaffModel staffModel;
  late StaffModel staffModel2;

  // late UseModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                ])),
            child: loadProcessBar
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Image.asset(
                          "assets/images/logo.png",
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "PSV express",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 380,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Please Login To Your Account",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 250,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      userName = value.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "User Name",
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.user,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      password = value.toString();
                                    });
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.lock,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Forget Password",
                                      style: TextStyle(
                                        color: Colors.orangeAccent[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    loadProcessBar = false;
                                  });
                                  print(
                                      "userName=${userName},  password=${password}");
                                  if (userName.isEmpty || userName == "") {
                                    DialogFail(context, "Notification!",
                                        "User name incorrect pleace try again!!!");
                                  } else if (password.isEmpty ||
                                      password == "") {
                                    DialogFail(context, "Notification!",
                                        "Password incorrect pleace try again!!!");
                                  } else {
                                    evenLogin(userName, password);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF8A2378),
                                          Color(0xFFE04057),
                                          Color(0xFFF27121),
                                        ]),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Lottie.asset("assets/lottie/loading.json",
                          width: 100, height: 100),
                    ),
                  )),
      ),
    );
  }

  Future<Null> evenLogin(String userName, String password) async {
    try {
      var url = Uri.parse("${API_URL}/TTMS/api/authen/login.php");
      var response = await http.post(
        url,
        body: json.encode({
          "actionCode": "99868",
          "actionNodeId": 1,
          "staffCode": "${userName}",
          "password": "${password}"
        }),
      );
      print('Response status: ${response.statusCode}');
      var respData = json.decode(response.body);
      print("extractedData['list']=${respData['info']}");
      for (var map in respData['info']) {
        setState(() {
          staffModel = StaffModel.fromJson(map);
          //Provider.of<StaffModel>(context, listen: false).setInfo(staffModel);
        });
      }
      // print("userName=${userModel.fullName}");
      if (respData['responceCode'] == SUCESSFUL) {
        setState(() {
          loadProcessBar = true;
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('fullName', staffModel.fullName);
        sharedPreferences.setString('StaffCode', staffModel.staffCode);
      } else {
        setState(() {
          loadProcessBar = true;
        });
        DialogFail(
            context, "Notification!", "system error pleace try again!!!");
      }
    } catch (error) {
      setState(() {
        loadProcessBar = true;
      });
      DialogFail(context, "Notification!", "system error pleace try again!!!");
    }
  }
}
