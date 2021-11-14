import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';
import 'package:kommrade_firma/apis/ulkeler_api.dart';
import 'package:kommrade_firma/models/ulkeler.dart';
import 'package:kommrade_firma/apis/sehirler_api.dart';
import 'package:kommrade_firma/models/sehirler.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:kommrade_firma/apis/iletisim_bilgi_guncelle.dart';

class IletisimBilgiScreen extends StatefulWidget {
  static const String routename = "/iletisimbilgi";
  @override
  State<StatefulWidget> createState() => IletisimBilgiScreenState();
}

class IletisimBilgiScreenState extends State {
  List<FirmaBilgilerModel> firmalist = [];

  List<DropdownMenuItem<String>> _ulkeItems;
  String _secilenulke;
  List<Ulkelermodel> ulkelist = [];
  int ulkeid = 0;
  List _ulkeler = [""];
  List _ulkeid = [""];

  List<DropdownMenuItem<String>> _sehirItems;
  String _secilensehir;
  List<Sehirlermodel> sehirlist =[];
  int sehirid = 0;
  List _sehirler = [""];
  List _sehirid = [""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("İletişim Bilgileri"),
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
    getukeler();
    getsehirler();
    getlist();
  }

  getlist() {
    FirmaBilgilerapi.getfirma().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.firmalist =
            list.map((firma) => FirmaBilgilerModel.fromJson(firma)).toList();

        this.txttelefon.text = this.firmalist[0].tel.toString();
        this.txtgsm.text = this.firmalist[0].ceptel.toString();
        this.txtadres.text = this.firmalist[0].adres.toString();
        this.txtweb.text = this.firmalist[0].web.toString();
        this.txtfax.text = this.firmalist[0].faks.toString();
        if (this.firmalist[0].ulkeadi != null && this.ulkelist.length > 0)
          this._secilenulke = this.firmalist[0].ulkeadi.toString();
        if (this.firmalist[0].iladi != null && this.sehirlist.length > 0)
          this._secilensehir = this.firmalist[0].iladi.toString();
      });
    });
  }

  TextEditingController txttelefon = new TextEditingController();
  TextEditingController txtgsm = new TextEditingController();
  TextEditingController txtadres = new TextEditingController();
  TextEditingController txtweb = new TextEditingController();
  TextEditingController txtfax = new TextEditingController();

  getukeler() {
    Ulkelerapi.getulkeler().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.ulkelist =
            list.map((ulke) => Ulkelermodel.fromJson(ulke)).toList();
      });
      if (this.ulkelist.length > 0) {
        this._ulkeler.clear();
        this._ulkeid.clear();
        this._ulkeler.add("Seçilmemiş");
        for (var i = 0; i <= this.ulkelist.length - 1; i += 1) {
          this._ulkeler.add(ulkelist[i].ad.toString());
          this._ulkeid.add(ulkelist[i].id.toString());
        }
        _ulkeItems = getulkeItems();
        _secilenulke = ulkelist[0].ad.toString();
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getulkeItems() {
    List<DropdownMenuItem<String>> ulkeitems = [];
    for (String ulke in _ulkeler) {
      ulkeitems.add(new DropdownMenuItem(
          value: ulke,
          child: new Text(ulke,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return ulkeitems;
  }

  getsehirler() {
    Sehirlerapi.getsehirler(this.ulkeid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.sehirlist =
            list.map((sehir) => Sehirlermodel.fromJson(sehir)).toList();
      });
      if (this.sehirlist.length > 0) {
        this._sehirler.clear();
        this._sehirid.clear();
        this._sehirler.add("Seçilmemiş");
        for (var i = 0; i <= this.sehirlist.length - 1; i += 1) {
          this._sehirler.add(sehirlist[i].ad.toString());
          this._sehirid.add(sehirlist[i].id.toString());
        }
        _sehirItems = getsehirItems();
        _secilensehir = sehirlist[0].ad.toString();
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getsehirItems() {
    List<DropdownMenuItem<String>> sehiritems = [];
    for (String sehir in _sehirler) {
      sehiritems.add(new DropdownMenuItem(
          value: sehir,
          child: new Text(sehir,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return sehiritems;
  }

  Widget ulkefield() {
    return Row(
      children: <Widget>[
        Text("Ülke",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Container(
          child: SearchableDropdown.single(
            value: _secilenulke,
            items: _ulkeItems,
            onChanged: (value) {
              setState(() {
                _secilenulke = value;
                int id = 0;
                id = ulkelist.indexWhere((value) => value.ad == _secilenulke);
                double idd = 0;
                idd = double.parse(ulkelist[id].id.toString());
                this.ulkeid = idd.toInt();
              });
            },
          ),
          width: MediaQuery.of(context).size.width - 130.0,
        ),
      ],
    );
  }

  void changedulkeItem(String selectedulke) {
    setState(() {
      _secilenulke = selectedulke;
      int id = 0;
      id = ulkelist.indexWhere((value) => value.ad == _secilenulke);
      double idd = 0;
      idd = double.parse(ulkelist[id].id.toString());
      this.ulkeid = idd.toInt();
    });
  }

  Widget sehirfield() {
    return Row(
      children: <Widget>[
        Text("Şehir",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Container(
          child: SearchableDropdown.single(
            value: _secilensehir,
            items: _sehirItems,
            onChanged: (value) {
              setState(() {
                _secilensehir = value;
                int id = 0;
                id = sehirlist.indexWhere((value) => value.ad == _secilensehir);
                double idd = 0;
                idd = double.parse(sehirlist[id].id.toString());
                this.sehirid = idd.toInt();
              });
            },
          ),
          width: MediaQuery.of(context).size.width - 130.0,
        ),
      ],
    );
  }

  void changedsehirItem(String selectedsehir) {
    setState(() {
      _secilensehir = selectedsehir;
      int id = 0;
      id = sehirlist.indexWhere((value) => value.ad == _secilensehir);
      double idd = 0;
      idd = double.parse(sehirlist[id].id.toString());
      this.sehirid = idd.toInt();
    });
  }

  Widget telfield() {
    return TextFormField(
      controller: txttelefon,
      keyboardType: TextInputType.text,
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

  Widget gsmfield() {
    return TextFormField(
      controller: txtgsm,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "GSM",
        hintText: "GSM",
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

  Widget webfield() {
    return TextFormField(
      controller: txtweb,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Web",
        hintText: "Web",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget faxfield() {
    return TextFormField(
      controller: txtfax,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Faks",
        hintText: "Faks",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  guncelle() {
    IletisimBilgiGuncelleApi.updateiletisimbilgi(
            Degiskenler.firmaid,
            ulkeid,
            sehirid,
            txttelefon.text,
            txtgsm.text,
            txtadres.text,
            txtweb.text,
            txtfax.text)
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
        ulkefield(),
        bosluk(),
        sehirfield(),
        bosluk(),
        telfield(),
        bosluk(),
        gsmfield(),
        bosluk(),
        adresfield(),
        bosluk(),
        webfield(),
        bosluk(),
        faxfield(),
        bosluk(),
        kayitbutton(),
      ],
    );
  }
}
