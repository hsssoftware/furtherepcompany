import 'package:http/http.dart' as http;
class IsDurumApi {
  static Future getisdurum(){
  
    
        return http.get(Uri.parse("http://52.19.0.183:9000/api/v1/values/tr_is_durum"));
    
    
  }
}