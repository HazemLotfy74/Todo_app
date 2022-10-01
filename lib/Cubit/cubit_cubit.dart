import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Screens/archeive.dart';
import 'package:todoapp/Screens/done.dart';
import 'package:todoapp/Screens/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/constants.dart';

part 'cubit_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(InitialState());

  static TodoCubit get(context)=>BlocProvider.of(context);

  List<Map> tasks=[];
  List<Map> done=[];
  List<Map> archived=[];



  int currentindex = 0;
  bool? status;


  List<Widget> Screens=[
    Tasks(),
    Done(),
    Archeive()
  ];

  void changeindex (int index){
    currentindex=index;
    emit(Bottomnavbarchange());
  }

  void create(){
     openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database, version) {
        database.execute('create table tasks('
            'id integer primary key,'
            'title text,'
            'date text,'
            'time text,'
            'status text)'
        ).then((value) {print("database created");}).catchError((onError){print("error when create table");});
      },
      onOpen: (databse){
        getdata(databse);
        print("database opened");
      },

    ).then((value) {
      data=value;
      emit(Createdatabase());

     });
  }
   getdata(Database data){
    tasks=[];
    done=[];
    archived=[];
     data.rawQuery('select * from tasks').then((value) {
       value.forEach((element) {
         if(element['status']=='new'){tasks.add(element);}
         else if(element['status']=='done'){done.add(element);status=false;}
         else {archived.add(element);status=true;}
         emit(Getdata());
       });
     });
    
  }
   insert({required String title,required String time,required String date})async {
     data!.transaction((txn) async {
       txn.rawInsert(
           'insert into tasks(title,date,time,status) values("$title","$time","$date","new")')
           .then((value) {
         print("$value inserted successfully");
         emit(Insertdatabase());
         getdata(data!);
         emit(Getdata());
       });
     }).catchError((error) {
       print("error when insert");
     });
   }

  void update(String status , int id){
    data!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
     ['$status', id]).then((value) {
       print("Updated successfully");
       getdata(data!);
       emit(Updatedata());
    });

  }
  void deletedata(int id){
    data!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      print("Deleted");
      getdata(data!);
      emit(Deletestate());
    });
  }

  bool sheetshown = false;
  IconData button = Icons.edit;

  void changeiconsheet (bool show , IconData icon){
    sheetshown=show;
    button=icon;
    emit(Changeiconbutton());
  }
}
