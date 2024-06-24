class ProfileActualizar {
   int accountId;
   String name;
   String description;
   String imageUrl;
   String location;
   int planId;

  ProfileActualizar({
    required this.accountId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.planId
  });

  ProfileActualizar.fromJson(Map<String, dynamic> json):
      accountId = json['accountId'],
      name= json['name'],
      description= json['description'],
      imageUrl= json['imageUrl'],
      location = json['location'],
      planId = json['planId'];

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'planId': planId
    };
  }
}


class Profile {
   int accountId;
   String email;
   String name;
   String description;
   String imageUrl;
   String location;
   int planId;
   String type;

  Profile({
    required this.accountId,
    required this.email,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.planId,
    required this.type
  });

  Profile.fromJson(Map<String, dynamic> json):
      accountId = json['accountId'],
      email = json['email'],
      name= json['name'],
      description= json['description'],
      imageUrl= json['imageUrl'],
      location = json['location'],
      planId = json['planId'],
      type = json['type'];

  Map<String, dynamic> toJson() {
    return {
      'email':email,
      'accountId': accountId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'planId': planId
    };
  }
}







