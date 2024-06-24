import 'dart:convert';
import 'package:agripure_mobile/agripure/farmer/infraestructure/models/plant_model2.dart';
import 'package:agripure_mobile/agripure/farmer/infraestructure/repositories/plant_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';

class PlantDetailView extends StatefulWidget {
  final Plant2 plant;
  const PlantDetailView({Key? key, required this.plant}) : super(key: key);

  @override
  State<PlantDetailView> createState() => _PlantDetailViewState(plant);
}

class _PlantDetailViewState extends State<PlantDetailView> {
  final Plant2 plant;
  _PlantDetailViewState(this.plant);
  DateTime today = DateTime.now();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.white, // Cambiar el color de la flecha de regreso a blanco
          ),
          title: Text('${plant.name}', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                PlantService.deletePlant(plant.id!).then((value) =>
                    Navigator.pop(context, true)
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic information:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 12,
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.white,),
                    title: Text('Scientifist Name: ${plant.scientificName}', style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Montserrat"
                    ),),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.white,),
                    title: Text('Variety: ${plant.variety}', style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w300
                    ),),
                  ),


                  SizedBox(
                    height: 26,
                  ),

                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network('${plant.imageUrl}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,)
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text('Planting information:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 12,
                  ),

                  Text('Distance between: ${plant.distanceBetweenPlants}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Depth: ${plant.depth}', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Ideal Planting Depth: ${plant.idealPlantingDepth} days', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 10,
                  ),

                  Text('Fumigation interval: ${plant.fertilizationAndFumigation} days', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Montserrat"
                  ),),

                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Set Fertilization\n event", textAlign: TextAlign.center,),
                        ),
                        onPressed: () async{
                          DateTime currentDate = today.add(Duration(days: int.parse(plant.distanceBetweenPlants!)));
                          //for (int i = 0; i < 3; i++){
                          //  await EventService.saveEvent(Event("Fertilization of ${plant.name}",0,DateFormat("yyyy-MM-dd").format(currentDate)));
                          //  currentDate = currentDate.add(Duration(days: int.parse(plant.distanceBetweenPlants!)));
                          //}
                          Fluttertoast.showToast(
                              msg: "Fertilization event created",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.orange,
                              textColor: Colors.black,
                              fontSize: 18.0
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(index: 1)));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Set Fumigation\n event", textAlign: TextAlign.center,),
                        ),
                        onPressed: () async{
                          DateTime currentDate = today;
                          //for (int i = 0; i < 4; i++){
                          //  await EventService.saveEvent(Event("Fumigation of ${plant.name}",0,DateFormat("yyyy-MM-dd").format(currentDate)));
                          //  currentDate = currentDate.add(Duration(days: int.parse(plant.fertilizationAndFumigation!)));
                          //}
                          Fluttertoast.showToast(
                              msg: "Fumigation event created",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.orange,
                              textColor: Colors.black,
                              fontSize: 18.0
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(index: 1)));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen(index: 3)));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: const Text("Do you have a query?"),
                            ),
                          ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Text('Extra information:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    height: 26,
                  ),

                  ExpansionTile(
                    title: Text('Plant distance between plants:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${plant.distanceBetweenPlants}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),


                  ExpansionTile(
                    title: Text('Land type:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${plant.depth}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 26,
                  ),

                  ExpansionTile(
                    title: Text('Ideal depth for planting:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${plant.depth}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 26,
                  ),

                  ExpansionTile(
                    title: Text('Fertilization and fumigation:', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('${plant.fertilizationAndFumigation}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                        ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

