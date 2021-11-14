import 'package:kommrade_firma/apis/grup_detay_api.dart';
import 'package:kommrade_firma/models/grup_detay.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/grup_temsilci_sil_api.dart';
import 'package:kommrade_firma/screens/temsilci_detay_screen.dart';

class FavoriDetail extends StatefulWidget {
  static const String routename = "/favoridetay";
  @override
  State<StatefulWidget> createState() => FavoriDetailState();
}

class FavoriDetailState extends State {
  List<GrupDetayModel> detaylist =[];
  bool sort = false;
  int sayfa = 0;
  int delete = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Degiskenler.detaygrupadi.toString()),
      ),
      body: listegetir(),
    );
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        bosluk(),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(1.0),
          child: dataBody(),
        )),
      ],
    );
  }

  Widget listelebutton() {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        setState(() {
          getdetay();
        });
      },
      color: Colors.blue,
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

  getdetay() {
    GrupDetayApi.getgrupdetay(Degiskenler.detaygrupid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.detaylist =
            list.map((detay) => GrupDetayModel.fromJson(detay)).toList();
      });
    });
  }

  deletetemsilcigrup(int grupid, int temsilciid) {
    GrupTemsilciSilApi.deletetemsilcigrup(grupid, temsilciid).then((response) {
      setState(() {
        this.delete = int.parse(response.body.toString());
      });
      if (this.delete == 1) {
      } else {
        mesaj(context, "Temsilci silinemedi...");
        return;
      }
    });
  }

  mesaj(BuildContext context, String deger) {
    var alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text(deger),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  void initState() {
    super.initState();
    getdetay();
  }

  void goToDetail() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TemsilciDetail()));
    if (result != null) {
      if (result) {
        getdetay();
      }
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: false,
        sortColumnIndex: 0,
        columnSpacing: 20.0,
        headingRowHeight: 5.0,
        dataRowHeight: 120.0,
        dividerThickness: 5.00,
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
        rows: detaylist
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
                    detaylist.first;
                    index = detaylist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        detaylist[index].temsilciid.toInt();
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
                                detaylist.first;
                                index = detaylist.indexOf(anasayfa);
                                Degiskenler.temsilciid =
                                    detaylist[index].temsilciid.toInt();
                                goToDetail();
                              },
                              child: Text(
                                anasayfa.pozisyon,
                                style: TextStyle(
                                  fontSize: 9.0,
                                ),
                              ),
                            ),
                            height: 35.0,
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
                                detaylist.first;
                                index = detaylist.indexOf(anasayfa);
                                Degiskenler.temsilciid =
                                    detaylist[index].temsilciid.toInt();
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
                    detaylist.first;
                    index = detaylist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        detaylist[index].temsilciid.toInt();
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
                    detaylist.first;
                    index = detaylist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        detaylist[index].temsilciid.toInt();
                    goToDetail();
                  },
                ),
                DataCell(
                  Row(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          detaylist.first;
                          index = detaylist.indexOf(anasayfa);
                          deletetemsilcigrup(detaylist[index].grupid.toInt(),
                              detaylist[index].temsilciid.toInt());
                          setState(() {
                            getdetay();
                          });
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.delete,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  onTap: () {
                    detaylist.first;
                    index = detaylist.indexOf(anasayfa);
                    Degiskenler.temsilciid =
                        detaylist[index].temsilciid.toInt();
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
