
import 'package:agripure_mobile/agripure/farmer/presentation/views/profile_view.dart';
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/auth_service.dart';
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isExpanded = false;

  Future<void> changeEmail(String newEmail, String password) async {
    try {
      await SettingsService.changeEmail(newEmail);
      // Mostrar una notificación o mensaje de éxito aquí
    } catch (error) {
      // Mostrar una notificación o mensaje de error aquí
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await SettingsService.changePassword(currentPassword, newPassword);
      // Mostrar una notificación o mensaje de éxito aquí
    } catch (error) {
      // Mostrar una notificación o mensaje de error aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0), // Color de fondo gris
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Alinear al centro
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20), // Espacio en blanco entre "Settings" y las divisiones

            // División para "Profile Settings" centrada
            Container(
              margin: EdgeInsets.symmetric(vertical: 10), // Ajuste del margen vertical
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  
                ],
              ),
            ),

            // Línea de división
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            // "Sign Off"
            
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const ProfileView()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black, // Establece el color del texto en negro
                  elevation: 0, // Elimina la sombra del botón
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('email');
                  prefs.remove('name');
                  prefs.remove('description');
                  prefs.remove('accountId');
                  prefs.remove('type');
                  prefs.remove('planId');
                  prefs.remove('imageUrl');
                  prefs.remove('location');

                  print(prefs.getString("type"));
                  AuthService.logOut().then((_) => {
                    Navigator.pushReplacementNamed(context, '/auth')
                  });

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  elevation: 0, // Elimina la sombra del botón
                  side: const BorderSide(color: Colors.white),
                ),
                child: Text(
                  "Sign Off",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
                        ],
                      ),
                    ),
                  );
                }
}