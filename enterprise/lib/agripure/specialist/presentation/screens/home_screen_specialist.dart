
import 'package:agripure_mobile/agripure/farmer/presentation/views/project_view.dart';
import 'package:agripure_mobile/agripure/specialist/presentation/views/farmers_view.dart';
import 'package:agripure_mobile/agripure/specialist/presentation/views/notifications_view.dart';
import 'package:agripure_mobile/agripure/specialist/presentation/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeScreenSpecialist extends StatefulWidget {
  final int index;
  const HomeScreenSpecialist({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeScreenSpecialist> createState() => _HomeScreenSpecialistState(index);
}

class _HomeScreenSpecialistState extends State<HomeScreenSpecialist> {
  final int index;
  _HomeScreenSpecialistState(this.index);

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

    final screens = [const FarmersView(), const NotificationsView(), const ProjectView(),const SettingsView()];

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
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Farmers",
              backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on_outlined),
              activeIcon: Icon(Icons.notifications),
              label: "Notifications",
              backgroundColor: Colors.green
          ),


          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              activeIcon: Icon(Icons.calendar_month),
              label: "Projects",
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
