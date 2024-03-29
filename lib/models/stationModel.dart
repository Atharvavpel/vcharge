import 'chargerModel.dart';

class StationModel {
  String? stationId;
  String? stationName;
  String? stationHostId;
  String? stationVendorId;
  String? stationArea;
  double? stationLatitude;
  double? stationLongitude;
  String? stationLocationURL;
  String? stationAddressLineOne;
  String? stationAddressLineTwo;
  String? stationCity;
  String? stationZipCode;
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
      {this.stationId,
      this.stationName,
      this.stationHostId,
      this.stationVendorId,
      this.stationArea,
      this.stationLatitude,
      this.stationLongitude,
      this.stationLocationURL,
      this.stationAddressLineOne,
      this.stationAddressLineTwo,
      this.stationCity,
      this.stationZipCode,
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
    stationId = json['stationId'];
    stationName = json['stationName'];
    stationHostId = json['stationHostId'];
    stationVendorId = json['stationVendorId'];
    stationArea = json['stationArea'];
    stationLatitude = json['stationLatitude'];
    stationLongitude = json['stationLongitude'];
    stationLocationURL = json['stationLocationURL'];
    stationAddressLineOne = json['stationAddressLineOne'];
    stationAddressLineTwo = json['stationAddressLineTwo'];
    stationCity = json['stationCity'];
    stationZipCode = json['stationZipCode'];
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

  get stationClosingTime => null;

  get stationOpeningTime => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationId'] = stationId;
    data['stationName'] = stationName;
    data['stationHostId'] = stationHostId;
    data['stationVendorId'] = stationVendorId;
    data['stationArea'] = stationArea;
    data['stationLatitude'] = stationLatitude;
    data['stationLongitude'] = stationLongitude;
    data['stationLocationURL'] = stationLocationURL;
    data['stationAddressLineOne'] = stationAddressLineOne;
    data['stationAddressLineTwo'] = stationAddressLineTwo;
    data['stationCity'] = stationCity;
    data['stationZipCode'] = stationZipCode;
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

//Following is the model for some specific details of station
class RequiredStationDetailsModel {
  String? stationId;
  String? stationName;
  String? stationArea;
  double? stationLatitude;
  double? stationLongitude;
  String? stationCity;
  String? stationStatus;

  RequiredStationDetailsModel(
      {this.stationId,
      this.stationName,
      this.stationArea,
      this.stationLatitude,
      this.stationLongitude,
      this.stationCity,
      this.stationStatus});

  RequiredStationDetailsModel.fromJson(Map<String, dynamic> json) {
    stationId = json['stationId'];
    stationName = json['stationName'];
    stationArea = json['stationArea'];
    stationLatitude = json['stationLatitude'];
    stationLongitude = json['stationLongitude'];
    stationCity = json['stationCity'];
    stationStatus = json['stationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationId'] = stationId;
    data['stationName'] = stationName;
    data['stationArea'] = stationArea;
    data['stationLatitude'] = stationLatitude;
    data['stationLongitude'] = stationLongitude;
    data['stationCity'] = stationCity;
    data['stationStatus'] = stationStatus;
    return data;
  }
}

//Following is the model for some specific details of station for favourite page
class FovouriteStationDetailsModel {
  String? stationId;
  String? stationName;
  String? stationAddressLineOne;
  String? stationAddressLineTwo;
  String? stationCity;
  String? stationStatus;

  FovouriteStationDetailsModel({
    this.stationId,
    this.stationName,
    this.stationAddressLineOne,
    this.stationAddressLineTwo,
    this.stationCity,
    this.stationStatus,
  });

  FovouriteStationDetailsModel.fromJson(Map<String, dynamic> json) {
    stationId = json['stationId'];
    stationName = json['stationName'];
    stationAddressLineOne = json['stationAddressLineOne'];
    stationAddressLineTwo = json['stationAddressLineTwo'];
    stationCity = json['stationCity'];
    stationStatus = json['stationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationId'] = stationId;
    data['stationName'] = stationName;
    data['stationAddressLineOne'] = stationAddressLineOne;
    data['stationAddressLineTwo'] = stationAddressLineTwo;
    data['stationCity'] = stationCity;
    data['stationStatus'] = stationStatus;
    return data;
  }
}
