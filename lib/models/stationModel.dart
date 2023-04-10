import 'package:vcharge/models/chargerModel.dart';

class StationModel {
  String stationName;
  String stationLocation;
  String stationLatitude;
  String stationLongitude;
  String stationLocationURL;
  String stationParkingArea;
  String stationContactNumber;
  String stationWorkingTime;
  int chargerNumber;
  String stationParkingType;
  List<dynamic> stationAmenity;
  List<dynamic> chargers;
  String stationShareId;
  String stationStatus;
  String stationPowerStandard;

  StationModel({
    required this.stationName,
    required this.stationLocation,
    required this.stationLatitude,
    required this.stationLongitude,
    required this.stationLocationURL,
    required this.stationParkingArea,
    required this.stationContactNumber,
    required this.stationWorkingTime,
    required this.chargerNumber,
    required this.stationParkingType,
    required this.stationAmenity,
    required this.chargers,
    required this.stationShareId,
    required this.stationStatus,
    required this.stationPowerStandard,
  });
}
