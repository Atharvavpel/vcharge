// this is the model which is used for booking services

class BookingModel {
  String? bookingId;
  String? bookingType;
  String? bookingHostId;
  String? bookingCustomerId;
  String? bookingVendorId;
  String? bookingStationId;
  String? bookingDate;
  String? bookingTime;
  String? bookingCancellationReason;
  String? bookingStatus;
  String? bookingReqDate;
  String? bookingCancellationReqDate;
  String? bookingSocket;
  String? bookingStationName;
  String? bookingStationAddress;
  double? bookingAmount;

  BookingModel(
      {this.bookingId,
      this.bookingType,
      this.bookingHostId,
      this.bookingCustomerId,
      this.bookingVendorId,
      this.bookingStationId,
      this.bookingDate,
      this.bookingTime,
      this.bookingCancellationReason,
      this.bookingStatus,
      this.bookingReqDate,
      this.bookingCancellationReqDate,
      this.bookingSocket,
      this.bookingStationName,
      this.bookingStationAddress,
      this.bookingAmount});

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    bookingType = json['bookingType'];
    bookingHostId = json['bookingHostId'];
    bookingCustomerId = json['bookingCustomerId'];
    bookingVendorId = json['bookingVendorId'];
    bookingStationId = json['bookingStationId'];
    bookingDate = json['bookingDate'];
    bookingTime = json['bookingTime'];
    bookingCancellationReason = json['bookingCancellationReason'];
    bookingStatus = json['bookingStatus'];
    bookingReqDate = json['bookingReqDate'];
    bookingCancellationReqDate = json['bookingCancellationReqDate'];
    bookingSocket = json['bookingSocket'];
    bookingStationName = json['bookingStationName'];
    bookingStationAddress = json['bookingStationAddress'];
    bookingAmount = json['bookingAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingId'] = bookingId;
    data['bookingType'] = bookingType;
    data['bookingHostId'] = bookingHostId;
    data['bookingCustomerId'] = bookingCustomerId;
    data['bookingVendorId'] = bookingVendorId;
    data['bookingStationId'] = bookingStationId;
    data['bookingDate'] = bookingDate;
    data['bookingTime'] = bookingTime;
    data['bookingCancellationReason'] = bookingCancellationReason;
    data['bookingStatus'] = bookingStatus;
    data['bookingReqDate'] = bookingReqDate;
    data['bookingCancellationReqDate'] = bookingCancellationReqDate;
    data['bookingSocket'] = bookingSocket;
    data['bookingStationName'] = bookingStationName;
    data['bookingStationAddress'] = bookingStationAddress;
    data['bookingAmount'] = bookingAmount;
    return data;
  }
}
