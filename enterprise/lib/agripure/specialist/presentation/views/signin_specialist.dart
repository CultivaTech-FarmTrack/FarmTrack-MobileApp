
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class SignInSpecialist extends StatefulWidget {
  const SignInSpecialist({super.key});

  @override
  State<SignInSpecialist> createState() => _SignInSpecialistState();
}

class _SignInSpecialistState extends State<SignInSpecialist> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _plantIdController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _areasOfFocusController = TextEditingController();
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
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Expertise",
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
                        controller: _expertiseController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your expertise",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Contact Email",
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
                        controller: _contactEmailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter contact email",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Areas of Focus",
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
                        controller: _areasOfFocusController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter areas of focus",
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
                              
                              AuthService.registerSpecialist(_emailController.text, _passwordController.text, _nameController.text, _descriptionController.text, _imageUrlController.text, _locationController.text, "SPECIALIST", int.parse(_plantIdController.text) , _expertiseController.text, _contactEmailController.text, _areasOfFocusController.text).then((_) {
                                String message = "New specialist created. Log In";
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: const Color.fromRGBO(
                                        47, 152, 48, 1.0),
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }).catchError((error){
                                String errorMessage = "Error created specialist.";
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