class Plant2 {
  int? id;
  String? name;
  String? imageUrl;
  String? scientificName;
  String? variety;
  String? depth;
  String? weatherConditions;
  String? distanceBetweenPlants;
  String? idealPlantingDepth;
  String? fertilizationAndFumigation;

  Plant2({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.scientificName,
    required this.variety,
    required this.depth,
    required this.weatherConditions,
    required this.distanceBetweenPlants,
    required this.idealPlantingDepth,
    required this.fertilizationAndFumigation,
  });

  Plant2.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    scientificName = json['scientificName'];
    variety = json['variety'];
    depth = json['depth'];
    weatherConditions = json['weatherConditions'];
    distanceBetweenPlants = json['distanceBetweenPlants'];
    idealPlantingDepth    = json['idealPlantingDepth'];
    fertilizationAndFumigation = json['fertilizationAndFumigation'];
  }
}