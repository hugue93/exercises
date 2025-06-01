import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercises/model.dart';
import 'package:exercises/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget{
  final user;
  const login({super.key, required this.user});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController username=new TextEditingController();
  TextEditingController paassword= new TextEditingController();
  bool loading=false;
  final _formkey=GlobalKey<FormState>();



  Future <DocumentReference> login_process ({required String username, required String password,  required BuildContext context,users_model? users} ) async{
    setState(() {
      loading=true;
    });
   return await FirebaseFirestore.instance.collection('users').add(users!.toJson()).then((e){
      return e;
    });
  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.user),),
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.only(left: 50.0,right:50.0),
      child: Form(
        key: _formkey,
        child: Column(
          spacing: 30.0,
          children: [
          Container(child: Text('Login Form',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
          TextFormField(
            controller: username,
            decoration: InputDecoration(border: OutlineInputBorder(),
             hint: Text('Enter username')
            ),
            validator: (value) {
              if(value==null || !value.contains('@')){
                return 'Username does not contain @';
              }
              return null;
            },
            
          ),
          TextFormField(
            controller: paassword,
          
            decoration: InputDecoration(border: OutlineInputBorder(),
            hint: Text('Enter Password')
            ),
            validator: (value) {
        if(value.toString().length>5){
                return 'password length should be 5 character';
              }
              return null;
            },
          ),
          Container(width: 300.0,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            
            onPressed: (){
              if(_formkey.currentState!.validate()){
                users_model userss=users_model(usernme: username.text, password: paassword.text);
login_process(username: username.text, password: paassword.text,context: context,users: userss).then((v){
      setState(() {
        loading=false;
      
      });
      username.clear();
      paassword.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data posted successfully with id: ${v.id}')));
        Navigator.push(context,MaterialPageRoute(builder: (context)=>users()));
      }).catchError((v){
        print(v.toString());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data failed to be posted successfully ${v}')));

      });
              }
              }, 
          child: loading?SizedBox(height: 10,width: 10,child: CircularProgressIndicator(color: Colors.white,),):Text(' Login',style: TextStyle(color: Colors.white),)),
          )
        
        
        ],),
      ),
    )),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}