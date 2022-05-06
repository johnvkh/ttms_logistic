import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Components/Footer.dart';
import 'package:ttms_logistic/Components/Navbar.dart';
import 'package:ttms_logistic/Components/SideMenu.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:ttms_logistic/Utility/Responsive.dart';
import 'package:ttms_logistic/Utility/WidgetUtility.dart';

class TruckType extends StatefulWidget {
  @override
  _TruckTypeState createState() => _TruckTypeState();
}

class _TruckTypeState extends State<TruckType> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

    if (fullName == "" || fullName.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: ScreenTypeLayout(
        desktop: DesktopWidget(fullName: fullName, scaffoldKey: _scaffoldKey),
        tablet:
        MobileTabletWidget(fullName: fullName, scaffoldKey: _scaffoldKey),
        mobile:
        MobileTabletWidget(fullName: fullName, scaffoldKey: _scaffoldKey),
      ),
    );
  }
}

class MobileTabletWidget extends StatelessWidget {
  const MobileTabletWidget({
    Key? key,
    required this.fullName,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final String fullName;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Column(
                children: [
                  Navbar(scaffoldKey: _scaffoldKey),
                  SizedBox(height: defaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextWidget("ຈັດການຂໍ້ມູນປະເພກລົດບັນທຸກ",
                                      Colors.black54, 20, FontWeight.bold),
                                ),
                              ],
                            ),
                            // MyFiles(),
                            // SizedBox(height: defaultPadding),
                            // RecentFiles(),
                            // SizedBox(height: defaultPadding),
                            // StarageDetails(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    Key? key,
    required this.fullName,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);
  final String fullName;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Navbar(scaffoldKey: _scaffoldKey),
                  const SizedBox(height: defaultPadding),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: secondaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextWidget("ຈັດການຂໍ້ມູນປະເພກລົດບັນທຸກ",
                                        Colors.black54, 20, FontWeight.bold),
                                  ),
                                ],
                              ),
                              //MyFiles(),
                              SizedBox(height: defaultPadding),
                              //RecentFiles(),
                            ],
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        // Expanded(
                        //   flex: 2,
                        //   child: StarageDetails(),
                        // ),
                      ],
                    ),
                  ),
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}