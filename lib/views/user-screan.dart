
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/models/todoModle.dart';
import 'package:task/views/cubit/users_cubit.dart';
import 'package:task/views/widgets/next_page.dart';

import '../services/userService.drt.dart';

class Screan extends StatefulWidget {
  const Screan({super.key});

  @override
  State<Screan> createState() => _ScreanState();
}

class _ScreanState extends State<Screan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:BlocProvider(
        create:(context)=>UsersCubit(),
        child:BlocConsumer<UsersCubit,UsersState>(
          listener:(context,state){
            if(state is UsersLoading){
              print("Loaging");
            }
          },
          builder:(context,state){
            return state is UsersLoading?Center(
            child:CircularProgressIndicator(),):state is UsersSucess?
            ListView.builder(
        itemCount:context.watch<UsersCubit>().todo.length,
            itemBuilder: (BuildContext context, int index){
         return ListTile(
         title: Text(context.watch<UsersCubit>().todo[index].title??"--"),


           onTap:(){Navigator.push(context,MaterialPageRoute(
              builder:(context) =>nextPage(model: Model.fromJson(context.watch<UsersCubit>().todo[index] as Map<String, dynamic>),),),);},

      );
       },
       ):Center(
              child: Text("Errrrrror"),
            );
          }
        ),
      )
      );
  }
}
