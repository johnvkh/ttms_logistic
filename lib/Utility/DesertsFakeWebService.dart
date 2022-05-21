//
//
// import 'package:flutter/material.dart';
// import 'package:ttms_logistic/Model/DataSources.dart';
// import 'package:ttms_logistic/Model/TruckTypeModel.dart';
//
// class DesertsFakeWebService {
//   int Function(TruckTypeModel, TruckTypeModel)? _getComparisonFunction(
//       String column, bool ascending) {
//     var coef = ascending ? 1 : -1;
//     switch (column) {
//       case 'truckTypeId':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.truckTypeId!.compareTo(d2.truckTypeId!);
//       case 'truckTypeCode':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.truckTypeCode!.compareTo(d2.truckTypeCode!);
//       case 'truckTypeName':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.truckTypeName!.compareTo(d2.truckTypeName!);
//       case 'tireLifeKm':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.tireLifeKm!.compareTo(d2.tireLifeKm!);
//       case 'tireLifeDay':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.tireLifeDay!.compareTo(d2.tireLifeDay!);
//       case 'numberOfWheels':
//         return (TruckTypeModel d1, TruckTypeModel d2) =>
//         coef * d1.numberOfWheels!.compareTo(d2.numberOfWheels!);
//     }
//     return null;
//   }
//
//   Future<DesertsFakeWebServiceResponse> getData(int startingAt, int count,
//       RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
//     return Future.delayed(
//       Duration(
//           milliseconds: startingAt == 0
//               ? 2650
//               : startingAt < 20
//               ? 2000
//               : 400),
//           () {
//         var result = _dessertsX3;
//
//         // if (caloriesFilter != null) {
//         //   result = result
//         //       .where((e) =>
//         //           e.truckTypeCode! >= caloriesFilter.start &&
//         //           e.truckTypeCode! <= caloriesFilter.end)
//         //       .toList();
//         // }
//
//         //result.sort(_getComparisonFunction(sortedBy, sortedAsc));
//         return DesertsFakeWebServiceResponse(
//             result.length, result.skip(startingAt).take(count).toList());
//       },
//     );
//   }
// }