import 'package:agripure_mobile/agripure/farmer/infraestructure/repositories/plant_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddPlantView extends StatefulWidget {
  const AddPlantView({Key? key}) : super(key: key);

  @override
  State<AddPlantView> createState() => _AddPlantViewState();
}

class _AddPlantViewState extends State<AddPlantView> {
  bool _isLoading = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Add plants',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search plants",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
                        border: InputBorder.none, hintText: "Search a plant"),
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
            FutureBuilder(
                initialData: [],
                future: PlantService.getPlants(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  List filteredPlants = snapshot.data!
                      .where((plant) => plant.name
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList();
                  if (snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "All plants selected",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if (filteredPlants.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "Plant not found",
                            style: TextStyle(
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                '${plant.imageUrl}',
                                                width: double.infinity,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${plant.name}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });

                                                    PlantService.savePlant(
                                                            plant.id)
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context, true))
                                                        .catchError((error) {
                                                      String errorMessage =
                                                          "Ocurrió un error durante el inicio de sesión";
                                                      errorMessage =
                                                          error.toString();
                                                      Fluttertoast.showToast(
                                                          msg: errorMessage,
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  174,
                                                                  0,
                                                                  1.0),
                                                          textColor:
                                                              Colors.black,
                                                          fontSize: 18.0);
                                                    }).whenComplete(() {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                  ),
                                                  child: _isLoading
                                                      ? Container(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              const CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .white),
                                                            strokeWidth: 3.0,
                                                          ))
                                                      : const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.0),
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
