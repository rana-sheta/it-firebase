import 'package:dio/dio.dart';
import 'package:task/models/todoModle.dart';

class Services{
  String url="https://jsonplaceholder.typicode.com/todos";

 Future<List<Model>> getTodo() async {
    List<Model> todo=[];
      Response response=await Dio().get(url);
      var data=response.data;
      data.forEach((i){
        Model m=Model.fromJson(i);
        todo.add(m);
    });
    return todo;

  }
}