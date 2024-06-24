
import 'package:agripure_mobile/agripure/farmer/infraestructure/models/profile_model.dart';
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController rolController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController planId = TextEditingController();
  int? userId;
  ProfileService? profileService;
  ProfileActualizarFarmer? profileActualizar;
  Profile? profile;
  Future<SharedPreferences>? _prefs;


  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('accountId');
    profile = await profileService?.getData(userId!);
    setState(() {
      profile = profile;
      emailController.text = profile?.email??'';
      nameController.text = profile?.name ?? '';
      descriptionController.text = profile?.description ?? '';
      imageUrlController.text = profile?.imageUrl ?? '';
      locationController.text = profile?.location ?? '';
      rolController.text = profile?.type?? '';
    });
  }

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    profileService = ProfileService();
    initialize();
    super.initState();
  }
  
    void updateUserProfile() async {
    final updatedUser = ProfileActualizarFarmer(
      accountId: profile!.accountId,
      name: profile!.name,
      description: profile!.description,
      imageUrl: profile!.imageUrl,
      location: profile!.location,
      planId: profile!.planId,
    );

    try {
      await profileService?.updateData(updatedUser);
      setState(() {
      profileActualizar = updatedUser;
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
   
    //final String? image = user?.imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text("AgriPure, your planting assistant", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,),
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 55.0),
              Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: profileService?.getData(4),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Muestra una imagen de carga mientras se espera la respuesta del backend
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Manejar errores
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // Muestra la imagen del perfil una vez que se carga
                      return CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(snapshot.data?.imageUrl ?? ''),
                      );
                    }
                  },
                ),
              ),
              // ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  '${profile?.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              
              const SizedBox(height: 16.0),
              buildTextField('Email', emailController),
              buildTextField('Description', descriptionController),
              buildTextField('Location', locationController),
              buildTextField('Type', rolController),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //ElevatedButton(
                  //  onPressed: signOut,
                  //  child: const Text('Sign Out'),
                  //),
                  //ElevatedButton(
                  //  onPressed: updateUserProfile,
                  //  child: const Text('Update'),
                  //),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget buildTextField(String labelText, TextEditingController controller) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Text(
            labelText,
            style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 24),
          ),
          const SizedBox( 
            height: 5.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  controller: controller,
                ),
              ),
            ),
          ),
        ],
      ));
}
class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileView(),
    );
  }
}


void main() {
  runApp(ProfileApp());
}