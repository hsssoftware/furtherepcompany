import 'package:http/http.dart' as http;

class Loginapi {
  static Future getLogin(String email,String kullaniciadi ,String sifre) {
    
      return http.post(Uri.parse("http://52.19.0.183:9000/api/v1/values/giris?e_mail=" +
          email.toString() +
          "&sifre=" +
          sifre.toString()+
          "&kullanici_adi=" +
          kullaniciadi.toString())
          );
    
  }
}
