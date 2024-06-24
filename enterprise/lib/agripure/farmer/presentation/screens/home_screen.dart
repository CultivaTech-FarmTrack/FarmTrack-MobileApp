
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'identification_view.dart';
import '../views/iot_devices_view.dart';
import '../../../specialist/presentation/views/notifications_view.dart';
import '../views/plants_view.dart';
import '../../../specialist/presentation/views/settings_view.dart';
import '../views/specialist_view.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(index);
}

class _HomeScreenState extends State<HomeScreen> {
  final int index;
  _HomeScreenState(this.index);

  int selectedIndex = 0;

  Future<SharedPreferences>? _prefs;
  String? type = "";

  Future InitializeVar() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('type');
    print(type);
  }

  @override
  void initState(){
    selectedIndex = index;
    InitializeVar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screens = [const PlantsView(), const NotificationsView(), const IdentificationView(), const SpecialistView(), const IoTDevicesView(),const SettingsView()];

    return Scaffold(
      appBar: AppBar(
        title: Text("AgriPure, your planting assistant", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,),
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: screens
        ),),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.yard_outlined),
              activeIcon: Icon(Icons.yard),
              label: "Plants",
              backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on_outlined),
              activeIcon: Icon(Icons.notifications),
              label: "Notifications",
              backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.linked_camera_outlined),
              activeIcon: Icon(Icons.linked_camera),
              label: "Identify",
              backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.psychology_alt_outlined),
              activeIcon: Icon(Icons.psychology_alt),
              label: "Specialists",
              backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_circle_outlined),
              activeIcon: Icon(Icons.cloud_circle),
              label: "IoT Devices",
              backgroundColor: Colors.green
          ),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: Colors.green
          )
        ],
      ),
    );
  }
}
