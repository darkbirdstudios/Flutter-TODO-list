


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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Text("TODO List ", style: TextStyle(
                fontSize: 35
            ),),
            const Text("Sign in to continue...", style: TextStyle(
                fontSize: 18,
                color: Colors.grey
            ),),
            const SizedBox(height: 20,),
            TextFormField(
              controller: usertextedit,
              decoration: const InputDecoration(
                labelText: 'Username',

              ),
            ),
            const SizedBox(height: 40,),
            TextFormField(
              controller: passwordtextedit,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                InkWell(
                  child: Text("Forgot Password?", style: TextStyle(
                      fontSize: 16
                  ),),
                )
              ],
            ),
            Expanded(
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
                    child: const Text("LOG IN"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        textStyle: const TextStyle(
                            color: Colors.white,
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
    );
  }
}

