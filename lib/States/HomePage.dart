import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Components/SideMenu.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';
import 'package:ttms_logistic/Model/UserModel.dart';
import 'package:ttms_logistic/ProviderClass/StaffProviderModel.dart';
import 'package:ttms_logistic/States/LoginPage.dart';
import 'package:ttms_logistic/Utility/Constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Text("${fullName}"),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/page1', (route) => false);
              },
              child: Text("Continue"),
            ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                        ),
                        // Expanded(
                        //   child: SearchField(),
                        // ),
                        // ProfileCard()
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              // MyFiles(),
                              // SizedBox(height: defaultPadding),
                              // RecentFiles(),
                              // SizedBox(height: defaultPadding),
                              // StarageDetails(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      ),
                      Text("Dashboard",
                          style: Theme.of(context).textTheme.headline6),
                      //Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                      // Expanded(child: SearchField()),
                      // ProfileCard()
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
