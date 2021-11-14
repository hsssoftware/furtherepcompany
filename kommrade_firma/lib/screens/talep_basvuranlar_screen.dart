import 'package:flutter/material.dart';
import 'package:kommrade_firma/apis/talep_basvuranlar_api.dart';
import 'package:kommrade_firma/models/talep_basvuranlar.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/gruplar_api.dart';
import 'package:kommrade_firma/models/gruplar.dart';
import 'package:kommrade_firma/apis/grup_temsilci_ekle_api.dart';
import 'package:kommrade_firma/models/grup_temsilci_ekle.dart';
import 'package:kommrade_firma/screens/temsilci_detay_screen.dart';

class TalepBasvuranlarScreen extends StatefulWidget {
  static const String routename = "/talepbasvuranlar";
  @override
  State<StatefulWidget> createState() => TalepBasvuranlarScreenState();
}

class TalepBasvuranlarScreenState extends State {
  List<TalepBasvuranlarModel> anasayfalist = [];
  int sayfa = 0;
  int index = 0;
  List<GruplarModel> gruplist = [];
  List<GrupTemsilciEkle> kayitlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Talep Başvuranlar"),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: listegetir(),
          margin: EdgeInsets.all(5.0),
        ));
  }

  @override
  void initState() {
    super.initState();
    getlist();
    getgruplist();
  }

  getlist() {
    TalepBasvuruApi.gettalep(Degiskenler.talepid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.anasayfalist = list
            .map((anasayfa) => TalepBasvuranlarModel.fromJson(anasayfa))
            .toList();
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
        labelText: "",
        hintText: "Ülke, şehir ve pozisyon",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget filterbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(10, 39, 97, 1))),
      onPressed: () {},
      child: Row(
        children: <Widget>[
          Text(
            '    ',
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.format_list_numbered,
            color: Colors.white,
            size: 40.0,
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
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(186, 74, 0, 1))),
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
                              Icons.group_work,
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
                                  fontSize: 10.0,
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
