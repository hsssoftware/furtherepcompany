import 'package:http/http.dart' as http;

class Registerapi {
  static Future postregister(String firmaadi, String adres, String vergino, String vergidairesi, 
  String email, String kullaniciadi, String sifre, String url, 
  String playerid,int ticaretturu,int sektorid,int sirketturu) {
    
      return http.post(Uri.parse("http://52.19.0.183:9000/api/v1/values/uyekaydi?firmaadi=" +
          firmaadi.toString() +
          "&adres=" +
          adres.toString()+
          "&vergi_no=" +
          vergino.toString()+
          "&vergi_dairesi=" +
          vergidairesi.toString()+
          "&e_mail=" +
          email.toString()+
          "&kullanici_adi=" +
          kullaniciadi.toString()+
          "&sifre=" +
          sifre.toString()+
          "&url=" +
          url.toString()+
          "&player_id=" +
          playerid.toString()+
          "&ticaret_turu=" +
          ticaretturu.toString()+
          "&sektor_id=" +
          sektorid.toString()+
          "&sirket_turu=" +
          sirketturu.toString())
          );
    
  }
}
