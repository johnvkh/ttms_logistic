class TruckTypeModel {
  String? truckTypeId;
  String? truckTypeCode;
  String? truckTypeName;
  int? tireLifeKm;
  String? tireLifeDay;
  String? numberOfWheels;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;

  TruckTypeModel(
      {this.truckTypeId,
        this.truckTypeCode,
        this.truckTypeName,
        this.tireLifeKm,
        this.tireLifeDay,
        this.numberOfWheels,
        this.createBy,
        this.createDate,
        this.updateBy,
        this.updateDate});

  TruckTypeModel.fromJson(Map<String, dynamic> json) {
    truckTypeId = json['truckTypeId'];
    truckTypeCode = json['truckTypeCode'];
    truckTypeName = json['truckTypeName'];
    tireLifeKm = json['tireLifeKm'];
    tireLifeDay = json['tireLifeDay'];
    numberOfWheels = json['numberOfWheels'];
    createBy = json['createBy'];
    createDate = json['createDate'];
    updateBy = json['updateBy'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['truckTypeId'] = this.truckTypeId;
    data['truckTypeCode'] = this.truckTypeCode;
    data['truckTypeName'] = this.truckTypeName;
    data['tireLifeKm'] = this.tireLifeKm;
    data['tireLifeDay'] = this.tireLifeDay;
    data['numberOfWheels'] = this.numberOfWheels;
    data['createBy'] = this.createBy;
    data['createDate'] = this.createDate;
    data['updateBy'] = this.updateBy;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
