import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:ttms_logistic/Model/TruckTypeModel.dart';
import 'package:http/http.dart' as http;
import 'package:ttms_logistic/Utility/DialogPopup.dart';
import 'package:ttms_logistic/Utility/ResponceCode.dart';
import 'package:ttms_logistic/Utility/WidgetUtility.dart';

class DataTableDemo extends StatefulWidget {
  @override
  State<DataTableDemo> createState() => _DataTableDemoState();
}

int rowPerPage = 1;

class _DataTableDemoState extends State<DataTableDemo> {
  List<TruckTypeModel> listTruckType = <TruckTypeModel>[];
  late TruckTypeModel truckTypeModel;

  @override
  void initState() {
    super.initState();
    loadTruckType();
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Tables'),
      ),
      // body: Container(
      //       //   child: ListView(
      //       //     padding: const EdgeInsets.all(16),
      //       //     children: [
      //       //       PaginatedDataTable(
      //       //         header: Text('Header Text'),
      //       //         rowsPerPage: rowPerPage,
      //       //         columns: [
      //       //           DataColumn(label: Text('Header B')),
      //       //           DataColumn(label: Text('Header B')),
      //       //           DataColumn(label: Text('Header C')),
      //       //           DataColumn(label: Text('Header D')),
      //       //         ],
      //       //         source: _DataSource(context, listTruckType),
      //       //       ),
      //       //     ],
      //       //   ),
      //       // ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                header: Text('Header Text'),
                rowsPerPage: rowPerPage,
                columns: [
                  DataColumn(label: Text('Header B')),
                  DataColumn(label: Text('Header B')),
                  DataColumn(label: Text('Header C')),
                  DataColumn(label: Text('Header D')),
                ],
                source: _DataSource(context, listTruckType),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  List<TruckTypeModel> lists = <TruckTypeModel>[];

  _DataSource(BuildContext context, List<TruckTypeModel> listTruckType) {
    lists = listTruckType;
  }

  int _selectedCount = 0;

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
