import 'package:flutter/material.dart';
import 'package:podcast/Modal/UserModel.dart';
import 'package:podcast/Screen/home_screen.dart';
import 'package:podcast/Screen/signup_page.dart';
import 'package:podcast/Services/SharedPreferences.dart';
import 'package:podcast/Services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late final user;

  String name = "";
  bool changeButton = false;
  bool _isLoading= false;
  var usermod;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  final myController_username = TextEditingController();
  final myController_passwd = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController_username.dispose();
    myController_passwd.dispose();
    super.dispose();
  }
  

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(userid: usermod.uid,)));

      // setState(() {
      //   changeButton = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: _isLoading?
        Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
            :SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login",
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
                    Image.asset(
                      "assets/images/login3.png",
                      fit: BoxFit.cover,
                      color: Colors.transparent,
                      colorBlendMode: BlendMode.overlay,
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
                            controller: myController_username,
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
                            controller: myController_passwd,
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
                                usermod= await AuthService().signInWithEmailAndPasswd(myController_username.text, myController_passwd.text);
                                if(usermod!=null){
                                  //update user
                                  // usermod.updateUser(myController_username);

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
                                        content: Text("Error: User Doesn't Exist",style: TextStyle(color: Colors.white54),),
                                      )
                                  );
                                  throw "Go For SignUp";
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
                                  "Login",
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
                                "Do Not Have Account? ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                    ),
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