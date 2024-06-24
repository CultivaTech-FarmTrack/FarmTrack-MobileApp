class User{
  int? id;
  String? email;
  String? name;
  String? userName;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.userName
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    return data;
  }

}