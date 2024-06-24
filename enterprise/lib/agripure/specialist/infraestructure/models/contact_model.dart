class Contact {
  final int id;
  final int farmerId;
  final int specialistId;
  final bool isChatStarted;

  Contact({
    required this.id,
    required this.farmerId,
    required this.specialistId,
    required this.isChatStarted,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      farmerId: json['farmerId'],
      specialistId: json['specialistId'],
      isChatStarted: json['isChatStarted'],
    );
  }
}