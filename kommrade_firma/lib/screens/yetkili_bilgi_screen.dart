import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';
import 'package:kommrade_firma/apis/yetkili_bilgi_guncelle.dart';

class YetkiliBilgiScreen extends StatefulWidget {
  static const String routename = "/yetkilibilgi";
  @override
  State<StatefulWidget> createState() => YetkiliBilgiScreenState();
}

class YetkiliBilgiScreenState extends State {
  List<FirmaBilgilerModel> firmalist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yetkili Bilgileri"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: listegetir(),
            margin: EdgeInsets.all(10.0),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getlist();
  }

  getlist() {
    FirmaBilgilerapi.getfirma().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.firmalist =
            list.map((firma) => FirmaBilgilerModel.fromJson(firma)).toList();

        this.txtad.text = this.firmalist[0].yetkiliadi.toString();
        this.txtsoyad.text = this.firmalist[0].yetkilisoyadi.toString();
        this.txtemail.text = this.firmalist[0].yetkilimail.toString();
        this.txttelefon.text = this.firmalist[0].yetkiliceptel.toString();
      });
    });
  }

  TextEditingController txtad = new TextEditingController();
  TextEditingController txtsoyad = new TextEditingController();
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txttelefon = new TextEditingController();

  Widget adifield() {
    return TextFormField(
      controller: txtad,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Adı",
        hintText: "Adı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget soyadifield() {
    return TextFormField(
      controller: txtsoyad,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Soyadı",
        hintText: "Soyadı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget emailfield() {
    return TextFormField(
      controller: txtemail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "E-Mail",
        hintText: "E-Mail",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget telefonfield() {
    return TextFormField(
      controller: txttelefon,
      keyboardType: TextInputType.visiblePassword,
      obscureText: false,
      decoration: InputDecoration(
        labelText: "Telefon",
        hintText: "Telefon",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  guncelle() {
    YetkiliBilgiGuncelleApi.updateyetkilibilgi(
      Degiskenler.firmaid,
      txtad.text,
      txtsoyad.text,
      txttelefon.text,
      txtemail.text,
    ).then((response) {
      setState(() {
        if (response.body.toString() == "1") {
          Navigator.pop(context);
        } else {
          mesaj(context, "Güncelleme yapılamadı...");
        }
      });
    });
  }

  Widget kayitbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("KAYDET"),
        onPressed: () {
          guncelle();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 25, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  mesaj(BuildContext context, String deger) {
    var alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text(deger),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
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

  Widget listegetir() {
    return Column(
      children: <Widget>[
        bosluk(),
        adifield(),
        bosluk(),
        soyadifield(),
        bosluk(),
        telefonfield(),
        bosluk(),
        emailfield(),
        bosluk(),
        kayitbutton(),
      ],
    );
  }
}
