import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Constants/constants.dart';

Future insert({required String title,required String time,required String date})async {
return await data!.transaction((txn) async{
   await txn.rawInsert('insert into tasks(title,date,time,status) values("$title","$time","$date","new")').then((value)
  {print("$value inserted successfully");}).catchError((error)
  {print("error when insert");});
});
}
Future getdata(Database data)async{
  return  await data.rawQuery('select * from tasks');
}


void update(){

}
void delete(){

}