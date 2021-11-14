import 'package:flutter/material.dart';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/grup_ekle_api.dart';
import 'package:kommrade_firma/models/grup_ekle.dart';
import 'dart:convert';
import 'package:kommrade_firma/apis/gruplar_api.dart';
import 'package:kommrade_firma/models/gruplar.dart';
import 'package:kommrade_firma/screens/favori_detay_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kommrade_firma/apis/grup_sil_api.dart';

class FavorilerScreen extends StatefulWidget {
  static const String routename = "/favoriler";
  @override
  State<StatefulWidget> createState() => FavorilerScreenState();
}

class FavorilerScreenState extends State {
  List<GrupEkle> kayitlist = [];
  List<GruplarModel> gruplist =[];
  int index = 0;
  int delete = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoriler"),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getlist();
  }

  getlist() {
    GruplarApi.getgrup().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.gruplist =
            list.map((grup) => GruplarModel.fromJson(grup)).toList();
      });
    });
  }

  deletegrup(int grupid) {
    GrupSilApi.deletegrup(grupid).then((response) {
      setState(() {
        this.delete = int.parse(response.body.toString());
      });
      if (this.delete == 1) {
        setState(() {
          getlist();
        });
      } else {
        mesaj(context, "Grup silinemedi...");
        return;
      }
    });
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 25, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  TextEditingController txtgrup = new TextEditingController();

  Widget grupfield() {
    return TextFormField(
      controller: txtgrup,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Grup Adı",
        hintText: "Grup Adı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget addbutton() {
    return Container(
      width: 75.0,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(10, 39, 97, 1))),
        onPressed: () {
          addDialog();
        },
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  void addDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Grup Ekle"),
          content: grupfield(),
          actions: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Kaydet"),
                  onPressed: () {
                    grupekle();
                    setState(() {
                      getlist();
                    });
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    mesaj(context, "Eklendi");
                  },
                ),
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

  void goToDetail() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FavoriDetail()));
    if (result != null) {
      if (result) {
        getlist();
      }
    }
  }

  grupekle() {
    GrupEkleApi.postgrup(
      Degiskenler.firmaid,
      txtgrup.text,
    ).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.kayitlist = list.map((kayit) => GrupEkle.fromJson(kayit)).toList();
      });
      if (this.kayitlist[0].status.toString() == "success") {
      } else {
        mesaj(context, this.kayitlist[0].message.toString());
      }
    });
  }

  SingleChildScrollView dataBody() {
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
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.15,
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          // color: Color.fromRGBO(186, 74, 0, 1),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(18.0),
                          //     side: BorderSide(color: Colors.red)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(186, 74, 0, 1))),
                          onPressed: () {
                            gruplist.first;
                            index = gruplist.indexOf(grup);
                            Degiskenler.detaygrupid =
                                gruplist[index].id.toInt();
                            Degiskenler.detaygrupadi =
                                gruplist[index].grupadi.toString();
                            goToDetail();
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
                                      fontSize: 18.0,
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
                    actions: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(3.0),
                        child: IconSlideAction(
                          color: Colors.blue,
                          icon: Icons.remove_red_eye,
                          onTap: () {
                            gruplist.first;
                            index = gruplist.indexOf(grup);
                            Degiskenler.detaygrupid =
                                gruplist[index].id.toInt();
                            Degiskenler.detaygrupadi =
                                gruplist[index].grupadi.toString();
                            goToDetail();
                          },
                        ),
                      )
                    ],
                    secondaryActions: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(3.0),
                        child: IconSlideAction(
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            gruplist.first;
                            index = gruplist.indexOf(grup);
                            deletegrup(gruplist[index].id.toInt());
                            setState(() {
                              getlist();
                              super.initState();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            )
            .toList(),
      ),
    );
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 5.0,
          height: 5.0,
        ),
        dataBody(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            addbutton(),
            SizedBox(
              height: 24.0,
              width: 24.0,
            ),
          ],
        ),
      ],
    );
  }
}
