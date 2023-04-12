class ConnectorModel {
  String? connectorType;
  String? connectorSocket;
  String? connectorStatus;
  String? connectorOutputPower;
  String? connectorCharges;

  ConnectorModel(
      {this.connectorType,
      this.connectorSocket,
      this.connectorStatus,
      this.connectorOutputPower,
      this.connectorCharges});

  ConnectorModel.fromJson(Map<String, dynamic> json) {
    connectorType = json['connectorType'];
    connectorSocket = json['connectorSocket'];
    connectorStatus = json['connectorStatus'];
    connectorOutputPower = json['connectorOutputPower'];
    connectorCharges = json['connectorCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectorType'] = this.connectorType;
    data['connectorSocket'] = this.connectorSocket;
    data['connectorStatus'] = this.connectorStatus;
    data['connectorOutputPower'] = this.connectorOutputPower;
    data['connectorCharges'] = this.connectorCharges;
    return data;
  }
}