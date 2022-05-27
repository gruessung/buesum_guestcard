class BuesumDataModel {
  List<Personen>? personen;

  BuesumDataModel({this.personen});

  BuesumDataModel.fromJson(Map<String, dynamic> json) {
    if (json['personen'] != null) {
      personen = <Personen>[];
      json['personen'].forEach((v) {
        personen!.add(new Personen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personen != null) {
      data['personen'] = this.personen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Personen {
  String? hash;
  PersonData? personData;

  Personen({this.hash, this.personData});

  Personen.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
    personData = json['personData'] != null
        ? new PersonData.fromJson(json['personData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hash'] = this.hash;
    if (this.personData != null) {
      data['personData'] = this.personData!.toJson();
    }
    return data;
  }
}

class PersonData {
  String? abreise;
  String? betrag;
  String? qrcode;
  String? objektEscaped;
  String? qrCodeImagePng;
  String? qrcodeEscaped;
  String? name;
  String? anreiseFormat;
  String? objektId;
  String? nameEscaped;
  String? objekt;
  String? vornameEscaped;
  String? abreiseFormat;
  String? kategorie;
  String? betragEscaped;
  String? anreise;
  String? kategorieEscaped;
  String? vorname;

  PersonData(
      {this.abreise,
        this.betrag,
        this.qrcode,
        this.objektEscaped,
        this.qrCodeImagePng,
        this.qrcodeEscaped,
        this.name,
        this.anreiseFormat,
        this.objektId,
        this.nameEscaped,
        this.objekt,
        this.vornameEscaped,
        this.abreiseFormat,
        this.kategorie,
        this.betragEscaped,
        this.anreise,
        this.kategorieEscaped,
        this.vorname});

  PersonData.fromJson(Map<String, dynamic> json) {
    abreise = json['Abreise'];
    betrag = json['Betrag'];
    qrcode = json['Qrcode'];
    objektEscaped = json['ObjektEscaped'];
    qrCodeImagePng = json['qrCodeImagePng'];
    qrcodeEscaped = json['QrcodeEscaped'];
    name = json['Name'];
    anreiseFormat = json['AnreiseFormat'];
    objektId = json['ObjektId'];
    nameEscaped = json['NameEscaped'];
    objekt = json['Objekt'];
    vornameEscaped = json['VornameEscaped'];
    abreiseFormat = json['AbreiseFormat'];
    kategorie = json['Kategorie'];
    betragEscaped = json['BetragEscaped'];
    anreise = json['Anreise'];
    kategorieEscaped = json['KategorieEscaped'];
    vorname = json['Vorname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Abreise'] = this.abreise;
    data['Betrag'] = this.betrag;
    data['Qrcode'] = this.qrcode;
    data['ObjektEscaped'] = this.objektEscaped;
    data['qrCodeImagePng'] = this.qrCodeImagePng;
    data['QrcodeEscaped'] = this.qrcodeEscaped;
    data['Name'] = this.name;
    data['AnreiseFormat'] = this.anreiseFormat;
    data['ObjektId'] = this.objektId;
    data['NameEscaped'] = this.nameEscaped;
    data['Objekt'] = this.objekt;
    data['VornameEscaped'] = this.vornameEscaped;
    data['AbreiseFormat'] = this.abreiseFormat;
    data['Kategorie'] = this.kategorie;
    data['BetragEscaped'] = this.betragEscaped;
    data['Anreise'] = this.anreise;
    data['KategorieEscaped'] = this.kategorieEscaped;
    data['Vorname'] = this.vorname;
    return data;
  }
}
