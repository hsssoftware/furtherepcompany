import 'package:flutter/material.dart';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:kommrade_firma/apis/talep_sayilar_api.dart';
import 'package:kommrade_firma/models/talep_sayilar.dart';
import 'dart:convert';
import 'package:kommrade_firma/screens/talep_detay_screen.dart';

class TalepScreen extends StatefulWidget {
  static const String routename = "/talep";
  @override
  State<StatefulWidget> createState() => TalepScreenState();
}

class TalepScreenState extends State {
  List<TalepSayilarModel> taleplist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Talep"),
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
        body: Container(
          child: listegetir(),
          padding: EdgeInsets.all(15.0),
        ));
  }

  @override
  void initState() {
    super.initState();
    getlist();
  }

  getlist() {
    TalepSayilarApi.gettalepsayi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.taleplist =
            list.map((talep) => TalepSayilarModel.fromJson(talep)).toList();
      });
    });
  }

  void goToDetail(TalepSayilarModel talepsayi) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TalepDetail(talepsayi)));
    setState(() {
      getlist();
    });
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 25, backgroundImage: NetworkImage(Degiskenler.resimurl));
  }

  Widget yayinbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(21, 67, 96, 1))),
      onPressed: () {
        Degiskenler.talep = "Yayındakiler";
        Degiskenler.talepsay = int.parse(this.taleplist[0].yayinsay.toString());
        goToDetail(this.taleplist[0]);
        Degiskenler.taleptip = 1;
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event,
            color: Colors.white,
            size: 60.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ' Yayındakiler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                this.taleplist[0].yayinsay.toString() + ' Talep Bulundu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 293.0,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 60.0,
          ),
        ],
      ),
    );
  }

  Widget pasifbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(100, 30, 22, 1))),
      onPressed: () {
        Degiskenler.talep = "Pasifler";
        Degiskenler.talepsay = int.parse(this.taleplist[0].pasifsay.toString());
        goToDetail(this.taleplist[0]);
        Degiskenler.taleptip = 0;
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event_busy,
            color: Colors.white,
            size: 60.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ' Pasifler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                this.taleplist[0].pasifsay.toString() + ' Talep Bulundu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 290.0,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 60.0,
          ),
        ],
      ),
    );
  }

  Widget taslakbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(186, 74, 0, 1))),
      onPressed: () {
        Degiskenler.talep = "Taslaklar";
        Degiskenler.talepsay =
            int.parse(this.taleplist[0].taslaksay.toString());
        goToDetail(this.taleplist[0]);
        Degiskenler.taleptip = 2;
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event_available,
            color: Colors.white,
            size: 60.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ' Taslaklar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                this.taleplist[0].taslaksay.toString() + ' Talep Bulundu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 290.0,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 60.0,
          ),
        ],
      ),
    );
  }

  Widget arsivbutton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(98, 101, 103, 1))),
      onPressed: () {
        Degiskenler.talep = "Arşivler";
        Degiskenler.talepsay = int.parse(this.taleplist[0].arsivsay.toString());
        goToDetail(this.taleplist[0]);
        Degiskenler.taleptip = 3;
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event_note,
            color: Colors.white,
            size: 60.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ' Arşivler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                this.taleplist[0].arsivsay.toString() + ' Talep Bulundu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 290.0,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 60.0,
          ),
        ],
      ),
    );
  }

  Widget listegetir() {
    return Column(
      children: <Widget>[
        yayinbutton(),
        SizedBox(
          height: 6.0,
          width: 6.0,
        ),
        pasifbutton(),
        SizedBox(
          height: 6.0,
          width: 6.0,
        ),
        taslakbutton(),
        SizedBox(
          height: 6.0,
          width: 6.0,
        ),
        arsivbutton(),
      ],
    );
  }
}
