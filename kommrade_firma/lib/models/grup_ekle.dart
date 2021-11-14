class GrupEkle {
  String status;
  String message;


  GrupEkle(String status, String message) {
    this.status = status;
    this.message = message;
  }

  GrupEkle.fromJson(Map json) {
    status = json["status"].toString();
    message = json["message"].toString();

  }

  Map toJson() {
    return {
      "status": status,
      "message": message
    };
  }
}
