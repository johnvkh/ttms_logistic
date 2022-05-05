import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';
import 'package:ttms_logistic/Model/UserModel.dart';
import 'package:ttms_logistic/ProviderClass/StaffProviderModel.dart';
import 'package:ttms_logistic/States/HomePage.dart';
import 'package:ttms_logistic/States/LoginPage.dart';
import 'package:ttms_logistic/States/Page1.dart';
import 'package:ttms_logistic/States/TruckManage/TruckType.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> map = {
  '/home': (BuildContext context) => HomePage(),
  '/login': (BuildContext context) => LoginPage(),
  '/page1': (BuildContext context) => Page1(),
  '/truckType': (BuildContext context) => TruckType(),
};
String initialRoute = '/login';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<StaffModel>(create: (context) => StaffModel()),
    //     Provider<UseModel>(create: (context) => UseModel()),
    //   ],
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     routes: map,
    //     initialRoute: initialRoute,
    //     title: 'Khounkham Logistic',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: Page1(),
    //   ),
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StaffModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: map,
        initialRoute: initialRoute,
        title: 'Khounkham Logistic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
