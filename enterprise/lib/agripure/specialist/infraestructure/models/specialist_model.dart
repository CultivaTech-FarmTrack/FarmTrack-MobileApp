class Specialist {
  int? id;
  String? name;
  String? description;
  String? info_favorite_plants;
  String? info_certifications;
  String? info_experience;
  String? cellphone_number;
  String? contact_email;
  String? telephone_number;
  String? whatsapp_number;


  Specialist({
      required this.id,
      required this.name,
      required this.description,
      required this.info_favorite_plants,
      required this.info_certifications,
      required this.info_experience,
      required this.cellphone_number,
  required this.contact_email,
  required this.whatsapp_number,
    required this.telephone_number
});

  Specialist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    info_favorite_plants = json['info_favorite_plants'];
    info_certifications = json['info_certifications'];
    info_experience = json['info_experience'];
    cellphone_number = json['cellphone_number'];
    contact_email=json['contact_email'];
    whatsapp_number=json['whatsapp_number'];
    telephone_number=json['telephone_number'];
  }
}