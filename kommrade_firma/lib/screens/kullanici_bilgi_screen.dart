import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kommrade_firma/main.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';
import 'package:kommrade_firma/apis/ayar_guncelle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KullaniciBilgiScreen extends StatefulWidget {
  static const String routename = "/kullanicibilgi";
  @override
  State<StatefulWidget> createState() => KullaniciBilgiScreenState();
}

class KullaniciBilgiScreenState extends State {
  List<FirmaBilgilerModel> firmalist = [];
  int _dilValue = 1;
  int _epostaValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kullanıcı Bilgileri"),
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

        this.txtkuladi.text = this.firmalist[0].kullaniciadi.toString();
        this.txtemail.text = this.firmalist[0].email.toString();
        this._dilValue = this.firmalist[0].dil;
        this._epostaValue = this.firmalist[0].maildurum;
      });
    });
  }

  TextEditingController txtkuladi = new TextEditingController();
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtsifre = new TextEditingController();
  TextEditingController txtsifretekrar = new TextEditingController();

  Widget kuladifield() {
    return TextFormField(
      controller: txtkuladi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kullanıcı Adı",
        hintText: "Kullanıcı Adı",
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

  Widget sifrefield() {
    return TextFormField(
      controller: txtsifre,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Şifre",
        hintText: "Şifre",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget sifretekrarfield() {
    return TextFormField(
      controller: txtsifretekrar,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Şifre Tekrar",
        hintText: "Şifre Tekrar",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  guncelle() {
    AyarGuncelleApi.updateayar(Degiskenler.firmaid, "", "", txtsifre.text,
            txtsifretekrar.text, _epostaValue, _dilValue, "")
        .then((response) {
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

  ayarsil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");
    prefs.setString('psw', "");
    prefs.setString('firmaid', "0");
    prefs.setString('firmadi', "");
    prefs.setString('resimurl', "");

    Degiskenler.username = txtemail.text;
    Degiskenler.psw = txtsifre.text;

    Degiskenler.firmaid = 0;
    Degiskenler.resimurl = "";
    Degiskenler.firmaadi = "";
  }

  Widget cikisbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("ÇIKIŞ"),
        onPressed: () {
          ayarsil();
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new MyApp();
          }));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
      ),
    );
  }

  Widget dilfield() {
    return Row(
      children: <Widget>[
        Text("", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 10.0,
        ),
        Text('Türkçe',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(value: 0, groupValue: _dilValue, onChanged: _dilValueChange),
        Text('English',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(value: 1, groupValue: _dilValue, onChanged: _dilValueChange)
      ],
    );
  }

  void _dilValueChange(int value) {
    setState(() {
      _dilValue = value;
    });
  }

  Widget epostafield() {
    return Row(
      children: <Widget>[
        Text("", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 10.0,
        ),
        Text('E-Posta Almak İstiyorum',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        Radio(
            value: 0, groupValue: _epostaValue, onChanged: _epostaValueChange),
        Text('E-Posta Almak İstemiyorum',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        Radio(value: 1, groupValue: _epostaValue, onChanged: _epostaValueChange)
      ],
    );
  }

  void _epostaValueChange(int value) {
    setState(() {
      _epostaValue = value;
    });
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
        kuladifield(),
        bosluk(),
        emailfield(),
        bosluk(),
        sifrefield(),
        bosluk(),
        sifretekrarfield(),
        bosluk(),
        dilfield(),
        bosluk(),
        epostafield(),
        bosluk(),
        kayitbutton(),
        bosluk(),
        cikisbutton(),
      ],
    );
  }
}
