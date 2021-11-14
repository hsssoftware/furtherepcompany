import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/talep_ekle_api.dart';
import 'package:kommrade_firma/apis/pozisyon_api.dart';
import 'package:kommrade_firma/models/pozisyonlar.dart';
import 'package:kommrade_firma/models/talep_ekle.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:kommrade_firma/apis/ulkeler_api.dart';
import 'package:kommrade_firma/models/ulkeler.dart';
import 'package:kommrade_firma/apis/sehir_api.dart';
import 'package:kommrade_firma/models/sehirler.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class TalepEkleScreen extends StatefulWidget {
  static const String routename = "/talepekle";
  @override
  State<StatefulWidget> createState() => TalepEkleScreenState();
}

class TalepEkleScreenState extends State {
  List<TalepEkleModel> kayitlist = [];

  List<DropdownMenuItem<String>> _pozisyonItems;
  String _secilenpozisyon;
  List<Pozisyonlarmodel> pozisyonlist = [];
  int pozisyonid = 0;
  List _pozisyonlar = [""];
  List _pozisyonid = [""];
  int _ticaretturuValue = 0;

  List<DropdownMenuItem<String>> _ulkeItems;
  String _secilenulke;
  List<Ulkelermodel> ulkelist = [];
  int ulkeid = 1;
  List _ulkeler = [""];
  List _ulkeid = [""];

  List<DropdownMenuItem<String>> _sehirItems;
  String _secilensehir;
  List<Sehirlermodel> sehirlist = [];
  int sehirid = 0;
  List _sehirler = [""];
  List _sehirid = [""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Talep Ekle"),
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
                      userimage(),
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
    getpozisyon();
    getukeler();
    getsehirler();
  }

