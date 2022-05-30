import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttms_logistic/Components/BuildTextField.dart';
import 'package:ttms_logistic/Components/DefaultButton.dart';
import 'package:ttms_logistic/Components/Footer.dart';
import 'package:ttms_logistic/Components/MyFiles.dart';
import 'package:ttms_logistic/Components/Navbar.dart';
import 'package:ttms_logistic/Components/SideMenu.dart';
import 'package:ttms_logistic/Model/TruckTypeModel.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:ttms_logistic/Utility/DialogPopup.dart';
import 'package:ttms_logistic/Utility/ResponceCode.dart';
import 'package:ttms_logistic/Utility/Responsive.dart';
import 'package:ttms_logistic/Utility/WidgetUtility.dart';
import 'package:http/http.dart' as http;

class TruckType extends StatefulWidget {
  @override
  _TruckTypeState createState() => _TruckTypeState();
}

class _TruckTypeState extends State<TruckType> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String fullName = "";
  String staffCode = "";
  final TextEditingController _truckTypeCode = new TextEditingController();
  final TextEditingController _truckTypeName = new TextEditingController();
  List<TruckTypeModel> listTruckType = <TruckTypeModel>[];
  late TruckTypeModel truckTypeModel;
  int rowPerPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    findUser();
    loadTruckType();
    super.initState();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = preferences.getString('fullName')!;
      staffCode = preferences.getString('StaffCode')!;
    });

    if (fullName == "" || fullName.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<Null> loadTruckType() async {
    try {
      var url =
      Uri.parse("${API_URL}/TTMS/api/basic_information/trucktype.php");
      var response = await http.post(
        url,
        body: json.encode({
          "actionCode": "99999",
          "actionNodeId": 1,
        }),
      );
      var respData = json.decode(response.body);
      print('Response: ${respData}');
      if (respData['responseCode'] == SUCESSFUL) {
        for (var map in respData['data']) {
          truckTypeModel = TruckTypeModel.fromJson(map);
          listTruckType.add(truckTypeModel);
        }
        setState(() {
          listTruckType;
        });
        if (listTruckType.length >= 5) {
          setState(() {
            rowPerPage = 5;
          });
        } else {
          setState(() {
            rowPerPage = listTruckType.length;
          });
        }
        print("==============${rowPerPage}");
      } else if (respData['responseCode'] == SESSION_EXPRIE) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        DialogFail(context, "Notification!",
            "system error pleace try again!!!=======");
      }
    } catch (error) {
      DialogFail(context, "Notification!",
          "system error pleace try again!!!111111111");
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
            listTruckType,
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
                                    "ຈັດການຂໍ້ມູນປະເພດລົດບັນທຸກ",
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .headline6,
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

  Widget DesktopWidget(BuildContext context,
      TextEditingController _truckTypeCode,
      TextEditingController _truckTypeName,
      List<TruckTypeModel> listTruckType) {
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
                tableTruckTypePanel(context,listTruckType),
                SizedBox(height: defaultPadding),
                Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tableTruckTypePanel(BuildContext context,List<TruckTypeModel>listTruckType) {
    return Column(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 123, 255, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextWidget(
                  "ເພີ່ມປະເພດລົດບັນທຸກ",
                  Colors.white,
                  16,
                  FontWeight.bold,
                  TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: PaginatedDataTable(
              // header: Text('Header Text'),
              rowsPerPage: rowPerPage,
              columns: [
                DataColumn(label: Text('Header B')),
                DataColumn(label: Text('Header B')),
                DataColumn(label: Text('Header C')),
                DataColumn(label: Text('Header D')),
              ],
              source: TruckTypeDataSource(context, listTruckType),
            ),
          ),
        ),
      ],
    );
  }

  Widget addTruckTypePanel(BuildContext context,
      TextEditingController _truckTypeCode,
      TextEditingController _truckTypeName) {
    return Column(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 123, 255, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextWidget(
                  "ເພີ່ມປະເພດລົດບັນທຸກ",
                  Colors.white,
                  16,
                  FontWeight.bold,
                  TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              BuildTextField(
                content: "ລະຫັດປະເພດລົດບັນທຸກ",
                textControl: _truckTypeCode,
              ),
              SizedBox(
                width: 30,
              ),
              BuildTextField(
                content: "ຊື່ປະເພດລົດບັນທຸກ",
                textControl: _truckTypeName,
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: SizedBox(height: defaultPadding),
              ),
              DefaultButton(
                width: 100,
                height: 40,
                press: () {
                  InsertTruckType(_truckTypeCode.text, _truckTypeName.text);
                  print("_truckTypeName=${_truckTypeName.text}");
                  print("_truckTypeCode=${_truckTypeCode.text}");
                },
                text: "ບັນທຶກ",
              ),
              SizedBox(
                width: 30,
                height: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Null> InsertTruckType(String actionNodeId,
      String truckTypeCode) async {
    try {
      var url =
      Uri.parse("${API_URL}/TTMS/api/basic_information/trucktype.php");
      var response = await http.post(
        url,
        body: json.encode({
          "actionCode": "99997",
          "actionNodeId": 2,
          "truckTypeCode": "${actionNodeId}",
          "truckTypeName": "${truckTypeCode}",
          "tireLifeKm": 0,
          "tireLifeDay": 0,
          "countWheels": 0,
          "createBy": "${staffCode}",
        }),
      );
      print('Response status: ${response.statusCode}');
      var respData = json.decode(response.body);
      print('Response: ${respData}');
      print("Response code: ${respData['responseCode']}");
      print("SESSION_EXPRIE: ${SESSION_EXPRIE}");

      if (respData['responseCode'] == SUCESSFUL) {
        DialogFail(context, "Notification!", "ເພີ່ມປະເພດລົດສຳເລັດ!!!");
      } else if (respData['responseCode'] == SESSION_EXPRIE) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        // setState(() {
        //   loadProcessBar = true;
        // });
        DialogFail(context, "Notification!",
            "system error pleace try again!!!=======");
      }
    } catch (error) {
      // setState(() {
      //   loadProcessBar = true;
      // });
      DialogFail(context, "Notification!",
          "system error pleace try again!!!111111111");
    }
  }
}


class TruckTypeDataSource extends DataTableSource {
  List<TruckTypeModel> lists = <TruckTypeModel>[];

  TruckTypeDataSource(BuildContext context, List<TruckTypeModel> listTruckType) {
    print("================${listTruckType.length}");
    lists = listTruckType;
  }

  int _selectedCount = 1;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= lists.length) return null;
    final row = lists[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value! ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(Text(row.truckTypeId.toString())),
        DataCell(Text(row.truckTypeCode.toString())),
        DataCell(Text(row.truckTypeName.toString())),
        DataCell(RaisedButton(
          onPressed: () {
            print("====${row.truckTypeId.toString()}");
          },
          child: Text("Save"),
        )),
      ],
    );
  }

  @override
  int get rowCount => lists.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
