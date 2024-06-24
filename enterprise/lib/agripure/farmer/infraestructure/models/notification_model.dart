import 'dart:ffi';

class NotificationFarmer{
  final int id;
  final String message;
  final String imageUrl;
  final String notificationType;
  final String date;
  final int toAccountId;
  final int plantId;
  final int fromAccountId;
  final bool seen;


   NotificationFarmer({
    required this.id,
    required this.message,
    required this.imageUrl,
    required this.notificationType,
    required this.date,
    required this.toAccountId,
    required this.plantId,
    required this.fromAccountId,
    required this.seen
  });

  

  NotificationFarmer.fromJson(Map<String, dynamic> json)
  :
      id = json['id'],
      message= json['message'],
      imageUrl= json['imageUrl'],
      notificationType= json['notificationType'],
      date= json['date'],
      toAccountId= json['toAccountId'],
      plantId= json['plantId'],
      fromAccountId= json['fromAccountId'],
      seen= json['seen'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'imageUrl': imageUrl,
      'notificationType': notificationType,
      'date': date,
      'toAccountId': toAccountId,
      'plantId': plantId,
      'fromAccountId': fromAccountId,
      'seen': seen
    };
  }

}