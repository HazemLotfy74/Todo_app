import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Cubit/cubit_cubit.dart';
Widget taskitems(Map model,context)=>Dismissible(

  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    TodoCubit.get(context).deletedata(model['id']);
  },
  background: Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      color: Colors.redAccent,
      child: Icon(Icons.delete,color: Colors.white,size: 50,),
    ),
  ),
  child:   Padding(
    padding:  EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text("${model['time']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),),
          backgroundColor: Color.fromRGBO(16, 145, 145, 57)),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${model['title']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              Text("${model['date']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),),
            ],
          ),
        ),
        SizedBox(width: 20,),
        IconButton(onPressed: (){
          TodoCubit.get(context).update("done", model['id']);
        }, icon: Icon(Icons.check_circle_outline,color: Colors.green,)),
        IconButton(onPressed: (){
          TodoCubit.get(context).update("archive", model['id']);
        }, icon: Icon(Icons.archive,color: Colors.grey,)),

      ],
    ),
  ),
);