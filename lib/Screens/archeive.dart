import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Cubit/cubit_cubit.dart';
import '../models/listview.dart';

class Archeive extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: TodoCubit.get(context).archived.length>0,
          builder: (BuildContext context) { return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return taskitems(TodoCubit.get(context).archived[index],context);
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
              itemCount:TodoCubit.get(context).archived.length

          ); },
          fallback: (BuildContext context) { return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.list,size: 100,color: Colors.grey,),
                Text("No Tasks Yet",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 50),)
              ],
            ),
          ); },


        );
      },
    );
  }
}
