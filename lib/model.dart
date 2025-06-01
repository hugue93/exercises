import 'package:flutter/material.dart';

class users_model{
  String ?id;
  String usernme;
  String password;

  users_model({required this.usernme,required this.password, this.id});

factory users_model.fromJson(Map<String,dynamic>json,String id){
  return users_model(usernme: json['username'], password: json['password'], id: id);
}

Map<String,dynamic>toJson()=>{
  'username':usernme,
  'password':password
};


}