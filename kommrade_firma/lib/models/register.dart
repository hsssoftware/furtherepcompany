class Register {
  String status;
  String message;


  Register(String status, String message) {
    this.status = status;
    this.message = message;
  }

  Register.fromJson(Map json) {
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
