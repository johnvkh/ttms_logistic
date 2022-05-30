// import 'package:flutter/material.dart';
// import 'package:ttms_logistic/Model/TruckTypeModel.dart';
//
// class TruckTypeDataSource extends DataTableSource {
//   List<TruckTypeModel> lists = <TruckTypeModel>[];
//
//   TruckTypeDataSource(BuildContext context, List<TruckTypeModel> listTruckType) {
//     lists = listTruckType;
//   }
//
//   int _selectedCount = 1;
//
//   @override
//   DataRow? getRow(int index) {
//     assert(index >= 0);
//     if (index >= lists.length) return null;
//     final row = lists[index];
//     return DataRow.byIndex(
//       index: index,
//       selected: row.selected,
//       // onSelectChanged: (value) {
//       //   if (row.selected != value) {
//       //     _selectedCount += value! ? 1 : -1;
//       //     assert(_selectedCount >= 0);
//       //     row.selected = value;
//       //     notifyListeners();
//       //   }
//       // },
//       cells: [
//         DataCell(Text(row.truckTypeId.toString())),
//         DataCell(Text(row.truckTypeCode.toString())),
//         DataCell(Text(row.truckTypeName.toString())),
//         DataCell(RaisedButton(
//           onPressed: () {
//             print("====${row.truckTypeId.toString()}");
//           },
//           child: Text("Save"),
//         )),
//       ],
//     );
//   }
//
//   @override
//   int get rowCount => lists.length;
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   int get selectedRowCount => 0;
// }