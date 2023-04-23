import 'package:flutter/material.dart';
import 'package:podcast/Screen/home_screen.dart';
import 'package:podcast/Screen/login_page.dart';
import 'package:podcast/Services/auth.dart';

import '../Services/SharedPreferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name = "";
  bool changeButton = false;
  var usermod;

  final _formKey = GlobalKey<FormState>();
  final username_controller=TextEditingController();
  final passd_controller=TextEditingController();
  final email_controller=TextEditingController();


  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(usermod: usermod,)));
      // setState(() {
      //   changeButton = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Signup",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 3,
                ),
              ),
            ),
            Divider(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 250,
                    width: 320,
                    child: Image.asset(
                      "assets/images/signup.png",
                      fit: BoxFit.cover,
                      color: Colors.transparent,
                      colorBlendMode: BlendMode.overlay,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Welcome $name",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username_controller,
                          decoration: InputDecoration(
                            hintText: "Enter username",
                            labelText: "Username",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username cannot be empty";
                            }else if (value.length < 3) {
                              return "Username length should be atleast 3";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            name = value.replaceAll("@gmail.com", "");
                            setState(() {});
                          },
                        ),
                        TextFormField(
                          controller: email_controller,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            labelText: "Email",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }else if (!value.endsWith("@gmail.com")) {
                              return "Not a valid Email";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passd_controller,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value.length < 6) {
                              return "Password length should be atleast 6";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Material(
                          color: Colors.blue,
                          borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 8),
                          child: InkWell(
                            onTap: () async{
                              usermod= await AuthService().registerWithEmailAndPasswd(email_controller.text, passd_controller.text);
                              if(usermod!=null){
                                //update  user
                                usermod.updateUser(username_controller);

                                HelperFunction.userNameKey=usermod.Name;
                                HelperFunction.userLoggedInKey=usermod.uid;
                                HelperFunction.saveUserLoggedInStatus(true);
                                HelperFunction.saveUserName(HelperFunction.userNameKey);
                                moveToHome(context);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      duration: Duration(seconds: 5),
                                      content: Text("Error: User Already Exist",style: TextStyle(color: Colors.white54),),
                                    )
                                );
                                throw "Please Login";
                              }

                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: changeButton ? 50 : 150,
                              height: 50,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                                  : Text(
                                "Signup",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(thickness: 0.3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Have Account? ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}