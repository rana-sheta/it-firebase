
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../models/todoModle.dart';
import '../../services/userService.drt.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial()){
    getTodo();
  }

  List<Model> todo=[];

  getTodo() async {
    try {
      emit(UsersLoading());
      todo = await Services().getTodo();
      emit(UsersSucess());
    }   catch (e) {
      print(e.toString());
      emit(UsersError());
    }

  }
}
