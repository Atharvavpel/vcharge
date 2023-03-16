class StationModel {
  String? stationName;
  String? stationLocation;
  String? stationLocationURL;
  String? stationParkingArea;
  String? stationContactNumber;
  String? stationWorkingTime;
  String? stationParkingType;
  List<String>? stationAmenity;
  List<dynamic>? stationChargerList;

  StationModel(
      {this.stationName,
      this.stationLocation,
      this.stationLocationURL,
      this.stationParkingArea,
      this.stationContactNumber,
      this.stationWorkingTime,
      this.stationParkingType,
      this.stationAmenity,
      this.stationChargerList});

  StationModel.fromJson(Map<String, dynamic> json) {
    stationName = json['stationName'];
    stationLocation = json['stationLocation'];
    stationLocationURL = json['stationLocationURL'];
    stationParkingArea = json['stationParkingArea'];
    stationContactNumber = json['stationContactNumber'];
    stationWorkingTime = json['stationWorkingTime'];
    stationParkingType = json['stationParkingType'];
    stationAmenity = json['stationAmenity'].cast<String>();
    stationChargerList = json['stationChargerList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationName'] = this.stationName;
    data['stationLocation'] = this.stationLocation;
    data['stationLocationURL'] = this.stationLocationURL;
    data['stationParkingArea'] = this.stationParkingArea;
    data['stationContactNumber'] = this.stationContactNumber;
    data['stationWorkingTime'] = this.stationWorkingTime;
    data['stationParkingType'] = this.stationParkingType;
    data['stationAmenity'] = this.stationAmenity;
    data['stationChargerList'] = this.stationChargerList;
    return data;
  }
}
