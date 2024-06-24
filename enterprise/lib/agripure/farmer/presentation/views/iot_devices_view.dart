import 'dart:async';
import 'package:agripure_mobile/agripure/farmer/infraestructure/models/iot_model.dart';
import 'package:agripure_mobile/agripure/farmer/infraestructure/repositories/iot_service.dart';
import 'package:flutter/material.dart';
import 'device_catalog_view.dart';

class IoTDevicesView extends StatefulWidget {
  const IoTDevicesView({Key? key}) : super(key: key);

  @override
  State<IoTDevicesView> createState() => _IoTDevicesView();
}

class _IoTDevicesView extends State<IoTDevicesView> {
  bool isExpanded = false;
  late Timer _timer; // Nuevo
  late Future<List<IoTDevice>> _devicesFuture;

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador para actualizar cada 10 segundos
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
     
      _refreshData();
    });
    
    _devicesFuture = _loadDevicesData();


  }

  Future<List<IoTDevice>> _loadDevicesData() async {
    try {
      return await IoTService.getDeviceByFarmerId();
    } catch (e) {
      print('Error al cargar los datos: $e');
      throw e; // Lanza la excepción para que sea manejada por el FutureBuilder
    }
  }
  // Función para actualizar los datos
  Future<void> _refreshData() async {
    try {
      
      setState(() {
        _devicesFuture = _loadDevicesData();

      });
    } catch (e) {
      print('Error al actualizar los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var response = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeviceCatalogView()));

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
              Text("IoT Devices",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Text("Search device",
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
                          hintText: "Ingrese un dispositivo a buscar"
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              //Text("Specialist contacted: ",
              //  style: TextStyle(
              //    fontSize: 22,
              //    fontWeight: FontWeight.bold,
              //    color: Colors.white,
              //  ),),

              SizedBox(
                height: 15,
              ),

              FutureBuilder(
                  initialData: [],
                  future:  _devicesFuture,
                  builder: (context, AsyncSnapshot<List> snapshot){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < snapshot.data!.length) {
                              var device = snapshot.data![index];

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
                                          //ClipRRect(
                                          //    borderRadius: BorderRadius.circular(15),
                                          //    child: Image.network('${device.imageUrl}',
                                          //      width: double.infinity,
                                          //      height: 200,
                                          //      fit: BoxFit.cover,)
                                          //),

                                          SizedBox(
                                            height:  10,
                                          ),

                                          Text("${device.name}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text("Crop: ${device.cropName}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),),


                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text("Temperature ${device.planTemperature}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text("Humidity ${device.planHumidity}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),),


                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    //Navigator.push(context, MaterialPageRoute(
                                                    //    builder: (context) => SpecialistDetailView(specialist: specialist)
                                                    //));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.orange, // Establecer el fondo anaranjado
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Text("Details", style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
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
                            } /*else {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4D4D4D),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'NOT AVAILABLE SPECIALISTS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }*/


                          }),
                    );
                  }
              )
            ],
          ),

        )
    );
  }
}