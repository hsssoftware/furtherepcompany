import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';
import 'package:kommrade_firma/apis/sektor_api.dart';
import 'package:kommrade_firma/models/sektorler.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:kommrade_firma/apis/firma_bilgi_guncelle.dart';

class FirmaBilgiScreen extends StatefulWidget {
  static const String routename = "/firmabilgi";
  @override
  State<StatefulWidget> createState() => FirmaBilgiScreenState();
}

class FirmaBilgiScreenState extends State {
  List<FirmaBilgilerModel> firmalist = [];
  List<DropdownMenuItem<String>> _sektorItems;
  String _secilensektor;
  List<Sektormodel> sektorlist = [];
  int sektorid = 0;
  List _sektorlar = [""];
  List _sektorid = [""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firma Bilgileri"),
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
    getsektor();
  }

  getlist() {
    FirmaBilgilerapi.getfirma().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.firmalist =
            list.map((firma) => FirmaBilgilerModel.fromJson(firma)).toList();

        this.txtfirmaadi.text = this.firmalist[0].firmaadi.toString();
        this.txtvno.text = this.firmalist[0].vergino.toString();
        this.txtvdairesi.text = this.firmalist[0].vergidairesi.toString();
        this.txtnace.text = this.firmalist[0].nacekodu.toString();
        this.txtadres.text = this.firmalist[0].adres.toString();
        this.txtpostakodu.text = this.firmalist[0].postakodu.toString();
        this.txtyil.text = this.firmalist[0].kurulusyil.toString();
        this.txtcalisansayisi.text = this.firmalist[0].calisansayisi.toString();
        if (this.firmalist[0].sektoradi != null) {
          this.txtsektor.text = this.firmalist[0].sektoradi.toString();
          this._secilensektor = this.firmalist[0].sektoradi.toString();
        }
      });
    });
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
        for (var i = 0; i <= this.sektorlist.length - 1; i += 1) {
          this._sektorlar.add(sektorlist[i].sektor.toString());
          this._sektorid.add(sektorlist[i].id.toString());
        }
        _sektorItems = getsektorItems();
        _secilensektor = _sektorItems[0].value;
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
            onChanged: (value) {
              setState(() {
                _secilensektor = value;
                int id = 0;
                id = sektorlist
                    .indexWhere((value) => value.sektor == _secilensektor);
                double idd = 0;
                idd = double.parse(sektorlist[id].id.toString());
                this.sektorid = idd.toInt();
              });
            },
          ),
          width: MediaQuery.of(context).size.width - 130.0,
        ),
      ],
    );
  }

  void changedsektorItem(String selectedsektor) {
    setState(() {
      _secilensektor = selectedsektor;
      int id = 0;
      id = sektorlist.indexWhere((value) => value.sektor == _secilensektor);
      this.sektorid = int.parse(sektorlist[id].id.toString());
    });
  }

  TextEditingController txtfirmaadi = new TextEditingController();
  TextEditingController txtvno = new TextEditingController();
  TextEditingController txtvdairesi = new TextEditingController();
  TextEditingController txtnace = new TextEditingController();
  TextEditingController txtadres = new TextEditingController();
  TextEditingController txtpostakodu = new TextEditingController();
  TextEditingController txtyil = new TextEditingController();
  TextEditingController txtcalisansayisi = new TextEditingController();
  TextEditingController txtsektor = new TextEditingController();

  Widget firmaadfield() {
    return TextFormField(
      controller: txtfirmaadi,
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

  Widget vnofield() {
    return TextFormField(
      controller: txtvno,
      keyboardType: TextInputType.text,
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

  Widget vdairesifield() {
    return TextFormField(
      controller: txtvdairesi,
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

  Widget nacefield() {
    return TextFormField(
      controller: txtnace,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nace Kodu",
        hintText: "Nace Kodu",
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

  Widget postafield() {
    return TextFormField(
      controller: txtpostakodu,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Posta Kodu",
        hintText: "Posta Kodu",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget yilfield() {
    return TextFormField(
      controller: txtyil,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kuruluş Yılı",
        hintText: "Kuruluş Yılı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget calisanfield() {
    return TextFormField(
      controller: txtcalisansayisi,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Çalışan Sayısı",
        hintText: "Çalışan Sayısı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
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

  guncelle() {
    FirmaBilgiGuncelleApi.updatefirmabilgi(
            Degiskenler.firmaid,
            txtfirmaadi.text,
            txtvno.text,
            txtvdairesi.text,
            txtnace.text,
            txtadres.text,
            txtpostakodu.text,
            int.parse(txtyil.text),
            int.parse(txtcalisansayisi.text),
            sektorid)
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

  Widget listegetir() {
    return Column(
      children: <Widget>[
        bosluk(),
        firmaadfield(),
        bosluk(),
        vnofield(),
        bosluk(),
        vdairesifield(),
        bosluk(),
        nacefield(),
        bosluk(),
        adresfield(),
        bosluk(),
        postafield(),
        bosluk(),
        yilfield(),
        bosluk(),
        calisanfield(),
        bosluk(),
        sektorfield(),
        bosluk(),
        kayitbutton(),
      ],
    );
  }
}
