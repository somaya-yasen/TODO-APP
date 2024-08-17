import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_one/app_theme.dart';
import 'package:test_one/models/task_model.dart';

import '../../provider/list_provider.dart';

class TaskDetails extends StatelessWidget {
  TaskModel task;
  TaskDetails ({required this.task});
  late ListProvider listProvider;
  static const routeName = 'taskdetails';
  @override
  Widget build(BuildContext context) {
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(task.dateTime);
    //String dateTime = task.dateTime.toString();
    listProvider = Provider.of<ListProvider> (context);
    listProvider.getAllTasksFromFirestore();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(50),
       padding: EdgeInsets.all(20),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20)),
         color: AppTheme.white,
         ),
       height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.height * 0.75,

        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Edit Task',
                style: Theme.of(context).textTheme.titleLarge,),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: task.title,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: task.description
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: formattedDateTime
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.2),
                ElevatedButton(onPressed: (){
                }
                , child: Text(
                      'Save Changes'
                    ))
              ],
            ),
          ),
        ),
      )
    );
  }
}