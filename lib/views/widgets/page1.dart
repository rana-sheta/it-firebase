import 'dart:html';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'log.dart';

class pageOne extends StatefulWidget {
 // final String email;
pageOne(
    //{required this.email}
    );
  //const pageOne({super.key});

  @override
  State<pageOne> createState() => _pageOneState();
}

class _pageOneState extends State<pageOne> {
 String email="";

 Future<void> getCachedEmail() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   email = prefs.getString('email')??"--";
   setState(() {
     
   });

 }

 @override
  void initState() {
    super.initState();
    getCachedEmail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page one"),
        automaticallyImplyLeading: false,
        leading:  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
        },),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello \n $email",style: TextStyle(fontSize: 30,color: Colors.teal),),
          ],
        ),
      ),
     // Navigator.of(context).pushNamed("home"),
    );
  }
}


