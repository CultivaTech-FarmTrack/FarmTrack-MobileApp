import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class SignInFarmer extends StatefulWidget {
  const SignInFarmer({super.key});

  @override
  State<SignInFarmer> createState() => _SignInFarmerState();
}

class _SignInFarmerState extends State<SignInFarmer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _plantIdController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromRGBO(40, 40, 40, 1.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Email",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter email",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter password",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter full name",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Description",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter description",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Image",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter url",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Location",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter location",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Plant",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        controller: _plantIdController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter plant id",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0)),
                            onPressed: (){
                              setState(() {
                                _isLoading = true;
                              });                              
                              AuthService.registerFarmer(_emailController.text, _passwordController.text, _nameController.text , _descriptionController.text , _imageUrlController.text, _locationController.text, "FARMER", int.parse(_plantIdController.text)).then((_) {
                                String message = "New farmer created. Log In";
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: const Color.fromRGBO(
                                        47, 152, 48, 1.0),
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }).catchError((error){
                                String errorMessage = "Error register farmer. ";
                                errorMessage = error.toString();
                                Fluttertoast.showToast(
                                    msg: errorMessage,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: const Color.fromRGBO(
                                        222, 15, 15, 1.0),
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }).whenComplete(() {
                                  setState(() {
                                    _isLoading = false;
                                });
                              });
                            },
                            child: _isLoading
                                ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 3.0,
                                )
                            ) : Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20)),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
            ),
          ),
      ),
    );
  }
}
