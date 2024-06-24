
import 'package:agripure_mobile/agripure/farmer/infraestructure/repositories/plant_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_plant_view.dart';
import 'plant_detail_view.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({Key? key}) : super(key: key);

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  String searchText = '';

  Future<String> obtenerSaludo() async {
    var horaActual = DateTime.now().hour;
    String saludo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name')?? "Invitado";
    if(horaActual >= 0 && horaActual < 12){
      saludo = "Good Morning $name";
    } else if(horaActual >=12 && horaActual < 18){
      saludo = "Good Afternoon $name";
    } else {
      saludo = "Good Night $name";
    }
    return saludo;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var response = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPlantView()));

            if(response == true) {
              setState(() {});
            }
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.deepOrange,
        ),

        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                  future: obtenerSaludo(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    String saludo = snapshot.data ?? "";
                    return Text(saludo,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    );
                  }
              ),
              SizedBox(
                height: 15,
              ),

              Text("Search plants",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),

              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ingrese planta a buscar"
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Text("Your plants: ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),

              SizedBox(
                height: 15,
              ),

              FutureBuilder(
                  initialData: [],
                  future:  PlantService.getPlantsByUserName(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    List filteredPlants = snapshot.data!.where((plant) =>
                      plant.name.toLowerCase().contains(searchText.toLowerCase())).toList();
                    if (snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("No plants selected", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          ),
                        ),
                      );
                    } else {
                      if (filteredPlants.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text("Plant not found", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                        child: ListView.builder(
                            itemCount: filteredPlants.length,
                            itemBuilder: (context, index) {
                              var plant = filteredPlants[index];
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(15),
                                              child: Image.network(
                                                '${plant.imageUrl}',
                                                width: double.infinity,
                                                height: 200,
                                                fit: BoxFit.cover,)
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                            "${plant.name}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold
                                          ),),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    var response = await Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                PlantDetailView(
                                                                    plant: plant)
                                                        ));

                                                    if(response == true) {
                                                      setState(() {});
                                                    }
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor: Colors
                                                        .orange, // Establecer el fondo anaranjado
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(12.0),
                                                    child: Text("Details",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      ),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            }),
                      );
                      }
                    }
                  }
              )
            ],
          ),

        )
    );
  }
}