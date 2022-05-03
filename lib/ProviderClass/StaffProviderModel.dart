import 'package:flutter/foundation.dart';
import 'package:ttms_logistic/Model/StaffModel.dart';

class StaffProviderModel extends ChangeNotifier {
  StaffModel? _staffModel;
  int a=0;

  void setInfo(StaffModel staffModel) {
    _staffModel = staffModel;
    notifyListeners();
  }
}
