import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Components/DefaultButton.dart';
import 'package:ttms_logistic/Components/Footer.dart';
import 'package:ttms_logistic/Components/MyFiles.dart';
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
  final TextEditingController _truckTypeCode = new TextEditingController();
  final TextEditingController _truckTypeName = new TextEditingController();

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
      appBar: AppBar(title: Text("Dashboard")),
      drawer: SideMenu(),
      body: ScreenTypeLayout(
        desktop: DesktopWidget(
          context,
          _truckTypeCode,
          _truckTypeName,
        ),
        tablet: MobileTabletWidget(),
        mobile: MobileTabletWidget(),
      ),
    );
  }

  Widget MobileTabletWidget() {
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
                                  padding: const EdgeInsets.all(20.0),
                                  // child: TextWidget(
                                  //     "ຈັດການຂໍ້ມູນປະເພກລົດບັນທຸກ",
                                  //     Colors.black54,
                                  //     20,
                                  //     FontWeight.bold),
                                  child: Text(
                                    "ຈັດການຂໍ້ມູນປະເພກລົດບັນທຸກ",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
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
                  SizedBox(height: defaultPadding),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget DesktopWidget(
    BuildContext context,
    TextEditingController _truckTypeCode,
    TextEditingController _truckTypeName,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Navbar(scaffoldKey: _scaffoldKey),
                // const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextWidget(
                    "ຈັດການຂໍ້ມູນປະເພກລົດບັນທຸກ",
                    Colors.black54,
                    20,
                    FontWeight.bold,
                    TextAlign.start,
                  ),
                ),
                SizedBox(height: defaultPadding),
                addTruckTypePanel(context, _truckTypeCode, _truckTypeName),
                SizedBox(height: defaultPadding),
                tableTruckTypePanel(context, _truckTypeCode, _truckTypeName),
                SizedBox(height: defaultPadding),
                Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget addTruckTypePanel(
      BuildContext context,
      TextEditingController _truckTypeCode,
      TextEditingController _truckTypeName) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: boxColors,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: TextWidget(
                  "ເພີ່ມປະເພກລົດບັນທຸກ",
                  Colors.black54,
                  20,
                  FontWeight.bold,
                  TextAlign.start,
                ),
              ),
            ],
          ),
          DividerWidget(),
          SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                buildTextField(
                    content: "ລະຫັດປະເພດລົດບັນທຸກ",
                    textControl: _truckTypeCode),
                const SizedBox(
                  width: 30,
                ),
                buildTextField(
                    content: "ຊື່ປະເພດລົດບັນທຸກ", textControl: _truckTypeName),
                Expanded(
                  child: SizedBox(height: defaultPadding),
                ),
                DefaultButton(
                  width: 100,
                  height: 40,
                  press: () {},
                  text: "ບັນທຶກ",
                ),
              ],
            ),
          ),

          //MyFiles(),
          SizedBox(height: defaultPadding),
          //RecentFiles(),
        ],
      ),
    );
  }

  Widget tableTruckTypePanel(
      BuildContext context,
      TextEditingController _truckTypeCode,
      TextEditingController _truckTypeName) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: boxColors,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: TextWidget(
                  "ຂໍ້ມູນປະເພດລົດບັນທຸກ",
                  Colors.black54,
                  20,
                  FontWeight.bold,
                  TextAlign.start,
                ),
              ),
            ],
          ),
          DividerWidget(),
          SizedBox(height: defaultPadding),

          Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(120.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Text('Website', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Tutorial', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Review', style: TextStyle(fontSize: 20.0))
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('Flutter')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('MySQL')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('ReactJS')]),
                    Column(children: [Text('5*')]),
                  ]),
                ],
              ),
            ),
          ])),

          //MyFiles(),
          SizedBox(height: defaultPadding),
          //RecentFiles(),
        ],
      ),
    );
  }
}

class buildTextField extends StatelessWidget {
  const buildTextField({
    Key? key,
    required this.content,
    required TextEditingController textControl,
  })  : _textControl = textControl,
        super(key: key);

  final TextEditingController _textControl;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: 40.0,
          child: TextField(
            maxLines: 1,
            controller: _textControl,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'NotoSansLao',
              ),
              labelText: content,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
