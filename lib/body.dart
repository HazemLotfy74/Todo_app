import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/Cubit/cubit_cubit.dart';

class MyHomePage extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  var _formkey = GlobalKey<FormState>();

  /////////// Controller ///////
  var text = TextEditingController();
  var time = TextEditingController();
  var date = TextEditingController();
  var state = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..create(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (BuildContext context, TodoState state) {
          // TODO: implement listener
        },
        builder: (BuildContext context, TodoState state) {
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(title: Text("ToDo App"),backgroundColor: Color.fromRGBO(16, 145, 145, 57)),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.sheetshown) {
                  if (_formkey.currentState!.validate()) {
                    cubit.insert(
                        title: text.text, time: time.text, date: date.text);
                    Navigator.pop(context);
                    cubit.changeiconsheet(false, Icons.add);
                    text.clear();
                    time.clear();
                    date.clear();
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        (contex) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.grey[100],
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: text,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Text must not be empty";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.text_fields),
                                        label: Text("Text title"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        time.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    controller: time,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Time must not be empty";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.watch_later_outlined),
                                        label: Text("Text Time"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        date.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    controller: date,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Date must not be empty";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.calendar_month_outlined),
                                        label: Text("Text Date"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      .closed
                      .then((value) {
                        cubit.changeiconsheet(false, Icons.edit);
                      });
                  cubit.changeiconsheet(true, Icons.add);
                }
              },
              child: Icon(cubit.button),
              backgroundColor: Color.fromRGBO(16, 145, 145, 57),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 15,
              selectedIconTheme: IconThemeData(size: 30),
              elevation: 10,
              selectedItemColor: Color.fromRGBO(16, 145, 145, 57),
              currentIndex: cubit.currentindex,
              onTap: (value) {
                cubit.changeindex(value);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu,color: Color.fromRGBO(16, 145, 145, 57)), label:"Text",),
                BottomNavigationBarItem(

                    icon: Icon(Icons.check_circle_outline,color: Colors.green,), label: "Done",backgroundColor: Colors.green),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined,color: Colors.grey,), label: "Archeived",

                )
              ],
            ),
            body: cubit.Screens[cubit.currentindex],
          );
        },
      ),
    );
  }
}
