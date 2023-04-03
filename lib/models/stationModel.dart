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
  String? stationParkingType;
  List<dynamic>? stationAmenity;
  List<dynamic>? chargers;
  String? stationStatus;
  List<dynamic>? stationBooking;
  String? stationPowerStandard;

  StationModel(
      {this.stationName,
      this.stationLocation,
      this.stationLatitude,
      this.stationLongitude,
      this.stationLocationURL,
      this.stationParkingArea,
      this.stationContactNumber,
      this.stationWorkingTime,
      this.stationParkingType,
      this.stationAmenity,
      this.chargers,
      this.stationStatus,
      this.stationPowerStandard});

}

class StationChargerList {
  String? chargerName;
  String? chargerId;
  String? chargerCostPerKWH;
  String? chargerRFID;
  String? chargerConnectorType;
  String? chargerStatus;
  String? chargerType;

  StationChargerList(
      {this.chargerName,
      this.chargerId,
      this.chargerCostPerKWH,
      this.chargerRFID,
      this.chargerConnectorType,
      this.chargerStatus,
      this.chargerType});

}

class StationBooking {
  String? bookingType;
  String? bookingCustomerId;
  String? bookingStationId;
  String? bookingDate;
  String? bookingTime;
  String? bookingStatus;

  StationBooking(
      {this.bookingType,
      this.bookingCustomerId,
      this.bookingStationId,
      this.bookingDate,
      this.bookingTime,
      this.bookingStatus});

}
