import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/Cubit/cubit_cubit.dart';
import 'package:todoapp/models/listview.dart';

class Tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
          condition:TodoCubit.get(context).tasks.length>0 ,
          builder: (context) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return taskitems(TodoCubit.get(context).tasks[index],context);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 2.5,
                      color: Colors.grey[200],
                    ),
                  );
                },
                itemCount:TodoCubit.get(context).tasks.length

            );
          },
          fallback:(context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.list,size: 100,color: Colors.grey,),
                  Text("No Tasks Yet",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 50),)
                ],
              ),
            );
          },
    );
  },
);
  }
}
