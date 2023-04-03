import 'package:vcharge/models/transactionModel.dart';

class UserDetailsModel {
  String? userId;
  String? userFirstName;
  String? userMiddleName;
  String? userLastName;
  String? userEmail;
  String? userContactNo;
  String? userAddress;
  String? userVehicleRegNo;
  String? userVehicleChargerType;
  String? userCity;

  UserDetailsModel(
      {this.userId,
      this.userFirstName,
      this.userMiddleName,
      this.userLastName,
      this.userEmail,
      this.userContactNo,
      this.userAddress,
      this.userVehicleRegNo,
      this.userVehicleChargerType,
      this.userCity});

}
