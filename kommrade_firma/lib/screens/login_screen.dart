import 'package:flutter/material.dart';
import 'package:kommrade_firma/screens/home.dart';
import 'package:kommrade_firma/apis/login_api.dart';
import 'package:kommrade_firma/models/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kommrade_firma/models/degiskenler.dart' as variables;
import 'package:kommrade_firma/screens/register_screen.dart';
import 'package:kommrade_firma/apis/firma_bilgiler_api.dart';
import 'package:kommrade_firma/models/firma_bilgiler.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = "/login";
  @override
  State<StatefulWidget> createState() => LoginScreenAddState();
}

class LoginScreenAddState extends State {
  final formkey = GlobalKey<FormState>();

  List<Login> loginlist = [];
  String username = "";
  String psw = "";
  List<FirmaBilgilerModel> firmalist = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              image(),
              emailfield(),
              bosluk(),
              sifrefield(),
              bosluk(),
              girisbutton(),
              kayitbutton(),
            ],
          )),
    );
  }

  ayarkaydet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', txtemail.text);
    prefs.setString('psw', txtsifre.text);
    prefs.setString('firmaid', loginlist[0].firmaid.toString());
    prefs.setString('firmadi', loginlist[0].kullaniciadi.toString());
    prefs.setString('resimurl', loginlist[0].resimurl.toString());

    variables.Degiskenler.username = txtemail.text;
    variables.Degiskenler.psw = txtsifre.text;
    double id = 0.0;
    id = double.parse(loginlist[0].firmaid.toString());
    variables.Degiskenler.firmaid = id.toInt();
    variables.Degiskenler.resimurl = loginlist[0].resimurl.toString();
    variables.Degiskenler.firmaadi = loginlist[0].kullaniciadi.toString();
  }

  ayaroku() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    psw = prefs.getString('psw');

    variables.Degiskenler.username = "";
    variables.Degiskenler.psw = "";
    variables.Degiskenler.firmaid = 0;
    variables.Degiskenler.resimurl = "";
    variables.Degiskenler.firmaadi = "";

    if (prefs.getString('username').toString() != null)
      variables.Degiskenler.username = prefs.getString('username');
    else
      variables.Degiskenler.username = "";
    if (prefs.getString('psw').toString() != null)
      variables.Degiskenler.psw = prefs.getString('psw');
    else
      variables.Degiskenler.psw = "";

    if (prefs.getString('firmaid').toString() != null) {
      double id = 0.0;
      id = double.parse(prefs.getString('firmaid'));
      variables.Degiskenler.firmaid = id.toInt();
    } else
      variables.Degiskenler.firmaid = 0;

    if (prefs.getString('firmadi').toString() != null)
      variables.Degiskenler.firmaadi = prefs.getString('firmadi');
    else
      variables.Degiskenler.firmaadi = "";

    if (prefs.getString('resimurl').toString() != null)
      variables.Degiskenler.resimurl = prefs.getString('resimurl');
    else
      variables.Degiskenler.resimurl = "";

    if (username != "") txtemail.text = variables.Degiskenler.username;
    if (psw != "") txtsifre.text = variables.Degiskenler.psw;

    if (variables.Degiskenler.username != "" &&
        variables.Degiskenler.psw != "" &&
        variables.Degiskenler.username != null &&
        variables.Degiskenler.psw != null) {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Home();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    ayaroku();
  }

  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtsifre = new TextEditingController();

  Widget emailfield() {
    return TextFormField(
      controller: txtemail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'E-Mail giriniz...',
        labelText: "E-Mail",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget sifrefield() {
    return TextFormField(
      controller: txtsifre,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Şifrenizi giriniz...',
        labelText: "Şifre",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        )),
      ),
    );
  }

  Widget image() {
    return Image.asset("assets/images/logo.png", width: 150.0, height: 150.0);
  }

  Widget bosluk() {
    return Column(
      children: <Widget>[
        Text(""),
        SizedBox(
          width: 2.0,
          height: 2.0,
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

  getlist() {
    FirmaBilgilerapi.getfirma().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.firmalist =
            list.map((firma) => FirmaBilgilerModel.fromJson(firma)).toList();
      });
    });
  }

  loginkontrol() {
    if (txtemail.text == "") {
      mesaj(context, "E-Mail girilmemiş...");
      return;
    }
    if (txtsifre.text == "") {
      mesaj(context, "Şifre girilmemiş...");
      return;
    }
    if (txtemail.text == "demo" && txtsifre.text == "123") {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Home();
      }));
    } else {
      getLogin();
      if (this.loginlist.length > 0) {
        ayarkaydet();
        getlist();
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new Home();
        }));
      } else {
        mesaj(context, "Kullanıcı bilgileri hatalı...");
      }
    }
  }

  Widget girisbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("GİRİŞ YAP"),
        onPressed: () {
          setState(() {
            loginkontrol();
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)),
      ),
    );
  }

  Widget kayitbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("KAYIT OL"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new RegisterScreen();
          }));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 95, 205, 1))),
      ),
    );
  }

  getLogin() {
    Loginapi.getLogin(txtemail.text, "", txtsifre.text).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.loginlist = list.map((login) => Login.fromJson(login)).toList();
      });
    });
  }
}
