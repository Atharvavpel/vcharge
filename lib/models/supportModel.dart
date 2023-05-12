class SupportModel {
  String? supportCustomerId;
  String? supportHostId;
  String? supportStationId;
  String? supportVendorId;
  String? supportSubject;
  String? supportDescription;
  String? supportStatus;
  String? supportCreatedAt;
  Null? supportUpdatedAt;
  Null? supportResolvedAt;
  String? supportAssignedTo;
  String? supportPriority;
  String? supportCategory;
  List<String>? supportSideResponse;
  List<String>? customerSideResponse;

  SupportModel(
      {this.supportCustomerId,
      this.supportHostId,
      this.supportStationId,
      this.supportVendorId,
      this.supportSubject,
      this.supportDescription,
      this.supportStatus,
      this.supportCreatedAt,
      this.supportUpdatedAt,
      this.supportResolvedAt,
      this.supportAssignedTo,
      this.supportPriority,
      this.supportCategory,
      this.supportSideResponse,
      this.customerSideResponse});

  SupportModel.fromJson(Map<String, dynamic> json) {
    supportCustomerId = json['supportCustomerId'];
    supportHostId = json['supportHostId'];
    supportStationId = json['supportStationId'];
    supportVendorId = json['supportVendorId'];
    supportSubject = json['supportSubject'];
    supportDescription = json['supportDescription'];
    supportStatus = json['supportStatus'];
    supportCreatedAt = json['supportCreatedAt'];
    supportUpdatedAt = json['supportUpdatedAt'];
    supportResolvedAt = json['supportResolvedAt'];
    supportAssignedTo = json['supportAssignedTo'];
    supportPriority = json['supportPriority'];
    supportCategory = json['supportCategory'];
    supportSideResponse = json['supportSideResponse'].cast<String>();
    customerSideResponse = json['customerSideResponse'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supportCustomerId'] = supportCustomerId;
    data['supportHostId'] = supportHostId;
    data['supportStationId'] = supportStationId;
    data['supportVendorId'] = supportVendorId;
    data['supportSubject'] = supportSubject;
    data['supportDescription'] = supportDescription;
    data['supportStatus'] = supportStatus;
    data['supportCreatedAt'] = supportCreatedAt;
    data['supportUpdatedAt'] = supportUpdatedAt;
    data['supportResolvedAt'] = supportResolvedAt;
    data['supportAssignedTo'] = supportAssignedTo;
    data['supportPriority'] = supportPriority;
    data['supportCategory'] = supportCategory;
    data['supportSideResponse'] = supportSideResponse;
    data['customerSideResponse'] = customerSideResponse;
    return data;
  }
}

