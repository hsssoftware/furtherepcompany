import 'package:flutter/material.dart';
import 'package:kommrade_firma/apis/anasayfa_api.dart';
import 'package:kommrade_firma/models/anasayfa.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/gruplar_api.dart';
import 'package:kommrade_firma/models/gruplar.dart';
import 'package:kommrade_firma/apis/grup_temsilci_ekle_api.dart';
import 'package:kommrade_firma/models/grup_temsilci_ekle.dart';
import 'package:kommrade_firma/screens/temsilci_detay_screen.dart';
import 'package:kommrade_firma/apis/pozisyon_api.dart';
import 'package:kommrade_firma/models/pozisyonlar.dart';
import 'package:kommrade_firma/apis/ulkeler_api.dart';
import 'package:kommrade_firma/models/ulkeler.dart';
import 'package:kommrade_firma/apis/sehirler_api.dart';
import 'package:kommrade_firma/models/sehirler.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:kommrade_firma/apis/isdurum_api.dart';
import 'package:kommrade_firma/models/isdurumlari.dart';
import 'package:kommrade_firma/apis/detayli_arama_api.dart';

class AnasayfaScreen extends StatefulWidget {
  static const String routename = "/anasayfa";
  @override
  State<StatefulWidget> createState() => AnasayfaScreenState();
}

class AnasayfaScreenState extends State {
  List<Anasayfamodel> anasayfalist = [];
  int sayfa = 0;
  int index = 0;
  List<GruplarModel> gruplist = [];
  List<GrupTemsilciEkle> kayitlist = [];

  List<DropdownMenuItem<String>> _pozisyonItems;
  String _secilenpozisyon;
  List<Pozisyonlarmodel> pozisyonlist = [];
  int pozisyonid = 0;
  List _pozisyonlar = [""];
  List _pozisyonid = [""];
  List<int> selectedpozisyon = [];
  int _ticaretturuValue = 0;

  List<DropdownMenuItem<String>> _ulkeItems;
  String _secilenulke;
  List<Ulkelermodel> ulkelist = [];
  int ulkeid = 0;
  List _ulkeler = [""];
  List _ulkeid = [""];
  List<int> selectedulke = [];

  List<DropdownMenuItem<String>> _sehirItems;
  String _secilensehir;
  List<Sehirlermodel> sehirlist = [];
  int sehirid = 0;
  List _sehirler = [""];
  List _sehirid = [""];
  List<int> selectedsehir = [];

