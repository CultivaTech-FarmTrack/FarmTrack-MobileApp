
import 'package:agripure_mobile/agripure/farmer/presentation/views/signin_farmer.dart';
import 'package:agripure_mobile/agripure/specialist/presentation/views/signin_specialist.dart';
import 'package:flutter/material.dart';


class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserTypeSelection(),
    );
  }
}

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select your role',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // Tamaño de fuente del título
                fontWeight: FontWeight.bold, // Estilo de fuente en negrita
              ),
            ),
          const SizedBox(height: 50), // Espacio entre el título y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de Farmer
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInFarmer()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0),
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Haz que el botón sea cuadrado
                    ),
                  ),
                  child: const Text('FARMER'),
                ),
                const SizedBox(width: 16), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de Specialist
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInSpecialist()));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0),                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Haz que el botón sea cuadrado
                    ),
                  ),
                  child: const Text('SPECIALIST'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

