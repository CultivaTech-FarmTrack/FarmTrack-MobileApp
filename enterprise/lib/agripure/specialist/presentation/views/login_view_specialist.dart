import 'dart:async';
import 'package:agripure_mobile/agripure/farmer/presentation/screens/home_screen.dart';
import 'package:agripure_mobile/agripure/specialist/infraestructure/repositories/auth_service.dart';
import 'package:agripure_mobile/agripure/specialist/presentation/screens/home_screen_specialist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool remember = false;
  Future<SharedPreferences>? _prefs;
  String? type = "";

  Future InitializeVar() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('type');
    String user = prefs.getString("user")??"";
    String pass = prefs.getString("pass")??"";
    setState(() {
      remember = prefs.getBool("rem")??false;
    });
    _usernameController.text = user;
    _passwordController.text = pass;
    print(type);
    if (type != null) {
      navigateToHomeScreen();
    }
  }

  void navigateToHomeScreen() {
    if (type == "FARMER") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(index: 0)),
      );
    } else if (type == "SPECIALIST") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenSpecialist(index: 0)),
      );
    }
  }

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    InitializeVar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter email",
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
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

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: remember,
                        onChanged: (value) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          setState(() {
                            remember = value!;
                          });
                          if(remember){
                            prefs.setString("user", _usernameController.text);
                            prefs.setString("pass", _passwordController.text);
                            prefs.setBool("rem", remember);
                          } else {
                            prefs.remove("user");
                            prefs.remove("pass");
                            prefs.setBool("rem", remember);
                          }},
                        checkColor: Colors.white,
                        activeColor: const Color.fromRGBO(47, 152, 48, 1.0),
                      ),
                      Text("Remember this credentials",
                        style: TextStyle(fontSize: 15, color: Colors.white),)
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0)),
                          onPressed: () async{
                            setState(() {
                              _isLoading = true;
                            });        
                            AuthService.logIn(_usernameController.text, _passwordController.text).then((_) =>{
                              InitializeVar()
                            }).catchError((error){
                              String errorMessage = "Ocurrió un error durante el inicio de sesión";
                              errorMessage = error.toString();
                              Fluttertoast.showToast(
                                  msg: errorMessage,
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: const Color.fromRGBO(
                                      255, 174, 0, 1.0),
                                  textColor: Colors.black,
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
                            child: Text("Log in", style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
    );
    
  }
  
}