import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercises/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class users extends StatefulWidget{
  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users'),actions: [IconButton(onPressed: (){}, icon: Icon(Icons.refresh))],),
      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
       builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return Center(child: Text('Something went wrong!!'),);
        }
        if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
 return Center(child: Text('No users insterted!!'),);
        }
        List<users_model>userspeople=snapshot.data!.docs.map((doc){
          return users_model.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
        return ListView.builder(
          itemCount: userspeople.length,
          itemBuilder: (context, int index){
            final user=userspeople[index];
            return ListTile(
              leading: CircleAvatar(child: Text(user.usernme[0]),),
              title: Text(user.usernme),
              subtitle: Text(user.password),
              trailing: IconButton(onPressed: ()=>FirebaseFirestore.instance.collection('users').doc(user.id).delete(), icon: Icon(Icons.delete)),
            );

        });
       })
      
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}