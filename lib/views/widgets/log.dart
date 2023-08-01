import 'dart:html';

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/views/widgets/page1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class log extends StatefulWidget {
  const log({super.key});

  @override
  State<log> createState() => _logState();
}

class _logState extends State<log> {
  final formKey=GlobalKey<FormState>();
  TextEditingController emailControler=TextEditingController();
  TextEditingController passwordControler=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Form   (
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15,),
              Container(
                width: 130
                ,height: 130,
                child:Image.asset("assets/flutterlogo.png"),
                padding: EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: TextFormField(
                  controller: emailControler,
                  decoration: const InputDecoration(
                      labelText:"Email",
                      icon: Icon(Icons.email_outlined)
                  ),
                  validator: (value){
                    if(!RegExp(r'^[a-z,A-Z]+$').hasMatch(value!)&&
                        value!.contains('@gmail.com')){     //////this code mean that 'r' mean string word,,,  ''  mean inside this we but the kind of wha we want ,,, ^ mean the start of the word ,,,, +$ the end
                      return null;
                    }
                    else {
                      return "Enter Correct Email";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: TextFormField(
                    controller:passwordControler,
                    decoration: const InputDecoration(
                        labelText:"password",
                        icon: Icon(Icons.visibility_outlined)
                    ),
                    validator: (value){
                      if(value!.length<8){
                        return "Add valid pass";
                      }
                    }
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80)
                  ),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content:Text('submitting login')),);


                      bool result=await firebaseLogin(emailControler.text, passwordControler.text);
                     if(result) {
                       final SharedPreferences prefs = await SharedPreferences
                           .getInstance();
                       await prefs.setString('email', emailControler.text);

                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) =>
                             pageOne(
                               //email:emailControler.text)),
                             ),),);
                     }
                     else{
                       ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("login faild")));
                     }
                    }
                  },
                  child: Text( "Log in")),
              CupertinoButton(
                  child:Text("Forgot your pass? Tap me",),
                  onPressed:(){
                  }),
              MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  color: Colors.grey,
                  child:Text('Create new Account',style: TextStyle(color: Colors.black87),),
                  onPressed: (){}),
            ],

          ),
        ),
      ),
    );
  }
 Future<bool> firebaseLogin(String email,String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(credential.user !=null){
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
}
