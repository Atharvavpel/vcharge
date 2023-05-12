// this is the model for vehicle services

class VehicleModel {
  String? vehicleId;
  String? vehicleBrandName;
  String? vehicleModelName;
  String? vehicleClass;
  String? vehicleColour;
  String? vehicleBatteryType;
  String? vehicleBatteryCapacity;
  String? vehicleAdaptorType;
  String? vehicleTimeToChargeRegular;
  String? vehicleTimeToChargeFast;
  String? vehicleChargingStandard;
  String? vehicleRange;
  String? vehicleMotorType;
  String? vehicleMotorPower;
  String? vehicleMotorTorque;
  String? vehicleDriveModes;
  String? vehicleDimentions;

  VehicleModel(
      {this.vehicleId,
      this.vehicleBrandName,
      this.vehicleModelName,
      this.vehicleClass,
      this.vehicleColour,
      this.vehicleBatteryType,
      this.vehicleBatteryCapacity,
      this.vehicleAdaptorType,
      this.vehicleTimeToChargeRegular,
      this.vehicleTimeToChargeFast,
      this.vehicleChargingStandard,
      this.vehicleRange,
      this.vehicleMotorType,
      this.vehicleMotorPower,
      this.vehicleMotorTorque,
      this.vehicleDriveModes,
      this.vehicleDimentions});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    vehicleBrandName = json['vehicleBrandName'];
    vehicleModelName = json['vehicleModelName'];
    vehicleClass = json['vehicleClass'];
    vehicleColour = json['vehicleColour'];
    vehicleBatteryType = json['vehicleBatteryType'];
    vehicleBatteryCapacity = json['vehicleBatteryCapacity'];
    vehicleAdaptorType = json['vehicleAdaptorType'];
    vehicleTimeToChargeRegular = json['vehicleTimeToChargeRegular'];
    vehicleTimeToChargeFast = json['vehicleTimeToChargeFast'];
    vehicleChargingStandard = json['vehicleChargingStandard'];
    vehicleRange = json['vehicleRange'];
    vehicleMotorType = json['vehicleMotorType'];
    vehicleMotorPower = json['vehicleMotorPower'];
    vehicleMotorTorque = json['vehicleMotorTorque'];
    vehicleDriveModes = json['vehicleDriveModes'];
    vehicleDimentions = json['vehicleDimentions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleId'] = this.vehicleId;
    data['vehicleBrandName'] = this.vehicleBrandName;
    data['vehicleModelName'] = this.vehicleModelName;
    data['vehicleClass'] = this.vehicleClass;
    data['vehicleColour'] = this.vehicleColour;
    data['vehicleBatteryType'] = this.vehicleBatteryType;
    data['vehicleBatteryCapacity'] = this.vehicleBatteryCapacity;
    data['vehicleAdaptorType'] = this.vehicleAdaptorType;
    data['vehicleTimeToChargeRegular'] = this.vehicleTimeToChargeRegular;
    data['vehicleTimeToChargeFast'] = this.vehicleTimeToChargeFast;
    data['vehicleChargingStandard'] = this.vehicleChargingStandard;
    data['vehicleRange'] = this.vehicleRange;
    data['vehicleMotorType'] = this.vehicleMotorType;
    data['vehicleMotorPower'] = this.vehicleMotorPower;
    data['vehicleMotorTorque'] = this.vehicleMotorTorque;
    data['vehicleDriveModes'] = this.vehicleDriveModes;
    data['vehicleDimentions'] = this.vehicleDimentions;
    return data;
  }
}
