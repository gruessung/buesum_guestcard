import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:guestcard/model/BuesumDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GuestcardApp());
}

class GuestcardApp extends StatelessWidget {
  const GuestcardApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Büsum Gästekarte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StartPage(title: 'Büsum Gästekarte'),
    );
  }
}

class StartPage extends StatefulWidget {
  StartPage({super.key, required this.title});

  final String title;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String jsonString = "";
  BuesumDataModel cardData = BuesumDataModel();

  void initState() {
    super.initState();
    _getBarcode();
    // _prefs.then((SharedPreferences prefs) {
    //  barcode = prefs.getString("barcode") ?? "";
    //return prefs.getString('barcode') ?? "";
    //  }).toString();
  }

  Future<void> _getBarcode() async {
    final SharedPreferences prefs = await _prefs;

    String? tmp_json = prefs.getString("json");

    setState(() {
      jsonString = tmp_json!;
      cardData = BuesumDataModel.fromJson(json.decode(tmp_json!));
    });
  }

  Future<void> _scanBarcode() async {
    final SharedPreferences prefs = await _prefs;

    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Abbruch", true, ScanMode.QR);

    //nur abrufen, wenn der gescannte Barcode länger als 3 Zeichen ist, um Fehlscans zu vermeiden
    if (barcodeScanRes.length > 3) {
      String hash = barcodeScanRes.replaceAll("https://moin.buesum.de/de/buesum/wlan/guestcard?hash=", "");
      var url = Uri.parse("https://meldeschein.avs.de/buesum/digitale-gaestekarte.do?event=getPersonList&hash=" + hash);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        await prefs.setString('json', response.body);

        setState(() {
          jsonString = response.body;
          cardData = BuesumDataModel.fromJson(json.decode(response.body));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Fehlerhaften QR Code gescannt. Abruf nicht möglich.")));
        setState(() {
          jsonString = "";
          cardData = BuesumDataModel();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (cardData.personen != null)
                  ? Column(
                      children: [
                        QrImage(
                          data: cardData.personen!.first.personData!.qrcode
                              .toString(),
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Text(
                            cardData.personen!.first.personData!.qrcode
                                .toString(),
                            style: const TextStyle(fontSize: 15)),
                        Container(height: 20, width: 100),
                        Text(
                            "${cardData.personen!.first.personData!.vornameEscaped.toString()} ${cardData.personen!.first.personData!.nameEscaped.toString()} (${cardData.personen!.first.personData!.kategorieEscaped.toString()})",
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            "Gültig bis: ${cardData.personen!.first.personData!.abreiseFormat.toString()}",
                            style: const TextStyle(fontSize: 20))
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const Text(
                            "Bitte scanne den \"Web QR Code\" deiner Gästekarte.",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset('assets/dummy.png'),
                        ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarcode,
        tooltip: 'Scan',
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}
