import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/models/todoModle.dart';

import '../cubit/users_cubit.dart';

class nextPage extends StatefulWidget {
  Model model;

  nextPage({
    Key? key,
    required this.model,
  }) : super(key: key);
//  const nextPage({super.key});

  @override
  State<nextPage> createState() => _nextPageState();
}

class _nextPageState extends State<nextPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create:(context)=>UsersCubit(),
        child:BlocConsumer<UsersCubit,UsersState>(
            listener:(context,state){
              if(state is UsersLoading){
                print("Loading");
              }
            },
            builder:(context,state){
              return state is UsersLoading?Center(
                child:CircularProgressIndicator(),):state is UsersSucess?
              ListView.builder(
               // itemCount:wi,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(widget.model.id.toString()),

                  );
                },
              ):
                  Center(
                  child: Text("error")
              //
               );
            }
        ),
      )
    );
  }
}
