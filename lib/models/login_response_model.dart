class LoginResponse {
  String? type;
  String? token;

  LoginResponse({this.type, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }
}
