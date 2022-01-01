


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget{
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen>
{

  @override
  void initState() {
    super.initState();

  }

  TextEditingController usertextedit = TextEditingController();
  TextEditingController passwordtextedit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(opacity: 0.9,
              image: AssetImage("assets/loginBackround.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,

          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                const Text("TODO List ", style: TextStyle(
                    fontSize: 35,
                  color: Colors.white
                ),),
                const Text("Sign in to continue...", style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                ),),
                Center(
                  child: Container(
                    width: 300,
                    child: Image.asset("assets/loginimage.png"),
                  ),
                ),
                Container(height: 20,),
                TextFormField(
                  controller: usertextedit,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.account_circle,color: Colors.white,),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    )
                  ),
                ),
                Container(height: 40,),
                TextFormField(
                  controller: passwordtextedit,
                  obscureText: true,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.lock,color: Colors.white,),
                    labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.white,
                        fontSize: 20
                      )
                  ),
                ),
                Container(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    InkWell(
                      child: Text("Forgot Password?", style: TextStyle(
                          fontSize: 16,
                        color: Colors.white
                      ),),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                      child: Container(width: 300,height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if(usertextedit.text.isNotEmpty && passwordtextedit.text.isNotEmpty)
                            {
                              if(usertextedit.text == "admin" && passwordtextedit.text == "password")
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Username and Password are not correct",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Username and Password can't be empty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }

                          },
                          child: const Text("LOG IN",style: TextStyle(color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              shape: const StadiumBorder()),
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )


      ],
    );
  }
}

