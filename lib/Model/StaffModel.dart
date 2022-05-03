import 'package:flutter/foundation.dart';

class StaffModel extends ChangeNotifier {
  String? staffId;
  String? staffCode;
  String? fullName;
  String? email;
  String? msisdn;
  String? roleId;
  String? status;
  String? gender;
  String? birthDay;
  String? address;
  String? createDate;
  String? createBy;
  String? departmentId;
  String? branchId;
  String? modifiedDate;
  String? modified;

  StaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    staffCode = json['staffCode'];
    fullName = json['fullName'];
    email = json['email'];
    msisdn = json['msisdn'];
    roleId = json['roleId'];
    status = json['status'];
    gender = json['gender'];
    birthDay = json['birthDay'];
    address = json['address'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    departmentId = json['departmentId'];
    branchId = json['branchId'];
    modifiedDate = json['modifiedDate'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffId'] = this.staffId;
    data['staffCode'] = this.staffCode;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['msisdn'] = this.msisdn;
    data['roleId'] = this.roleId;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['birthDay'] = this.birthDay;
    data['address'] = this.address;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['departmentId'] = this.departmentId;
    data['branchId'] = this.branchId;
    data['modifiedDate'] = this.modifiedDate;
    data['modified'] = this.modified;
    return data;
  }

  StaffModel({
    this.staffId,
    this.staffCode,
    this.fullName,
    this.email,
    this.msisdn,
    this.roleId,
    this.status,
    this.gender,
    this.birthDay,
    this.address,
    this.createDate,
    this.createBy,
    this.departmentId,
    this.branchId,
    this.modifiedDate,
    this.modified,
  });

  void setInfo(StaffModel staffModel) {
    staffId = staffModel.staffId;
    staffCode = staffModel.staffCode;
    fullName = staffModel.fullName;
    email = staffModel.email;
    msisdn = staffModel.msisdn;
    roleId = staffModel.roleId;
    status = staffModel.status;
    gender = staffModel.gender;
    birthDay = staffModel.birthDay;
    address = staffModel.address;
    createDate = staffModel.createDate;
    createBy = staffModel.createBy;
    departmentId = staffModel.departmentId;
    branchId = staffModel.branchId;
    modifiedDate = staffModel.modifiedDate;
    modified = staffModel.modified;
    notifyListeners();
  }

  StaffModel getInfo() {
    StaffModel _StaffModel = new StaffModel(
        staffId: staffId,
        staffCode: staffCode,
        fullName: fullName,
        email: email,
        msisdn: msisdn,
        roleId: roleId,
        status: status,
        gender: gender,
        birthDay: birthDay,
        address: address,
        createDate: createDate,
        createBy: createBy,
        departmentId: departmentId,
        branchId: branchId,
        modifiedDate: modifiedDate,
        modified: modified);
    return _StaffModel;
  }
}
