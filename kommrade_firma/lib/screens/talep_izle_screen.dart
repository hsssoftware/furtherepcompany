import 'package:kommrade_firma/apis/talepdetay_api.dart';
import 'package:kommrade_firma/models/talepdetay.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kommrade_firma/screens/talep_basvuranlar_screen.dart';
import 'package:kommrade_firma/apis/talep_tip_guncelle_api.dart';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/talep_sil_api.dart';
import 'package:kommrade_firma/screens/talep_guncelle_screen.dart';

class TalepIzle extends StatefulWidget {
  static const String routename = "/talepizle";
  @override
  State<StatefulWidget> createState() => TalepIzleState();
}

class TalepIzleState extends State {
  List<TalepDetayModel> taleplerlist = [];
  bool sort = false;
  int sayfa = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taleplerim"),
      ),
      body: listegetir(),
    );
  }

  void duzenleDetail() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TalepGuncelleScreen()));
    setState(() {
      getdetay();
    });
  }

  Widget duzenlebutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("DÜZENLE"),
        onPressed: () {
          duzenleDetail();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  void basvuruDetail() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TalepBasvuranlarScreen()));
    setState(() {
      getdetay();
    });
  }

  Widget basvurubutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("BAŞVURANLAR"),
        onPressed: () {
          basvuruDetail();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      ),
    );
  }

  mesaj(BuildContext context, String deger) {
    var alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text(deger),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  pasifguncelle() {
    TalepTipGuncelleApi.updatetalep(Degiskenler.talepid, 0).then((response) {
      setState(() {
        if (response.body.toString() == "1") {
          Navigator.pop(context);
        } else {
          mesaj(context, "Güncelleme yapılamadı...");
        }
      });
    });
  }

  Widget pasifbutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("PASİFE AL"),
        onPressed: () {
          pasifguncelle();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(100, 30, 22, 1))),
      ),
    );
  }

  aktifguncelle() {
    TalepTipGuncelleApi.updatetalep(Degiskenler.talepid, 1).then((response) {
      setState(() {
        if (response.body.toString() == "1") {
          Navigator.pop(context);
        } else {
          mesaj(context, "Güncelleme yapılamadı...");
        }
      });
    });
  }

  Widget aktifbutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("YAYINLA"),
        onPressed: () {
          aktifguncelle();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(21, 67, 96, 1))),
      ),
    );
  }

  arsivguncelle() {
    TalepTipGuncelleApi.updatetalep(Degiskenler.talepid, 3).then((response) {
      setState(() {
        if (response.body.toString() == "1") {
          Navigator.pop(context);
        } else {
          mesaj(context, "Güncelleme yapılamadı...");
        }
      });
    });
  }

  Widget arsivbutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("ARŞİVLE"),
        onPressed: () {
          arsivguncelle();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(98, 101, 103, 1))),
      ),
    );
  }

  talepsil() {
    TalepSilApi.deletetalep(Degiskenler.talepid).then((response) {
      setState(() {
        if (response.body.toString() == "1") {
          Navigator.pop(context);
        } else {
          mesaj(context, "Silme yapılamadı...");
        }
      });
    });
  }

  Widget talepsilbutton() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 30.0,
      child: ElevatedButton(
        child: Text("TALEBİ SİL"),
        onPressed: () {
          talepsil();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
      ),
    );
  }

  Widget listegetir() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Firma Adı:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                this.taleplerlist[0].firmadi,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Pozisyon:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                this.taleplerlist[0].pozisyon,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Tarih:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 37.0,
              ),
              Text(
                DateFormat('dd.MM.yyyy').format(DateTime.parse(
                        this.taleplerlist[0].bastar.toString())) +
                    " - " +
                    DateFormat('dd.MM.yyyy').format(
                        DateTime.parse(this.taleplerlist[0].bittar.toString())),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Ülke:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 41.0,
              ),
              Text(
                this.taleplerlist[0].ulke,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Şehir:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 38.0,
              ),
              Text(
                this.taleplerlist[0].il,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Tecrübe:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 18.0,
              ),
              Text(
                this.taleplerlist[0].tecrube.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Tic.Türü:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                this.taleplerlist[0].ticaretturu,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Açıklama:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                this.taleplerlist[0].aciklama,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Görüntüleme : " +
                this.taleplerlist[0].goruntulemesayi.toString() +
                "  Başvuru Sayısı : " +
                this.taleplerlist[0].basvurusayi.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          butongrup(),
        ],
      ),
    );
  }

  Widget bosluk() {
    return Column(
      children: <Widget>[
        Text(""),
        SizedBox(
          width: 5.0,
        )
      ],
    );
  }

  Widget butongrup() {
    return Column(
      children: [
        Row(
          children: [
            duzenlebutton(),
            bosluk(),
            basvurubutton(),
          ],
        ),
        Row(
          children: [
            aktifbutton(),
            bosluk(),
            pasifbutton(),
          ],
        ),
        Row(
          children: [
            arsivbutton(),
            bosluk(),
            talepsilbutton(),
          ],
        ),
      ],
    );
  }

  getdetay() {
    TalepDetayApi.gettalep().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.taleplerlist =
            list.map((talepler) => TalepDetayModel.fromJson(talepler)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdetay();
  }
}
