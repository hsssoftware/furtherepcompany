import 'package:kommrade_firma/apis/temsilci_dil_bilgileri_api.dart';
import 'package:kommrade_firma/apis/temsilci_egitim_bilgileri_api.dart';
import 'package:kommrade_firma/apis/temsilci_genel_bilgiler_api.dart';
import 'package:kommrade_firma/apis/temsilci_is_deneyimleri_api.dart';
import 'package:kommrade_firma/apis/temsilci_referans_bilgileri_api.dart';
import 'package:kommrade_firma/apis/temsilci_vize_bilgileri_api.dart';
import 'package:kommrade_firma/models/temsilci_dil.dart';
import 'package:kommrade_firma/models/temsilci_egitim.dart';
import 'package:kommrade_firma/models/temsilci_genelbilgiler.dart';
import 'package:kommrade_firma/models/temsilci_isdeneyim.dart';
import 'package:kommrade_firma/models/temsilci_pasaport.dart';
import 'package:kommrade_firma/models/temsilci_referans.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kommrade_firma/models/degiskenler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:kommrade_firma/apis/gruplar_api.dart';
import 'package:kommrade_firma/models/gruplar.dart';
import 'package:kommrade_firma/apis/grup_temsilci_ekle_api.dart';
import 'package:kommrade_firma/models/grup_temsilci_ekle.dart';

class TemsilciDetail extends StatefulWidget {
  static const String routename = "/temsilcidetay";
  @override
  State<StatefulWidget> createState() => TemsilciDetailState();
}

