import 'package:vcharge/models/connectorModel.dart';

class ChargerModel {
  String? chargerName;
  int? chargerNumber;
  String? chargerInputVoltage;
  String? chargerOutputVoltage;
  String? chargerMinInputAmpere;
  String? chargerMaxInputAmpere;
  String? chargerOutputAmpere;
  String? chargerInputFrequency;
  String? chargerOutputFrequency;
  String? chargerIPRating;
  String? chargerMountType;
  int? chargerNumberOfConnector;
  String? isRFID;
  String? chargerSerialNumber;
  String? chargerOCPPProtocol;
  String? chargerConnectorType;
  String? isAppSupport;
  String? isTBCutOff;
  String? isAntitheft;
  String? isLEDDisplay;
  String? isLEDIndications;
  String? isSmart;
  List<ConnectorModel>? connectors;

  ChargerModel(
      {this.chargerName,
      this.chargerNumber,
      this.chargerInputVoltage,
      this.chargerOutputVoltage,
      this.chargerMinInputAmpere,
      this.chargerMaxInputAmpere,
      this.chargerOutputAmpere,
      this.chargerInputFrequency,
      this.chargerOutputFrequency,
      this.chargerIPRating,
      this.chargerMountType,
      this.chargerNumberOfConnector,
      this.isRFID,
      this.chargerSerialNumber,
      this.chargerOCPPProtocol,
      this.chargerConnectorType,
      this.isAppSupport,
      this.isTBCutOff,
      this.isAntitheft,
      this.isLEDDisplay,
      this.isLEDIndications,
      this.isSmart,
      this.connectors});

  ChargerModel.fromJson(Map<String, dynamic> json) {
    chargerName = json['chargerName'];
    chargerNumber = json['chargerNumber'];
    chargerInputVoltage = json['chargerInputVoltage'];
    chargerOutputVoltage = json['chargerOutputVoltage'];
    chargerMinInputAmpere = json['chargerMinInputAmpere'];
    chargerMaxInputAmpere = json['chargerMaxInputAmpere'];
    chargerOutputAmpere = json['chargerOutputAmpere'];
    chargerInputFrequency = json['chargerInputFrequency'];
    chargerOutputFrequency = json['chargerOutputFrequency'];
    chargerIPRating = json['chargerIPRating'];
    chargerMountType = json['chargerMountType'];
    chargerNumberOfConnector = json['chargerNumberOfConnector'];
    isRFID = json['isRFID'];
    chargerSerialNumber = json['chargerSerialNumber'];
    chargerOCPPProtocol = json['chargerOCPPProtocol'];
    chargerConnectorType = json['chargerConnectorType'];
    isAppSupport = json['isAppSupport'];
    isTBCutOff = json['isTBCutOff'];
    isAntitheft = json['isAntitheft'];
    isLEDDisplay = json['isLEDDisplay'];
    isLEDIndications = json['isLEDIndications'];
    isSmart = json['isSmart'];
    if (json['connectors'] != null) {
      connectors = <ConnectorModel>[];
      json['connectors'].forEach((v) {
        connectors!.add(ConnectorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chargerName'] = this.chargerName;
    data['chargerNumber'] = this.chargerNumber;
    data['chargerInputVoltage'] = this.chargerInputVoltage;
    data['chargerOutputVoltage'] = this.chargerOutputVoltage;
    data['chargerMinInputAmpere'] = this.chargerMinInputAmpere;
    data['chargerMaxInputAmpere'] = this.chargerMaxInputAmpere;
    data['chargerOutputAmpere'] = this.chargerOutputAmpere;
    data['chargerInputFrequency'] = this.chargerInputFrequency;
    data['chargerOutputFrequency'] = this.chargerOutputFrequency;
    data['chargerIPRating'] = this.chargerIPRating;
    data['chargerMountType'] = this.chargerMountType;
    data['chargerNumberOfConnector'] = this.chargerNumberOfConnector;
    data['isRFID'] = this.isRFID;
    data['chargerSerialNumber'] = this.chargerSerialNumber;
    data['chargerOCPPProtocol'] = this.chargerOCPPProtocol;
    data['chargerConnectorType'] = this.chargerConnectorType;
    data['isAppSupport'] = this.isAppSupport;
    data['isTBCutOff'] = this.isTBCutOff;
    data['isAntitheft'] = this.isAntitheft;
    data['isLEDDisplay'] = this.isLEDDisplay;
    data['isLEDIndications'] = this.isLEDIndications;
    data['isSmart'] = this.isSmart;
    if (this.connectors != null) {
      data['connectors'] = this.connectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
