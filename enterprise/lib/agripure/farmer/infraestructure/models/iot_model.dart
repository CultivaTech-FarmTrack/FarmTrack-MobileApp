class IoTDevice {
  final int? id;
  final String? name;
  final String? model;
  final String? category;
  final String? cropName;
  final int? farmerId;
  final int? projectId;
  final bool? active;
  final int? cropId;
  final bool? activeNotification;
  final bool? activeRealTimeData;
  final double? planTemperature;
  final double? planHumidity;

  
  IoTDevice({
    required this.id,
    required this.name,
    required this.model,
    required this.category,
    required this.cropName,
    required this.farmerId,
    required this.projectId,
    required this.active,
    required this.cropId,
    required this.activeNotification,
    required this.activeRealTimeData,
    required this.planTemperature,
    required this.planHumidity,
  });


  IoTDevice.fromJson(Map<String, dynamic> json)
  :
      id= json['id'],
      name= json['name'],
      model= json['model'],
      category= json['category'],
      cropName= json['cropName'],
      farmerId= json['farmerId'],
      projectId= json['projectId'],
      active= json['active'],
      cropId= json['cropId'],
      activeNotification= json['activeNotification'],
      activeRealTimeData= json['activeRealTimeData'],
      planTemperature= json['planTemperature'].toDouble(),
      planHumidity= json['planHumidity'].toDouble();

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'category': category,
      'cropName': cropName,
      'farmerId': farmerId,
      'projectId': projectId,
      'active': active,
      'cropId': cropId,
      'activeNotification': activeNotification,
      'activeRealTimeData': activeRealTimeData,
      'planTemperature': planTemperature,
      'planHumidity': planHumidity,
    };
  }
}

class IoTDeviceInformation{
  final double planTemperature;
  final double planHumidity;

  IoTDeviceInformation.fromJson(Map<String, dynamic> json)
  :
      planTemperature= json['planTemperature'].toDouble(),
      planHumidity= json['planHumidity'].toDouble();

  Map<String, dynamic> toJson() {
    return {
      'planTemperature': planTemperature,
      'planHumidity': planHumidity,
    };
  }
}