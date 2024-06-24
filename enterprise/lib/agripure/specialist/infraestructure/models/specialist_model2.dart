class Specialist2 {

  String? email;
  String? name;
  String? description;
  String? imageUrl;
  String? location;
  String? type;
  int? planId;
  int? accountId;

  Specialist2({
    required this.email,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.type,
    required this.planId,
    required this.accountId,
  });

  Specialist2.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    location = json['location'];
    type = json['type'];
    planId = json['planId'];
    accountId = json['accountId'];
  }
}
