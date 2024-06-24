
import 'package:agripure_mobile/agripure/specialist/infraestructure/models/notification_model.dart';
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<NotificationSpecialist>? notifications;
  Future<SharedPreferences>? _prefs;

  Future initialize() async {
    final pref = await _prefs;
    int? accountId = pref?.getInt('accountId');
    List<NotificationSpecialist> fetchedNotifications = await AuthService.getNotifications(accountId!);
    setState(() {
      notifications = fetchedNotifications;
    });
  }


  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications?.length ?? 0,
                itemBuilder: (context, index) {
                  final currentNotification = notifications?[index];
                  final message = currentNotification?.message ?? '';
                  final imageUrl = currentNotification?.imageUrl ?? '';

                  return NotificationCard(
                    message: message,
                    imageUrl: imageUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;
  final String imageUrl;

  NotificationCard({required this.message, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: ListTile(
        title: Text(message),
        leading: imageUrl.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              )
            : SizedBox.shrink(), // Opcional: Puedes ajustar cómo manejar si la URL de la imagen está vacía
      ),
    );
  }
}
