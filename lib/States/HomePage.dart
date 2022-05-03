import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';
import 'package:ttms_logistic/Model/UserModel.dart';
import 'package:ttms_logistic/ProviderClass/StaffProviderModel.dart';
import 'package:ttms_logistic/Utility/Constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StaffModel? _staffModel;
  @override
  Widget build(BuildContext context) {
    _staffModel =  Provider.of<StaffModel>(context).getInfo();
    return Scaffold(
      key: _scaffoldKey,
      body: ScreenTypeLayout(
          desktop: Text("${_staffModel?.fullName}"),
          tablet: Text("tablet"),
          mobile: Text("mobile"),
        ),
    );
  }
}

class MobileTabletWidget extends StatelessWidget {
  const MobileTabletWidget({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
