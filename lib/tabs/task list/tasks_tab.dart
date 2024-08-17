import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_one/models/task_model.dart';
import 'package:test_one/tabs/task%20list/task_item.dart';

import '../../provider/list_provider.dart';

class Tasks extends StatefulWidget {
  static const routeName = 'list_screen';
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider> (context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFirestore();
    }
    return Column(
      children: [
        EasyDateTimeLine(
            initialDate: listProvider.selectDate,
          onDateChange: (selectedDate){
              listProvider.changeSelectedDate(selectedDate);
          },
        ),

        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return TaskItem(task: listProvider.tasksList[index],);
            },
          ),
        )
      ],
    );
  }


}