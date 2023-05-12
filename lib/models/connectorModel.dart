// this is the model class for the connector services

class ConnectorModel {
  String? connectorId;
  String? connectorType;
  String? connectorSocket;
  String? connectorStatus;
  String? connectorOutputPower;
  String? connectorCharges;

  ConnectorModel(
      {
      this.connectorId,
      this.connectorType,
      this.connectorSocket,
      this.connectorStatus,
      this.connectorOutputPower,
      this.connectorCharges});

  ConnectorModel.fromJson(Map<String, dynamic> json) {
    connectorId = json['connectorId'];
    connectorType = json['connectorType'];
    connectorSocket = json['connectorSocket'];
    connectorStatus = json['connectorStatus'];
    connectorOutputPower = json['connectorOutputPower'];
    connectorCharges = json['connectorCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connectorId'] = connectorId;
    data['connectorType'] = connectorType;
    data['connectorSocket'] = connectorSocket;
    data['connectorStatus'] = connectorStatus;
    data['connectorOutputPower'] = connectorOutputPower;
    data['connectorCharges'] = connectorCharges;
    return data;
  }
}