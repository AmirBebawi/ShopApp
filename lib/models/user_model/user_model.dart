class UserModel {
  late bool status;
   String ? message ;
  late DataModel data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int id;

  late String name;

  late String email;

  late String phone;

  late String image;

  late int points;

  late int credit;

  late String token;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
