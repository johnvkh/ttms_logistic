// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttms_logistic/Model/TruckTypeModel.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:ttms_logistic/Utility/DialogPopup.dart';
import 'package:ttms_logistic/Utility/ResponceCode.dart';

List<TruckTypeModel> listTructType =  <TruckTypeModel>[];

class DessertDataSource extends DataTableSource {

  final BuildContext context;

  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;


  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    // if (index >= listTructType.length) throw 'index > _desserts.length';
    final truckType = listTructType[index];
    return DataRow2.byIndex(
      index: index,
      // selected: truckType.selected,
      cells: [
        DataCell(Text('${truckType.truckTypeId}')),
        DataCell(Text('${truckType.truckTypeCode}')),
        DataCell(Text('${truckType.truckTypeName}')),
        DataCell(Text('${truckType.tireLifeKm}')),
        DataCell(Text('${truckType.tireLifeDay}')),
        DataCell(Text('${truckType.numberOfWheels}')),
        DataCell(
          RaisedButton(
            onPressed: () {},
            child: Text("OK"),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => 100;

  @override
  bool get isRowCountApproximate => true;

  @override
  int get selectedRowCount => 0;
  DessertDataSource.empty(this.context) {
    listTructType = [];
  }

  DessertDataSource(this.context, [sortedByCalories = false, this.hasRowTaps = false, this.hasRowHeightOverrides = false, this.hasZebraStripes = false]) {
    //loadTruckType();
    //listTructType = _desserts;
  }
  void selectAll(bool? checked) {
    for (final dessert in listTructType) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? listTructType.length : 0;
    notifyListeners();
  }

}

class DessertDataSourceAsync extends AsyncDataTableSource {
  DessertDataSourceAsync() {
    print('DessertDataSourceAsync created');
  }

  DessertDataSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  DessertDataSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;

  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final DesertsFakeWebService _repo = DesertsFakeWebService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }
  Future<int> getTotalRecords() {
    return Future<int>.delayed(
        const Duration(milliseconds: 0), () => _empty ? 0 : _dessertsX3.length);
  }

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    print('getRows($start, $end)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    var index = start;
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);

    var x = _empty
        ? await Future.delayed(
      const Duration(milliseconds: 2000),
          () =>
          DesertsFakeWebServiceResponse(
            0,
            [],
          ),
    )
        : await _repo.getData(
      start,
      end,
      _caloriesFilter,
      _sortColumn,
      _sortAscending,
    );

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((truckType) {
          return DataRow(
            key: ValueKey<int>(int.parse(truckType.truckTypeId!)),
            selected: truckType.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(
                  ValueKey<int>(int.parse(truckType.truckTypeId!)),
                  value,
                );
              }
            },
            cells: [
              DataCell(Text('${truckType.truckTypeId}')),
              DataCell(Text('${truckType.truckTypeCode}')),
              DataCell(Text('${truckType.truckTypeName}')),
              DataCell(Text('${truckType.tireLifeKm}')),
              DataCell(Text('${truckType.tireLifeDay}')),
              DataCell(Text('${truckType.numberOfWheels}')),
              DataCell(
                RaisedButton(
                  onPressed: () {},
                  child: Text("OK"),
                ),
              ),
            ],
          );
        }).toList());
    return r;
  }
}

class DesertsFakeWebServiceResponse {
  DesertsFakeWebServiceResponse(this.totalRecords, this.data);

  final int totalRecords;
  final List<TruckTypeModel> data;
}

class DesertsFakeWebService {

  int Function(TruckTypeModel, TruckTypeModel)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      case 'truckTypeId':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.truckTypeId!.compareTo(d2.truckTypeId!);
      case 'truckTypeCode':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.truckTypeCode!.compareTo(d2.truckTypeCode!);
      case 'truckTypeName':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.truckTypeName!.compareTo(d2.truckTypeName!);
      case 'tireLifeKm':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.tireLifeKm!.compareTo(d2.tireLifeKm!);
      case 'tireLifeDay':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.tireLifeDay!.compareTo(d2.tireLifeDay!);
      case 'numberOfWheels':
        return (TruckTypeModel d1, TruckTypeModel d2) =>
        coef * d1.numberOfWheels!.compareTo(d2.numberOfWheels!);
    }
    return null;
  }

  Future<DesertsFakeWebServiceResponse> getData(int startingAt, int count,
      RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
      Duration(
          milliseconds: startingAt == 0
              ? 2650
              : startingAt < 20
              ? 2000
              : 400),
          () {
        var result = _dessertsX3;
        return DesertsFakeWebServiceResponse(
            result.length, result.skip(startingAt).take(count).toList());
      },
    );
  }
}

int _selectedCount = 0;
late TruckTypeModel truckTypeModel;
// List<TruckTypeModel> _desserts = <TruckTypeModel>[];
List<TruckTypeModel> _dessertsX3 = listTructType.toList();

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