  getpozisyon() {
    Pozisyonapi.getpozisyon().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.pozisyonlist = list
            .map((pozisyon) => Pozisyonlarmodel.fromJson(pozisyon))
            .toList();
      });
      if (this.pozisyonlist.length > 0) {
        this._pozisyonlar.clear();
        this._pozisyonid.clear();
        this._pozisyonlar.add("Seçilmemiş");
        for (var i = 0; i <= this.pozisyonlist.length - 1; i += 1) {
          this._pozisyonlar.add(pozisyonlist[i].ad.toString());
          this._pozisyonid.add(pozisyonlist[i].id.toString());
        }
        _pozisyonItems = getpozisyonItems();
        _secilenpozisyon = _pozisyonItems[0].value;
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getpozisyonItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String pozisyon in _pozisyonlar) {
      items.add(new DropdownMenuItem(
          value: pozisyon,
          child: new Text(pozisyon,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))));
    }
    return items;
  }

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
        _secilenulke = _ulkeItems[0].value;
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getulkeItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String ulke in _ulkeler) {
      items.add(new DropdownMenuItem(
          value: ulke,
          child: new Text(ulke,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))));
    }
    return items;
  }

  getsehirler() {
    Sehirapi.getsehirler(this.ulkeid).then((response) {
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
        _secilensehir = _sehirItems[0].value;
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getsehirItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String sehir in _sehirler) {
      items.add(new DropdownMenuItem(
          value: sehir,
          child: new Text(sehir,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))));
    }
    return items;
  }

  Widget pozisyonfield() {
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Container(
            child: SearchableDropdown.single(
              value: _secilenpozisyon,
              items: _pozisyonItems,
              onChanged: changedpozisyonItem,
              label: "Pozisyon",
              closeButton: "Kapat",
              isExpanded: true,
            ),
            width: MediaQuery.of(context).size.width - 50.0,
          ),
        ],
      ),
    );
  }

  void changedpozisyonItem(String selectedpozisyon) {
    setState(() {
      _secilenpozisyon = selectedpozisyon;
      int id = 0;
      id = pozisyonlist.indexWhere((value) => value.ad == _secilenpozisyon);
      double idd = 0;
      idd = double.parse(pozisyonlist[id].id.toString());
      this.pozisyonid = idd.toInt();
    });
  }

  Widget ulkefield() {
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Container(
            child: SearchableDropdown.single(
              value: _secilenulke,
              items: _ulkeItems,
              onChanged: changedulkeItem,
              label: "Ülke",
              closeButton: "Kapat",
              isExpanded: true,
            ),
            width: MediaQuery.of(context).size.width - 50.0,
          ),
        ],
      ),
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
      setState(() {
        getsehirler();
      });
    });
  }

  Widget sehirfield() {
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Container(
            child: SearchableDropdown.single(
              value: _secilensehir,
              items: _sehirItems,
              onChanged: changedsehirItem,
              label: "Şehir",
              closeButton: "Kapat",
              isExpanded: true,
            ),
            width: MediaQuery.of(context).size.width - 50.0,
          ),
        ],
      ),
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

  Widget ticaretturufield() {
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey)),
      child: Row(
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
      ),
    );
  }

  void _ticaretturuValueChange(int value) {
    setState(() {
      _ticaretturuValue = value;
    });
  }

  TextEditingController txtpozisyon = new TextEditingController();
  TextEditingController txtaciklama = new TextEditingController();
  TextEditingController txtbastar = new TextEditingController();
  TextEditingController txtbittar = new TextEditingController();
  TextEditingController txtilantip = new TextEditingController();
  TextEditingController txtulke = new TextEditingController();
  TextEditingController txtil = new TextEditingController();
  TextEditingController txtticaretturu = new TextEditingController();
  TextEditingController txttecrube = new TextEditingController();
  TextEditingController txtbastar2 = new TextEditingController();
  TextEditingController txtbittar2 = new TextEditingController();

  Widget aciklamafield() {
    return TextFormField(
      controller: txtaciklama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Açıklama",
        hintText: "Açıklama",
        contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget tecrubefield() {
    return TextFormField(
      controller: txttecrube,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Tecrübe",
        hintText: "Tecrübe",
        contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget bastarfield() {
    return TextFormField(
      controller: txtbastar,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "Başlangıç Tarihi",
        hintText: "Başlangıç tarihi seçiniz...",
        contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
      onTap: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              containerHeight: 210.0,
            ),
            showTitleActions: true,
            minTime: DateTime(2000, 01, 1),
            maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
          setState(() {
            if ((date.month < 10) && (date.day < 10)) {
              this.txtbastar.text = '0${date.day}-0${date.month}-${date.year}';
            } else if ((date.month > 10) && (date.day < 10)) {
              this.txtbastar.text = '0${date.day}-${date.month}-${date.year}';
            } else if ((date.month < 10) && (date.day > 10)) {
              this.txtbastar.text = '${date.day}-0${date.month}-${date.year}';
            } else if ((date.month > 10) && (date.day > 10)) {
              this.txtbastar.text = '${date.day}-${date.month}-${date.year}';
            } else if ((date.month == 10) && (date.day < 10)) {
              this.txtbastar.text = '0${date.day}-${date.month}-${date.year}';
            } else if ((date.month < 10) && (date.day == 10)) {
              this.txtbastar.text = '${date.day}-0${date.month}-${date.year}';
            } else if ((date.month == 10) && (date.day == 10)) {
              this.txtbastar.text = '${date.day}-${date.month}-${date.year}';
            } else
              this.txtbastar.text = '${date.day}-${date.month}-${date.year}';

            if ((date.month < 10) && (date.day < 10)) {
              this.txtbastar2.text = '${date.year}-0${date.month}-0${date.day}';
            } else if ((date.month > 10) && (date.day < 10)) {
              this.txtbastar2.text = '${date.year}-${date.month}-0${date.day}';
            } else if ((date.month < 10) && (date.day > 10)) {
              this.txtbastar2.text = '${date.year}-0${date.month}-${date.day}';
            } else if ((date.month > 10) && (date.day > 10)) {
              this.txtbastar2.text = '${date.year}-${date.month}-${date.day}';
            } else if ((date.month == 10) && (date.day < 10)) {
              this.txtbastar2.text = '${date.year}-${date.month}-0${date.day}';
            } else if ((date.month < 10) && (date.day == 10)) {
              this.txtbastar2.text = '${date.year}-0${date.month}-${date.day}';
            } else if ((date.month == 10) && (date.day == 10)) {
              this.txtbastar2.text = '${date.year}-${date.month}-${date.day}';
            } else
              this.txtbastar2.text = '${date.year}-${date.month}-${date.day}';

            txtbastar2.text = txtbastar2.text + " 00:00";
          });
        }, currentTime: DateTime.now(), locale: LocaleType.tr);
      },
    );
  }

  Widget bittarfield() {
    return TextFormField(
      controller: txtbittar,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "Bitiş Tarihi",
        hintText: "Bitiş tarihi seçiniz...",
        contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
      onTap: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              containerHeight: 210.0,
            ),
            showTitleActions: true,
            minTime: DateTime(2000, 01, 1),
            maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
          setState(() {
            if ((date.month < 10) && (date.day < 10)) {
              this.txtbittar.text = '0${date.day}-0${date.month}-${date.year}';
            } else if ((date.month > 10) && (date.day < 10)) {
              this.txtbittar.text = '0${date.day}-${date.month}-${date.year}';
            } else if ((date.month < 10) && (date.day > 10)) {
              this.txtbittar.text = '${date.day}-0${date.month}-${date.year}';
            } else if ((date.month > 10) && (date.day > 10)) {
              this.txtbittar.text = '${date.day}-${date.month}-${date.year}';
            } else if ((date.month == 10) && (date.day < 10)) {
              this.txtbittar.text = '0${date.day}-${date.month}-${date.year}';
            } else if ((date.month < 10) && (date.day == 10)) {
              this.txtbittar.text = '${date.day}-0${date.month}-${date.year}';
            } else if ((date.month == 10) && (date.day == 10)) {
              this.txtbittar.text = '${date.day}-${date.month}-${date.year}';
            } else
              this.txtbittar.text = '${date.day}-${date.month}-${date.year}';

            if ((date.month < 10) && (date.day < 10)) {
              this.txtbittar2.text = '${date.year}-0${date.month}-0${date.day}';
            } else if ((date.month > 10) && (date.day < 10)) {
              this.txtbittar2.text = '${date.year}-${date.month}-0${date.day}';
            } else if ((date.month < 10) && (date.day > 10)) {
              this.txtbittar2.text = '${date.year}-0${date.month}-${date.day}';
            } else if ((date.month > 10) && (date.day > 10)) {
              this.txtbittar2.text = '${date.year}-${date.month}-${date.day}';
            } else if ((date.month == 10) && (date.day < 10)) {
              this.txtbittar2.text = '${date.year}-${date.month}-0${date.day}';
            } else if ((date.month < 10) && (date.day == 10)) {
              this.txtbittar2.text = '${date.year}-0${date.month}-${date.day}';
            } else if ((date.month == 10) && (date.day == 10)) {
              this.txtbittar2.text = '${date.year}-${date.month}-${date.day}';
            } else
              this.txtbittar2.text = '${date.year}-${date.month}-${date.day}';

            txtbittar2.text = txtbittar2.text + " 00:00";
          });
        }, currentTime: DateTime.now(), locale: LocaleType.tr);
      },
    );
  }

  Widget kayitbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("KAYDET"),
        onPressed: () {
          if (txtaciklama.text == "") {
            mesaj(context, "Açıklama girilmemiş..");
            return;
          }
          kayitekle();
          mesaj(context, "Kayıt başarılı...");
          setState(() {
            txttecrube.text = "";
            txtaciklama.text = "";
            txtbastar.text = "";
            txtbastar2.text = "";
            txtbittar.text = "";
            txtbittar2.text = "";
            _secilenpozisyon = "";
            _secilensehir = "";
            _secilenulke = "";
            ulkeid = 0;
            sehirid = 0;
            pozisyonid = 0;
            _ticaretturuValue = 0;
            txtticaretturu.text = "";
            super.initState();
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  Widget taslakbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("TASLAK"),
        onPressed: () {
          if (txtaciklama.text == "") {
            mesaj(context, "Açıklama girilmemiş..");
            return;
          }
          kayitekletaslak();
          mesaj(context, "Kayıt başarılı...");
          setState(() {
            txttecrube.text = "";
            txtaciklama.text = "";
            txtbastar.text = "";
            txtbastar2.text = "";
            txtbittar.text = "";
            txtbittar2.text = "";
            _secilenpozisyon = "";
            _secilensehir = "";
            _secilenulke = "";
            ulkeid = 0;
            sehirid = 0;
            pozisyonid = 0;
            _ticaretturuValue = 0;
            txtticaretturu.text = "";
            super.initState();
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(186, 74, 0, 1))),
      ),
    );
  }

  kayitekle() {
    TalepEkleApi.posttalep(
            Degiskenler.firmaid.toInt(),
            pozisyonid,
            txtaciklama.text,
            DateTime.parse(txtbastar2.text),
            DateTime.parse(txtbittar2.text),
            1,
            ulkeid,
            sehirid,
            _ticaretturuValue,
            int.parse(txttecrube.text))
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.kayitlist =
            list.map((kayit) => TalepEkleModel.fromJson(kayit)).toList();
        if (this.kayitlist[0].status.toString() == "success") {
          mesaj(context, "Kayıt başarılı...");
        } else {}
      });
    });
  }

  kayitekletaslak() {
    TalepEkleApi.posttalep(
            Degiskenler.firmaid.toInt(),
            pozisyonid,
            txtaciklama.text,
            DateTime.parse(txtbastar2.text),
            DateTime.parse(txtbittar2.text),
            2,
            ulkeid,
            sehirid,
            _ticaretturuValue,
            int.parse(txttecrube.text))
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.kayitlist =
            list.map((kayit) => TalepEkleModel.fromJson(kayit)).toList();
        if (this.kayitlist[0].status.toString() == "success") {
          mesaj(context, "Kayıt başarılı...");
        } else {
          mesaj(context, this.kayitlist[0].message.toString());
        }
      });
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
        pozisyonfield(),
        bosluk(),
        ulkefield(),
        bosluk(),
        sehirfield(),
        bosluk(),
        aciklamafield(),
        bosluk(),
        bastarfield(),
        bosluk(),
        bittarfield(),
        bosluk(),
        ticaretturufield(),
        bosluk(),
        tecrubefield(),
        bosluk(),
        kayitbutton(),
        bosluk(),
        taslakbutton(),
        bosluk(),
        bosluk(),
        bosluk(),
      ],
    );
  }
}
