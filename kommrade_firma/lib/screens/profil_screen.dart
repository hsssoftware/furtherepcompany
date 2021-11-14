import 'package:flutter/material.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/screens/firma_bilgi_screen.dart';
import 'package:kommrade_firma/screens/kullanici_bilgi_screen.dart';
import 'package:kommrade_firma/screens/yetkili_bilgi_screen.dart';
import 'package:kommrade_firma/screens/iletisim_bilgi_screen.dart';

class ProfilScreen extends StatefulWidget {
  static const String routename = "/profil";
  @override
  State<StatefulWidget> createState() => ProfilScreenState();
}

class ProfilScreenState extends State {
  List<FirmaBilgilerModel> firmalist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Material(
              color: Color.fromRGBO(10, 39, 97, 1),
              child: Container(
                  width: 180.0,
                  height: 180.0,
                  padding: const EdgeInsets.all(3.0),
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromRGBO(10, 39, 97, 1),
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 128, 1),
                      width: 0.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                        width: 5.0,
                      ),
                      userimage2(),
                      SizedBox(
                        height: 5.0,
                        width: 5.0,
                      ),
                      // Icon(
                      //   Icons.person,
                      //   size: 30.0,
                      // ),
                      SizedBox(
                        height: 5.0,
                        width: 5.0,
                      ),
                      Text(
                        Degiskenler.firmaadi.toString(),
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                        width: 5.0,
                      ),
                    ],
                  )),
            )
          ],
        ),
        body: Container(
          child: listegetir(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ));
  }

  getlist() {
    FirmaBilgilerapi.getfirma().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.firmalist =
            list.map((firma) => FirmaBilgilerModel.fromJson(firma)).toList();
      });
    });
  }

  void firmabilgiDetail() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FirmaBilgiScreen()));
    setState(() {
      getlist();
    });
  }

  void kullanicibilgiDetail() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => KullaniciBilgiScreen()));
    setState(() {
      getlist();
    });
  }

  void yetkilibilgiDetail() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => YetkiliBilgiScreen()));
    setState(() {
      getlist();
    });
  }

  void iletisimbilgiDetail() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => IletisimBilgiScreen()));
    setState(() {
      getlist();
    });
  }

  @override
  void initState() {
    super.initState();
    getlist();
  }

  Widget userimage2() {
    return CircleAvatar(
        radius: 25, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 70, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  Widget bosluk() {
    return Column(
      children: <Widget>[
        Text(""),
        SizedBox(
          height: 1.0,
          width: 1.0,
        )
      ],
    );
  }

  Widget ustbilgiler() {
    return Container(
      width: MediaQuery.of(context).size.width - 20.0,
      height: 270.0,
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[50],
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Align(
            child: IconButton(
                icon: Icon(Icons.settings_applications),
                onPressed: () {
                  kullanicibilgiDetail();
                }),
            alignment: Alignment.topRight,
          ),
          userimage(),
          bosluk(),
          Text(firmalist[0].firmaadi.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          bosluk(),
          Text(firmalist[0].sektoradi.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget kullanicibilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 20.0,
      height: 95.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[50],
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Align(
                child: Text(
                  " Kullanıcı Bilgileri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.topLeft,
              ),
              Align(
                child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      kullanicibilgiDetail();
                    }),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Kullanıcı Adı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].kullaniciadi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " E-Mail:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].email.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget firmabilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 20.0,
      height: 240.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[50],
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Align(
                child: Text(
                  " Firma Bilgileri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.topLeft,
              ),
              Align(
                child: IconButton(
                    icon: Icon(Icons.mode_edit),
                    onPressed: () {
                      firmabilgiDetail();
                    }),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Firma Adı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].firmaadi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Vergi Dairesi:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].vergidairesi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Vergi No:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].vergino.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Nace Kodu:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].nacekodu.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Adres:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].adres.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Posta Kodu:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].postakodu.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Kuruluş Yılı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].kurulusyil.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Çalışan Sayısı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].calisansayisi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Sektör:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].sektoradi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget iletisimbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 20.0,
      height: 200.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[50],
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Align(
                child: Text(
                  " İletişim Bilgileri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.topLeft,
              ),
              Align(
                child: IconButton(
                    icon: Icon(Icons.mode_edit),
                    onPressed: () {
                      iletisimbilgiDetail();
                    }),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Ülke:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].ulkeadi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Şehir:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].iladi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Telefon:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].tel.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " GSM:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].ceptel.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Adres:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].adres.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Web:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].web.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Faks:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].faks.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget yetkilibilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 20.0,
      height: 140.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightBlue[50],
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Align(
                child: Text(
                  " Yetkili Bilgileri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.topLeft,
              ),
              Align(
                child: IconButton(
                    icon: Icon(Icons.mode_edit),
                    onPressed: () {
                      yetkilibilgiDetail();
                    }),
                alignment: Alignment.topRight,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Adı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].yetkiliadi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Soyadı:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].yetkilisoyadi.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " Telefon:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].yetkiliceptel.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Row(
            children: [
              Text(
                " E-Mail:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              bosluk(),
              Text(
                firmalist[0].yetkilimail.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listegetir() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          ustbilgiler(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          kullanicibilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          firmabilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          iletisimbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          yetkilibilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
        ],
      ),
    );
  }
}
