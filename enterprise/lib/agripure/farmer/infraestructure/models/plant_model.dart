class Plant {
  int? id;
  String? name;
  String? image;
  String? scientifist_name;
  String? variety;
  String? depth;
  String? distance_between;
  String? info_land_type;
  String? info_distance_between;
  String? info_fert_fumig;
  String? info_ideal_depth;
  int? intervale_fert;
  int? intervale_fumig;

  Plant({
    required this.id,
    required this.name,
    required this.image,
    required this.scientifist_name,
    required this.variety,
    required this.depth,
    required this.distance_between,
    required this.info_land_type,
    required this.info_distance_between,
    required this.info_fert_fumig,
    required this.info_ideal_depth,
    required this.intervale_fert,
    required this.intervale_fumig
  });

  Plant.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    scientifist_name = json['scientifist_name'];
    variety = json['variety'];
    depth = json['depth'];
    distance_between = json['distance_between'];
    info_land_type = json['info_land_type'];
    info_distance_between    = json['info_distance_between'];
    info_fert_fumig = json['info_fert_fumig'];
    info_ideal_depth = json['info_ideal_depth'];
    intervale_fert = json['intervale_fert'];
    intervale_fumig = json['intervale_fumig'];
  }
}