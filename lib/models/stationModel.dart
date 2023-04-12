import 'chargerModel.dart';

class StationModel {
  String? stationName;
  String? stationHostId;
  String? stationVendorId;
  String? stationLocation;
  String? stationLatitude;
  String? stationLongitude;
  String? stationLocationURL;
  String? stationParkingArea;
  String? stationContactNumber;
  String? stationWorkingTime;
  int? chargerNumber;
  String? stationParkingType;
  List<String>? stationAmenity;
  List<ChargerModel>? chargers;
  String? stationShareId;
  String? stationStatus;
  String? stationPowerStandard;

  StationModel(
      {this.stationName,
      this.stationHostId,
      this.stationVendorId,
      this.stationLocation,
      this.stationLatitude,
      this.stationLongitude,
      this.stationLocationURL,
      this.stationParkingArea,
      this.stationContactNumber,
      this.stationWorkingTime,
      this.chargerNumber,
      this.stationParkingType,
      this.stationAmenity,
      this.chargers,
      this.stationShareId,
      this.stationStatus,
      this.stationPowerStandard});

  StationModel.fromJson(Map<String, dynamic> json) {
    stationName = json['stationName'];
    stationHostId = json['stationHostId'];
    stationVendorId = json['stationVendorId'];
    stationLocation = json['stationLocation'];
    stationLatitude = json['stationLatitude'];
    stationLongitude = json['stationLongitude'];
    stationLocationURL = json['stationLocationURL'];
    stationParkingArea = json['stationParkingArea'];
    stationContactNumber = json['stationContactNumber'];
    stationWorkingTime = json['stationWorkingTime'];
    chargerNumber = json['chargerNumber'];
    stationParkingType = json['stationParkingType'];
    stationAmenity = json['stationAmenity'].cast<String>();
    if (json['chargers'] != null) {
      chargers = <ChargerModel>[];
      json['chargers'].forEach((v) {
        chargers?.add(ChargerModel.fromJson(v));
      });
    }
    stationShareId = json['stationShareId'];
    stationStatus = json['stationStatus'];
    stationPowerStandard = json['stationPowerStandard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationName'] = stationName;
    data['stationHostId'] = stationHostId;
    data['stationVendorId'] = stationVendorId;
    data['stationLocation'] = stationLocation;
    data['stationLatitude'] = stationLatitude;
    data['stationLongitude'] = stationLongitude;
    data['stationLocationURL'] = stationLocationURL;
    data['stationParkingArea'] = stationParkingArea;
    data['stationContactNumber'] = stationContactNumber;
    data['stationWorkingTime'] = stationWorkingTime;
    data['chargerNumber'] = chargerNumber;
    data['stationParkingType'] = stationParkingType;
    data['stationAmenity'] = stationAmenity;
    if (chargers != null) {
      data['chargers'] = chargers!.map((v) => v.toJson()).toList();
    }
    data['stationShareId'] = stationShareId;
    data['stationStatus'] = stationStatus;
    data['stationPowerStandard'] = stationPowerStandard;
    return data;
  }
}

