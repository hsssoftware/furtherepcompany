import 'package:kommrade_firma/apis/talepler_api.dart';
import 'package:kommrade_firma/models/talepler.dart';
import 'package:kommrade_firma/models/talep_sayilar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/screens/talep_izle_screen.dart';

class TalepDetail extends StatefulWidget {
  final TalepSayilarModel talep;
  TalepDetail(this.talep);
  static const String routename = "/talepdetay";
  @override
  State<StatefulWidget> createState() => TalepDetailState(talep);
}

class TalepDetailState extends State {
  TalepSayilarModel talep;
  TalepDetailState(this.talep);
  List<TaleplerModel> taleplerlist = [];
  bool sort = false;
  int sayfa = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taleplerim"),
      ),
      body: listegetir(),
    );
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        Container(
          child: Align(
            child: Text(
              Degiskenler.talep + "(" + Degiskenler.talepsay.toString() + ")",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            alignment: Alignment.topLeft,
          ),
          padding: EdgeInsets.all(10.0),
        ),
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
    TaleplerApi.gettalep().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.taleplerlist =
            list.map((talepler) => TaleplerModel.fromJson(talepler)).toList();
      });
    });
  }

  void goToDetail() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TalepIzle()));
    setState(() {
      getdetay();
    });
  }

  @override
  void initState() {
    super.initState();
    getdetay();
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: false,
        sortColumnIndex: 0,
        columnSpacing: 25.0,
        headingRowHeight: 5.0,
        dataRowHeight: 80.0,
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
        ],
        rows: taleplerlist
            .map(
              (talep) => DataRow(cells: [
                DataCell(
                    Column(
                      children: <Widget>[
                        Align(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                size: 30.0,
                              ),
                              Text(talep.pozisyon,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.device_hub,
                                size: 30.0,
                              ),
                              Text(talep.ticaretturu,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ), onTap: () {
                  taleplerlist.first;
                  index = taleplerlist.indexOf(talep);
                  Degiskenler.talepid = taleplerlist[index].id.toInt();
                  goToDetail();
                }),
                DataCell(
                    Column(
                      children: <Widget>[
                        Align(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 30.0,
                              ),
                              Text(talep.ulke,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_city,
                                size: 30.0,
                              ),
                              Text(talep.il,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ), onTap: () {
                  taleplerlist.first;
                  index = taleplerlist.indexOf(talep);
                  Degiskenler.talepid = taleplerlist[index].id.toInt();
                  goToDetail();
                }),
                DataCell(
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 3.0,
                              height: 3.0,
                            ),
                            Text(talep.goruntulemesayi.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                            Text(talep.basvurusayi.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ],
                    ), onTap: () {
                  taleplerlist.first;
                  index = taleplerlist.indexOf(talep);
                  Degiskenler.talepid = taleplerlist[index].id.toInt();
                  goToDetail();
                })
              ]),
            )
            .toList(),
      ),
    );
  }
}
