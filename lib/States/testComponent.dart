import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttms_logistic/Model/DataSources.dart';
import 'package:ttms_logistic/Model/TruckTypeModel.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:ttms_logistic/Utility/DialogPopup.dart';

import '../Utility/ResponceCode.dart';


class PaginatedDataTableDemo extends StatefulWidget {

  @override
  PaginatedDataTableDemoState createState() => PaginatedDataTableDemoState();
}

class PaginatedDataTableDemoState extends State<PaginatedDataTableDemo>
    with RestorationMixin {
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage = RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  late DessertDataSource _dessertsDataSource;
  List<TruckTypeModel> listTruckType = <TruckTypeModel>[];
  late TruckTypeModel truckTypeModel;
  bool initialized = false;

  @override
  String get restorationId => 'paginated_data_table_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');
  }

  @override
  void initState() {
    super.initState();
    loadTruckType();
  }
  Future<Null> loadTruckType()async{
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
          setState(() {
            truckTypeModel = TruckTypeModel.fromJson(map);
            listTruckType.add(truckTypeModel);
          });
        }

        DialogFail(context, "Notification!", "ເພີ່ມປະເພດລົດສຳເລັດ!!!");
      } else if (respData['responseCode'] == SESSION_EXPRIE) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        DialogFail(
            context, "Notification!", "system error pleace try again!!!=======");
      }
    } catch (error) {
      DialogFail(context, "Notification!", "system error pleace try again!!!111111111");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      _dessertsDataSource = DessertDataSource(context);
      initialized = true;
    }
    // _dessertsDataSource.addListener(_updateSelectedDessertRowListener);
  }

  // void _updateSelectedDessertRowListener() {
  //   //   _dessertSelections.setDessertSelections(listTruckType);
  //   // }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    // _dessertsDataSource.removeListener(_updateSelectedDessertRowListener);
    _dessertsDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'paginated_data_table_list_view',
      padding: const EdgeInsets.all(16),
      children: [
        PaginatedDataTable(
          header: const Text('Paginated Data Table'),
          rowsPerPage: _rowsPerPage.value,
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage.value = value!;
            });
          },
          initialFirstRowIndex: _rowIndex.value,
          onPageChanged: (rowIndex) {
            setState(() {
              _rowIndex.value = rowIndex;
            });
          },
          columns: [
            DataColumn(
              label: const Text('truck Type Id'),
            ),
            DataColumn(
              label: const Text('truck Type Code'),
              numeric: true,

            ),
            DataColumn(
              label: const Text('truck Type Name'),
              numeric: true,
            ),
            DataColumn(
              label: const Text('tire Life Km'),
              numeric: true,
            ),
            DataColumn(
              label: const Text('tire Life Day'),
              numeric: true,

            ),
            DataColumn(
              label: const Text('number Of Wheels'),
              numeric: true,
            ),

          ],
          source: _dessertsDataSource,
        ),

      ],
    );
  }
}