  List<DropdownMenuItem<String>> _isdurumItems;
  String _secilenisdurum;
  List<IsDurumlariModel> isdurumlist = [];
  int isdurumid = 0;
  List _isdurumlar = [""];
  List _isdurumid = [""];
  List<int> selectedisdurum = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Anasayfa"),
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
          child: listegetir(),
        ));
  }

  @override
  void initState() {
    super.initState();
    if (Degiskenler.detayliara == 0) {
      getlist();
    } else {
      getdetayliarama();
    }
    getgruplist();
    getpozisyon();
    getsehirler();
    getukeler();
    getisdurum();
  }

  getlist() {
    Anasayfaapi.getanasayfa(sayfa).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.anasayfalist =
            list.map((anasayfa) => Anasayfamodel.fromJson(anasayfa)).toList();
      });
    });
  }

  getdetayliarama() {
    int yass1 = 0;
    int yass2 = 0;
    if (txtyas1.text != "") yass1 = int.parse(txtyas1.text);
    if (txtyas2.text != "") yass2 = int.parse(txtyas2.text);
    String pozisyondegerler = "";
    if (selectedpozisyon.length > 0) {
      pozisyondegerler = selectedpozisyon
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
    }
    String ulkedegerler = "";
    if (selectedulke.length > 0) {
      ulkedegerler = selectedulke
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
    }
    String sehirdegerler = "";
    if (selectedsehir.length > 0) {
      sehirdegerler = selectedsehir
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
    }
    String isdurumdegerler = "";
    if (selectedisdurum.length > 0) {
      isdurumdegerler = selectedisdurum
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "");
    }
    DetayliAramaApi.getarama(
            0,
            0,
            0,
            yass1,
            yass2,
            0,
            _ticaretturuValue,
            pozisyondegerler,
            ulkedegerler,
            sehirdegerler,
            isdurumdegerler,
            txtarama.text)
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.anasayfalist =
            list.map((arama) => Anasayfamodel.fromJson(arama)).toList();
      });
    });
  }

  getgruplist() {
    GruplarApi.getgrup().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.gruplist =
            list.map((grup) => GruplarModel.fromJson(grup)).toList();
      });
    });
  }

  postgruptemsilci() {
    GrupTemsilciEkleApi.posttemsilcigrup(
      Degiskenler.favorigrupid,
      Degiskenler.favoritemsilciid,
    ).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.kayitlist =
            list.map((kayit) => GrupTemsilciEkle.fromJson(kayit)).toList();
      });
      if (this.kayitlist[0].status.toString() == "success") {
      } else {}
    });
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

  Widget usershape() {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        color: Colors.white,
      ),
    );
  }

  TextEditingController txtarama = new TextEditingController();

  Widget aramafield() {
    return TextFormField(
      controller: txtarama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Ülke, şehir ve pozisyon",
        hintText: "Ülke, şehir ve pozisyon",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget aramabutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(10, 39, 97, 1))),
      onPressed: () {
        getdetayliarama();
      },
      child: Row(
        children: <Widget>[
          Text(
            ' ',
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget filterbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(10, 39, 97, 1))),
      onPressed: () {
        detayliaramaDialog();
      },
      child: Row(
        children: <Widget>[
          Text(
            ' ',
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.format_list_numbered,
            color: Colors.white,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget ustarama() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width / 2.0) - 10.0,
          child: aramafield(),
        ),
        SizedBox(
          width: 20.0,
        ),
        Container(
          width: (MediaQuery.of(context).size.width / 2.0) - 10.0,
          child: filterbutton(),
        )
      ],
    );
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8.0,
          width: 8.0,
        ),
        Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width / 2.0) + 50.0,
              child: aramafield(),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              width: 70.0,
              child: aramabutton(),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              width: 70.0,
              child: filterbutton(),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
          width: 8.0,
        ),
        dataBody(),
      ],
    );
  }

  Widget appimage() {
    return Image.asset(
      "assets/images/applogo.png",
      width: 80.0,
      height: 80.0,
    );
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 25, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  void addDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Favorilere Ekle"),
          content: grupdataBody(),
          actions: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Kapat"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )

            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

////////detayli arama//////////////////////////////////////////7
  Widget detayliarama() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sifirlabutton(),
            bosluk(),
            filtrebutton(),
          ],
        ),
        bosluk(),
        pozisyonfield(),
        bosluk(),
        ulkefield(),
        bosluk(),
        sehirfield(),
        bosluk(),
        isdurumfield(),
        bosluk(),
        ticaretturufield(),
        bosluk(),
        yasfield(),
      ],
    );
  }

  Widget filtrebutton() {
    return Container(
      width: 100.0,
      child: ElevatedButton(
        child: Text("Filtrele"),
        onPressed: () {
          Degiskenler.detayliara = 1;
          setState(() {
            if (Degiskenler.detayliara == 0) {
              getlist();
              Navigator.of(context, rootNavigator: true).pop('dialog');
            } else {
              getdetayliarama();
              Navigator.of(context, rootNavigator: true).pop('dialog');
            }
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  Widget sifirlabutton() {
    return Container(
      width: 100.0,
      child: ElevatedButton(
        child: Text("Sıfırla"),
        onPressed: () {
          setState(() {
            Degiskenler.detayliara = 0;
            selectedpozisyon.clear();
            selectedulke.clear();
            selectedsehir.clear();
            selectedisdurum.clear();
            txtyas1.text = "";
            txtyas2.text = "";
            _ticaretturuValue = 0;
          });
          if (Degiskenler.detayliara == 0) {
            getlist();
          } else {
            getdetayliarama();
          }
          Navigator.of(context, rootNavigator: true).pop('dialog');
          detayliaramaDialog();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(186, 74, 0, 1))),
      ),
    );
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
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
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
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return items;
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
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return items;
  }

  getisdurum() {
    IsDurumApi.getisdurum().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.isdurumlist =
            list.map((isdurum) => IsDurumlariModel.fromJson(isdurum)).toList();
      });
      if (this.isdurumlist.length > 0) {
        this._isdurumlar.clear();
        this._isdurumid.clear();
        this._isdurumlar.add("Seçilmemiş");
        for (var i = 0; i <= this.isdurumlist.length - 1; i += 1) {
          this._isdurumlar.add(isdurumlist[i].ad.toString());
          this._isdurumid.add(isdurumlist[i].id.toString());
        }
        _isdurumItems = getisdurumItems();
        _secilenisdurum = _isdurumItems[0].value;
        super.initState();
      }
    });
  }

  List<DropdownMenuItem<String>> getisdurumItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String isdurum in _isdurumlar) {
      items.add(new DropdownMenuItem(
          value: isdurum,
          child: new Text(isdurum,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal))));
    }
    return items;
  }

  Widget pozisyonfield() {
    return Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.grey)),
          child: SearchableDropdown.multiple(
            items: _pozisyonItems,
            selectedItems: selectedpozisyon,
            hint: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Pozisyon"),
            ),
            searchHint: "Pozisyon",
            onChanged: (value) {
              setState(() {
                selectedpozisyon = value;
              });
            },
            displayItem: (item, selected) {
              return (Row(children: [
                selected
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                SizedBox(width: 7),
                Expanded(
                  child: item,
                ),
              ]));
            },
            selectedValueWidgetFn: (item) {
              return (Center(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.brown,
                          width: 0.5,
                        ),
                      ),
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item.toString()),
                      ))));
            },
            doneButton: (selectedItemsDone, doneContext) {
              return (ElevatedButton(
                  onPressed: () {
                    Navigator.pop(doneContext);
                    setState(() {});
                  },
                  child: Text("Kaydet")));
            },
            closeButton: "Kapat",
            style: TextStyle(fontStyle: FontStyle.italic),
            searchFn: (String keyword, items) {
              List<int> ret = [];
              if (keyword != null && items != null && keyword.isNotEmpty) {
                keyword.split(" ").forEach((k) {
                  int i = 0;
                  items.forEach((item) {
                    if (k.isNotEmpty &&
                        (item.value
                            .toString()
                            .toLowerCase()
                            .contains(k.toLowerCase()))) {
                      ret.add(i);
                    }
                    i++;
                  });
                });
              }
              if (keyword.isEmpty) {
                ret = Iterable<int>.generate(items.length).toList();
              }
              return (ret);
            },
            clearIcon: Icon(Icons.clear_all),
            icon: Icon(Icons.arrow_drop_down_circle),
            label: "Seçilenler",
            underline: Container(
              height: 1.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.teal, width: 3.0))),
            ),
            iconDisabledColor: Colors.brown,
            iconEnabledColor: Colors.indigo,
            isExpanded: true,
          ),
          width: 250.0,
        ),
      ],
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
    return Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.grey)),
          child: SearchableDropdown.multiple(
            items: _ulkeItems,
            selectedItems: selectedulke,
            hint: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Ülke"),
            ),
            searchHint: "Ülke",
            onChanged: (value) {
              setState(() {
                selectedulke = value;
              });
            },
            displayItem: (item, selected) {
              return (Row(children: [
                selected
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                SizedBox(width: 7),
                Expanded(
                  child: item,
                ),
              ]));
            },
            selectedValueWidgetFn: (item) {
              return (Center(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.brown,
                          width: 0.5,
                        ),
                      ),
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item.toString()),
                      ))));
            },
            doneButton: (selectedItemsDone, doneContext) {
              return (ElevatedButton(
                  onPressed: () {
                    Navigator.pop(doneContext);
                    setState(() {});
                  },
                  child: Text("Kaydet")));
            },
            closeButton: "Kapat",
            style: TextStyle(fontStyle: FontStyle.italic),
            searchFn: (String keyword, items) {
              List<int> ret = [];
              if (keyword != null && items != null && keyword.isNotEmpty) {
                keyword.split(" ").forEach((k) {
                  int i = 0;
                  items.forEach((item) {
                    if (k.isNotEmpty &&
                        (item.value
                            .toString()
                            .toLowerCase()
                            .contains(k.toLowerCase()))) {
                      ret.add(i);
                    }
                    i++;
                  });
                });
              }
              if (keyword.isEmpty) {
                ret = Iterable<int>.generate(items.length).toList();
              }
              return (ret);
            },
            clearIcon: Icon(Icons.clear_all),
            icon: Icon(Icons.arrow_drop_down_circle),
            label: "Seçilenler",
            underline: Container(
              height: 1.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.teal, width: 3.0))),
            ),
            iconDisabledColor: Colors.brown,
            iconEnabledColor: Colors.indigo,
            isExpanded: true,
          ),
          width: 250.0,
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
      if (this.ulkeid > 0) {
        getsehirler();
      }
    });
  }

  Widget sehirfield() {
    return Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.grey)),
          child: SearchableDropdown.multiple(
            items: _sehirItems,
            selectedItems: selectedsehir,
            hint: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Şehir"),
            ),
            searchHint: "Şehir",
            onChanged: (value) {
              setState(() {
                selectedsehir = value;
              });
            },
            displayItem: (item, selected) {
              return (Row(children: [
                selected
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                SizedBox(width: 7),
                Expanded(
                  child: item,
                ),
              ]));
            },
            selectedValueWidgetFn: (item) {
              return (Center(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.brown,
                          width: 0.5,
                        ),
                      ),
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item.toString()),
                      ))));
            },
            doneButton: (selectedItemsDone, doneContext) {
              return (ElevatedButton(
                  onPressed: () {
                    Navigator.pop(doneContext);
                    setState(() {});
                  },
                  child: Text("Kaydet")));
            },
            closeButton: "Kapat",
            style: TextStyle(fontStyle: FontStyle.italic),
            searchFn: (String keyword, items) {
              List<int> ret = [];
              if (keyword != null && items != null && keyword.isNotEmpty) {
                keyword.split(" ").forEach((k) {
                  int i = 0;
                  items.forEach((item) {
                    if (k.isNotEmpty &&
                        (item.value
                            .toString()
                            .toLowerCase()
                            .contains(k.toLowerCase()))) {
                      ret.add(i);
                    }
                    i++;
                  });
                });
              }
              if (keyword.isEmpty) {
                ret = Iterable<int>.generate(items.length).toList();
              }
              return (ret);
            },
            clearIcon: Icon(Icons.clear_all),
            icon: Icon(Icons.arrow_drop_down_circle),
            label: "Seçilenler",
            underline: Container(
              height: 1.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.teal, width: 3.0))),
            ),
            iconDisabledColor: Colors.brown,
            iconEnabledColor: Colors.indigo,
            isExpanded: true,
          ),
          width: 250.0,
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

  Widget isdurumfield() {
    return Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.grey)),
          child: SearchableDropdown.multiple(
            items: _isdurumItems,
            selectedItems: selectedisdurum,
            hint: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("İş Durumu"),
            ),
            searchHint: "İş Durumu",
            onChanged: (value) {
              setState(() {
                selectedisdurum = value;
              });
            },
            displayItem: (item, selected) {
              return (Row(children: [
                selected
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                SizedBox(width: 7),
                Expanded(
                  child: item,
                ),
              ]));
            },
            selectedValueWidgetFn: (item) {
              return (Center(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.brown,
                          width: 0.5,
                        ),
                      ),
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(item.toString()),
                      ))));
            },
            doneButton: (selectedItemsDone, doneContext) {
              return (ElevatedButton(
                  onPressed: () {
                    Navigator.pop(doneContext);
                    setState(() {});
                  },
                  child: Text("Kaydet")));
            },
            closeButton: "Kapat",
            style: TextStyle(fontStyle: FontStyle.italic),
            searchFn: (String keyword, items) {
              List<int> ret = [];
              if (keyword != null && items != null && keyword.isNotEmpty) {
                keyword.split(" ").forEach((k) {
                  int i = 0;
                  items.forEach((item) {
                    if (k.isNotEmpty &&
                        (item.value
                            .toString()
                            .toLowerCase()
                            .contains(k.toLowerCase()))) {
                      ret.add(i);
                    }
                    i++;
                  });
                });
              }
              if (keyword.isEmpty) {
                ret = Iterable<int>.generate(items.length).toList();
              }
              return (ret);
            },
            clearIcon: Icon(Icons.clear_all),
            icon: Icon(Icons.arrow_drop_down_circle),
            label: "Seçilenler",
            underline: Container(
              height: 1.0,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.teal, width: 3.0))),
            ),
            iconDisabledColor: Colors.brown,
            iconEnabledColor: Colors.indigo,
            isExpanded: true,
          ),
          width: 250.0,
        ),
      ],
    );
  }

  void changedisdurumItem(String selectedisdurum) {
    setState(() {
      _secilenisdurum = selectedisdurum;
      int id = 0;
      id = isdurumlist.indexWhere((value) => value.ad == _secilenisdurum);
      double idd = 0;
      idd = double.parse(isdurumlist[id].id.toString());
      this.isdurumid = idd.toInt();
    });
  }

  Widget ticaretturufield() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: <Widget>[
          Text("Ticaret Türü",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          SizedBox(
            width: 20.0,
          ),
          Text('İthalat',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          Radio(
              value: 1,
              groupValue: _ticaretturuValue,
              onChanged: _ticaretturuValueChange),
          Text('İhracat',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
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
      this._ticaretturuValue = value;
      Navigator.of(context, rootNavigator: true).pop('dialog');
      detayliaramaDialog();
    });
  }

  TextEditingController txtyas1 = new TextEditingController();
  TextEditingController txtyas2 = new TextEditingController();

  Widget yasfield() {
    return Row(
      children: <Widget>[
        Text("Yaş Aralığı",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20.0,
        ),
        Container(
          child: TextFormField(
            controller: txtyas1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Min",
              hintText: "Min",
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              )),
            ),
          ),
          width: 80.0,
        ),
        SizedBox(
          width: 7.0,
        ),
        Container(
          child: TextFormField(
            controller: txtyas2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Max",
              hintText: "Max",
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              )),
            ),
          ),
          width: 80.0,
        ),
      ],
    );
  }

  void detayliaramaDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Detaylı Arama"),
          content: detayliarama(),
          scrollable: true,
          actions: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Kapat"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )

            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

