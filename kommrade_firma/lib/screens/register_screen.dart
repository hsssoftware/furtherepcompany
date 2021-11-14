import 'package:flutter/material.dart';
import 'package:kommrade_firma/apis/register_api.dart';
import 'package:kommrade_firma/models/register.dart';
import 'dart:convert';
import 'package:kommrade_firma/apis/sektor_api.dart';
import 'package:kommrade_firma/models/sektorler.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:kommrade_firma/models/degiskenler.dart';

class RegisterScreen extends StatefulWidget {
  static const String routename = "/register";
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State {
  List<Register> kayitlist = [];

  List<DropdownMenuItem<String>> _sektorItems;
  String _secilensektor;
  List<Sektormodel> sektorlist = [];
  int sektorid = 0;
  List _sektorlar = [""];
  List _sektorid = [""];
  int _ticaretturuValue = 0;
  int _sozlesmeValue = 0;
  int _sirketturuValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("KAYIT OL"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: listegetir(),
            margin: EdgeInsets.all(10.0),
          ),
        ));
  }

  TextEditingController txtfirmaad = new TextEditingController();
  TextEditingController txtadres = new TextEditingController();
  TextEditingController txtkullaniciadi = new TextEditingController();
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtsifre = new TextEditingController();
  TextEditingController txtticareturu = new TextEditingController();
  TextEditingController txtsektor = new TextEditingController();
  TextEditingController txtsirketturu = new TextEditingController();
  TextEditingController txtvno = new TextEditingController();
  TextEditingController txtvd = new TextEditingController();

  Widget firmaadfield() {
    return TextFormField(
      controller: txtfirmaad,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Firma Adı",
        hintText: "Firma Adı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget adresfield() {
    return TextFormField(
      controller: txtadres,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Adres",
        hintText: "Adres",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget vdfield() {
    return TextFormField(
      controller: txtvd,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Vergi Dairesi",
        hintText: "Vergi Dairesi",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget vnofield() {
    return TextFormField(
      controller: txtvno,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Vergi No",
        hintText: "Vergi No",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget kuladifield() {
    return TextFormField(
      controller: txtkullaniciadi,
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
      keyboardType: TextInputType.emailAddress,
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

  @override
  void initState() {
    super.initState();
    getsektor();
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

  kayitol() {
    String sonuc = "";
    Registerapi.postregister(
            txtfirmaad.text,
            txtadres.text,
            txtvno.text,
            txtvd.text,
            txtemail.text,
            txtkullaniciadi.text,
            txtsifre.text,
            "",
            "",
            _ticaretturuValue,
            sektorid,
            _sirketturuValue)
        .then((response) {
      setState(() {
        sonuc = response.statusCode.toString();
      });
      if (sonuc == "200") {
        Degiskenler.username = txtemail.text;
        Degiskenler.psw = txtsifre.text;
        mesaj(context, "Kayıt başarılı...");
        Navigator.pop(context);
      } else {
        mesaj(context, "Kayıt oluşturulamadı");
      }
    });
  }

  Widget kayitbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("KAYIT OL"),
        onPressed: () {
          if (txtfirmaad.text == "") {
            mesaj(context, "Firma adı girilmemiş..");
            return;
          }
          if (txtadres.text == "") {
            mesaj(context, "Adres girilmemiş..");
            return;
          }
          if (txtvd.text == "") {
            mesaj(context, "Vergi Dairesi girilmemiş..");
            return;
          }
          if (txtvno.text == "") {
            mesaj(context, "Vergi Numarası girilmemiş..");
            return;
          }
          if (txtkullaniciadi.text == "") {
            mesaj(context, "Kullanıcı adı girilmemiş..");
            return;
          }
          if (txtemail.text == "") {
            mesaj(context, "E-Mail girilmemiş..");
            return;
          }
          if (txtsifre.text == "") {
            mesaj(context, "Şifre girilmemiş..");
            return;
          }
          if (sektorid <= 0) {
            mesaj(context, "Sektör seçilmemiş..");
            return;
          }
          if (_ticaretturuValue <= 0) {
            mesaj(context, "Ticaret türü seçilmemiş..");
            return;
          }
          if (_sirketturuValue <= 0) {
            mesaj(context, "Şirket tipi seçilmemiş..");
            return;
          }
          if (_sozlesmeValue <= 0) {
            mesaj(context, "Sözleşme onayı seçilmemiş..");
            return;
          }

          kayitol();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  Widget image() {
    return Image.asset(
      "assets/images/logo.png",
      width: 150.0,
      height: 150.0,
    );
  }

  getsektor() {
    Sektorapi.getsektor().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.sektorlist =
            list.map((sektor) => Sektormodel.fromJson(sektor)).toList();
      });
      if (this.sektorlist.length > 0) {
        this._sektorlar.clear();
        this._sektorid.clear();
        this._sektorlar.add("Seçilmemiş");
        this._sektorid.add("0");
        for (var i = 0; i <= this.sektorlist.length - 1; i += 1) {
          this._sektorlar.add(sektorlist[i].sektor.toString());
          this._sektorid.add(sektorlist[i].id.toString());
        }
        _sektorItems = getsektorItems();
        _secilensektor = null;
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getsektorItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String sektor in _sektorlar) {
      items.add(new DropdownMenuItem(
          value: sektor,
          child: new Text(sektor,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return items;
  }

  Widget sektorfield() {
    return Row(
      children: <Widget>[
        Text("Sektör",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Container(
          child: SearchableDropdown.single(
            value: _secilensektor,
            items: _sektorItems,
            onChanged: changedsektorItem,
            closeButton: "Kapat",
          ),
          width: MediaQuery.of(context).size.width - 130.0,
        ),
      ],
    );
  }

  Widget ticaretturufield() {
    return Row(
      children: <Widget>[
        Text("Ticaret Türü",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Text('İthalat',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(
            value: 1,
            groupValue: _ticaretturuValue,
            onChanged: _ticaretturuValueChange),
        Text('İhracat',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(
            value: 2,
            groupValue: _ticaretturuValue,
            onChanged: _ticaretturuValueChange)
      ],
    );
  }

  Widget sozlesmeonayfield() {
    return Row(
      children: <Widget>[
        Text('Sözleşmeyi Okudum',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        Radio(
            value: 1,
            groupValue: _sozlesmeValue,
            onChanged: _sozlesmeValueChange),
      ],
    );
  }

  Widget sirketturufield() {
    return Row(
      children: <Widget>[
        Text("Şirket Tipi",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Text('Üretici',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(
            value: 1,
            groupValue: _sirketturuValue,
            onChanged: _sirketturuValueChange),
        Text('Toptan Satış',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(
            value: 2,
            groupValue: _sirketturuValue,
            onChanged: _sirketturuValueChange),
      ],
    );
  }

  Widget sirketturufield2() {
    return Row(
      children: <Widget>[
        Text("                     ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Text('Şube',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Radio(
            value: 3,
            groupValue: _sirketturuValue,
            onChanged: _sirketturuValueChange),
        Text('Merkez Ofis',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        Text(" ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        Radio(
            value: 4,
            groupValue: _sirketturuValue,
            onChanged: _sirketturuValueChange)
      ],
    );
  }

  void _ticaretturuValueChange(int value) {
    setState(() {
      _ticaretturuValue = value;
    });
  }

  void _sozlesmeValueChange(int value) {
    setState(() {
      _sozlesmeValue = value;
    });
  }

  void _sirketturuValueChange(int value) {
    setState(() {
      _sirketturuValue = value;
    });
  }

  void changedsektorItem(String selectedsektor) {
    setState(() {
      _secilensektor = selectedsektor;
      int id = 0;
      id = sektorlist.indexWhere((value) => value.sektor == _secilensektor);
      double idd = 0.0;
      idd = double.parse(sektorlist[id].id.toString());
      this.sektorid = idd.toInt();
    });
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        image(),
        bosluk(),
        firmaadfield(),
        bosluk(),
        adresfield(),
        bosluk(),
        vdfield(),
        bosluk(),
        vnofield(),
        bosluk(),
        kuladifield(),
        bosluk(),
        emailfield(),
        bosluk(),
        sifrefield(),
        bosluk(),
        sektorfield(),
        bosluk(),
        ticaretturufield(),
        bosluk(),
        sirketturufield(),
        bosluk(),
        sirketturufield2(),
        bosluk(),
        sozlesmeonayfield(),
        bosluk(),
        kayitbutton(),
      ],
    );
  }

  mesaj(BuildContext context, String deger) {
    var alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text(deger),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