class TemsilciDetailState extends State {
  List<TemsilciDilModel> temsilcidillist = [];
  List<TemsilciEgitimModel> temsilciegitimlist = [];
  List<TemsilciGenelBilgilerModel> temsilcigenellist = [];
  List<TemsilciIsDeneyimModel> temsilciisdeneyimlist = [];
  List<TemsilciPasaportModel> temsilcipasaportlist = [];
  List<TemsilciReferansModel> temsilcireferanslist = [];
  List<GruplarModel> gruplist = [];
  List<GrupTemsilciEkle> kayitlist = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temsilci Detay"),
      ),
      body: listegetir(),
    );
  }

  getdil() {
    TemsilciDilApi.getdil(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilcidillist =
            list.map((detay) => TemsilciDilModel.fromJson(detay)).toList();
      });
    });
  }

  getegitim() {
    TemsilciEgitimApi.getegitim(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilciegitimlist =
            list.map((detay) => TemsilciEgitimModel.fromJson(detay)).toList();
      });
    });
  }

  getgenel() {
    TemsilciGenelApi.getgenel(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilcigenellist = list
            .map((detay) => TemsilciGenelBilgilerModel.fromJson(detay))
            .toList();
      });
    });
  }

  getisdeneyim() {
    TemsilciIsDeneyimApi.getisdeneyim(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilciisdeneyimlist = list
            .map((detay) => TemsilciIsDeneyimModel.fromJson(detay))
            .toList();
      });
    });
  }

  getpasaport() {
    TemsilciVizeApi.getvize(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilcipasaportlist =
            list.map((detay) => TemsilciPasaportModel.fromJson(detay)).toList();
      });
    });
  }

  getreferans() {
    TemsilciReferansApi.getreferans(Degiskenler.temsilciid).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.temsilcireferanslist =
            list.map((detay) => TemsilciReferansModel.fromJson(detay)).toList();
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

  Widget ustbilgiler() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 300.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          bosluk(),
          userimage(),
          bosluk(),
          Text(
              temsilcigenellist[0].ad.toString() +
                  " " +
                  temsilcigenellist[0].soyad.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          bosluk(),
          Text(temsilcigenellist[0].pozisyon.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          bosluk(),
          buttons(),
        ],
      ),
    );
  }

  Widget userimage() {
    return CircleAvatar(
        radius: 70,
        backgroundImage:
            NetworkImage(temsilcigenellist[0].resimurl.toString()));
  }

  Widget buttons() {
    return Row(
      children: [
        bosluk(),
        bosluk(),
        bosluk(),
        ElevatedButton(
          onPressed: () {},
          child: Text("CV Görüntüle"),
        ),
        bosluk(),
        ElevatedButton(
          onPressed: () {
            Degiskenler.favoritemsilciid = Degiskenler.temsilciid;
            addDialog();
          },
          child: Text("Favorilere Ekle"),
        ),
        bosluk(),
        ElevatedButton(
          onPressed: () {},
          child: Text("CV Gönder"),
        ),
      ],
    );
  }

  Widget kullanicibilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Kullanıcı Bilgileri",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Ad:" + temsilcigenellist[0].ad.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Soyad:" + temsilcigenellist[0].soyad.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Pozisyon:" + temsilcigenellist[0].pozisyon.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Doğum Tarihi:" +
                DateFormat('dd.MM.yyyy').format(
                    DateTime.parse(temsilcigenellist[0].dogumtar.toString())),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Medeni Durum:" + temsilcigenellist[0].medenidurum.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Cinsiyet:" + temsilcigenellist[0].cinsiyet.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " İş Durumu:" + temsilcigenellist[0].isdurum.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget iletisimbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " İletişim Bilgileri",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Ülke:" + temsilcigenellist[0].ulke.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Şehir:" + temsilcigenellist[0].sehir.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Ev Tel:" + temsilcigenellist[0].evtel.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Cep Tel:" + temsilcigenellist[0].ceptel.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Adres:" + temsilcigenellist[0].adres.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Facebook:" + temsilcigenellist[0].facebook.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            " Linkedin" + temsilcigenellist[0].linkedin.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget hakkimdabilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 130.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Hakkımda",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          Text(
            temsilcigenellist[0].hakkinda.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget egitimbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Eğitim",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3.0,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: temsilciegitimlist
                  .map((item) => Container(
                      color: Color.fromRGBO(10, 39, 97, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.school,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          bosluk(),
                          bosluk(),
                          bosluk(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bosluk(),
                              Center(
                                child: Text(
                                  item.okulad,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy').format(
                                    DateTime.parse(item.tar.toString())),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item.puan,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item.seviye,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Widget isdeneyimbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " İş Deneyimi",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3.0,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: temsilciisdeneyimlist
                  .map((item) => Container(
                      color: Color.fromRGBO(10, 39, 97, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.work,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          bosluk(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bosluk(),
                              Text(
                                "Firma Adı:" + item.firmadi,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Görev:" + item.gorev,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Ülke:" + item.ulke,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Şehir:" + item.sehir,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                        item.girtar.toString())) +
                                    " - " +
                                    DateFormat('dd.MM.yyyy').format(
                                        DateTime.parse(item.ciktar.toString())),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Widget referansbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Referanslar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3.0,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: temsilcireferanslist
                  .map((item) => Container(
                      color: Color.fromRGBO(10, 39, 97, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person_pin,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          bosluk(),
                          bosluk(),
                          bosluk(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bosluk(),
                              Center(
                                child: Text(
                                  "Adı:" + item.adsoyad,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "Firma Adı:" + item.firmadi,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Telefon:" + item.tel,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "E-Mail:" + item.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Widget dilbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Dil",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3.0,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: temsilcidillist
                  .map((item) => Container(
                      color: Color.fromRGBO(10, 39, 97, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.language,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          bosluk(),
                          bosluk(),
                          bosluk(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bosluk(),
                              Center(
                                child: Text(
                                  item.dil,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  item.seviye,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Widget pasaportbilgileri() {
    return Container(
      width: MediaQuery.of(context).size.width - 10.0,
      height: 165.0,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(0, 51, 102, 1),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " Pasaport",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 2.0,
            width: 2.0,
          ),
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3.0,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: temsilcipasaportlist
                  .map((item) => Container(
                      color: Color.fromRGBO(10, 39, 97, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.card_travel,
                            size: 80.0,
                            color: Colors.white,
                          ),
                          bosluk(),
                          bosluk(),
                          bosluk(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bosluk(),
                              Center(
                                child: Text(
                                  "Ülke:" + item.ulke,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "Pasaport No:" + item.no,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                        item.bastar.toString())) +
                                    " - " +
                                    DateFormat('dd.MM.yyyy').format(
                                        DateTime.parse(item.bittar.toString())),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Widget listegetir() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          ustbilgiler(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          kullanicibilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          iletisimbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          hakkimdabilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          egitimbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          isdeneyimbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          referansbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          dilbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
          pasaportbilgileri(),
          SizedBox(
            height: 8.0,
            width: 8.0,
          ),
        ],
      ),
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
    getdil();
    getegitim();
    getgenel();
    getisdeneyim();
    getpasaport();
    getreferans();
    getgruplist();
  }
}