////////////////////detayliarama///////////////////////////////////////////////////////////

  mesaj(BuildContext context, String deger) {
    var alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text(deger),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  SingleChildScrollView grupdataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: false,
        sortColumnIndex: 0,
        columnSpacing: 60.0,
        headingRowHeight: 0.0,
        dataRowHeight: 60.0,
        dividerThickness: 0.00,
        columns: [
          DataColumn(
            label: Text("",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
            numeric: false,
            tooltip: "",
          ),
        ],
        rows: gruplist
            .map(
              (grup) => DataRow(cells: [
                DataCell(
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        // color: Color.fromRGBO(186, 74, 0, 1),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(18.0),
                        //     side: BorderSide(color: Colors.red)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: () {
                          gruplist.first;
                          index = gruplist.indexOf(grup);
                          Degiskenler.favorigrupid = gruplist[index].id.toInt();
                          postgruptemsilci();
                          Degiskenler.favoritemsilciid = 0;
                          Degiskenler.favorigrupid = 0;
                          mesaj(context, "Favorilere eklendi.");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.group,
                              color: Colors.white,
                              size: 50.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  grup.grupadi,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
            .toList(),
      ),
    );
  }

  void goToDetail() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TemsilciDetail()));
    if (result != null) {
      if (result) {
        getlist();
      }
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: false,
        sortColumnIndex: 0,
        columnSpacing: 25.0,
        headingRowHeight: 5.0,
        dataRowHeight: 120.0,
        dividerThickness: 7.00,
        columns: [
          DataColumn(
            label: Text("",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
            numeric: false,
            tooltip: "",
          ),
          DataColumn(
            label: Text("",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
            numeric: false,
            tooltip: "",
          ),
          DataColumn(
            label: Text("",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
            numeric: false,
            tooltip: "",
          ),
          DataColumn(
            label: Text("",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
            numeric: false,
            tooltip: "",
          ),
        ],
        rows: anasayfalist
            .map(
              (anasayfa) => DataRow(cells: [
                DataCell(
                  Row(
                    children: <Widget>[
                      Image.network(
                        anasayfa.resimurl.toString(),
                        width: 50.0,
                        height: 50.0,
                      ),
                    ],
                  ),
                  onTap: () {
                    anasayfalist.first;
                    index = anasayfalist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        anasayfalist[index].temsilciid.toInt();
                    goToDetail();
                  },
                ),
                DataCell(
                  Column(
                    children: <Widget>[
                      bosluk(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(anasayfa.ad,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      bosluk(),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: ElevatedButton(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(8.0),
                              //     side: BorderSide(color: Colors.red)),
                              // color: Colors.red,
                              // textColor: Colors.white,
                              // padding: EdgeInsets.all(2.0),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                anasayfalist.first;
                                index = anasayfalist.indexOf(anasayfa);
                                Degiskenler.temsilciid =
                                    anasayfalist[index].temsilciid.toInt();
                                goToDetail();
                              },
                              child: Text(
                                anasayfa.pozisyon,
                                style: TextStyle(
                                  fontSize: 9.0,
                                ),
                              ),
                            ),
                            height: 30.0,
                          )),
                      bosluk(),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: ElevatedButton(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(8.0),
                              //     side: BorderSide(color: Colors.blueAccent)),
                              // color: Colors.blueAccent,
                              // textColor: Colors.white,
                              // padding: EdgeInsets.all(2.0),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueAccent)),
                              onPressed: () {
                                anasayfalist.first;
                                index = anasayfalist.indexOf(anasayfa);
                                Degiskenler.temsilciid =
                                    anasayfalist[index].temsilciid.toInt();
                                goToDetail();
                              },
                              child: Text(
                                "10-12 Yıl",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                            height: 15.0,
                          )),
                    ],
                  ),
                  onTap: () {
                    anasayfalist.first;
                    index = anasayfalist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        anasayfalist[index].temsilciid.toInt();
                    goToDetail();
                  },
                ),
                DataCell(
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 30.0,
                      ),
                      Text(anasayfa.ulke,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal)),
                    ],
                  ),
                  onTap: () {
                    anasayfalist.first;
                    index = anasayfalist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        anasayfalist[index].temsilciid.toInt();
                    goToDetail();
                  },
                ),
                DataCell(
                  Row(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          anasayfalist.first;
                          index = anasayfalist.indexOf(anasayfa);
                          Degiskenler.favoritemsilciid =
                              anasayfalist[index].temsilciid.toInt();
                          addDialog();
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.star,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  onTap: () {
                    anasayfalist.first;
                    index = anasayfalist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        anasayfalist[index].temsilciid.toInt();
                    goToDetail();
                  },
                ),
              ]),
            )
            .toList(),
      ),
    );
  }
}
