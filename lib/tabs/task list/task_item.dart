import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:test_one/app_theme.dart';
import 'package:test_one/firebase_utils.dart';
import 'package:test_one/models/task_model.dart';
import 'package:test_one/tabs/task%20list/details_task_tab.dart';
import '../../provider/list_provider.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;
  TaskItem ({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  Widget build(BuildContext context) {
    var listProvider = Provider.of <ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
            children:[
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context){
                FirebaseUtils.DeleteTaskFromFireStore(widget.task).timeout(Duration(seconds: 1),
                  onTimeout: (){
                  listProvider.getAllTasksFromFirestore();
                  }
                );
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
      ]
        ),
          child:
          isDone ? _buildDoneWidget() : _buildDefaultWidget(),
      )
    );
  }

  Widget _buildDefaultWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 4,
            margin: EdgeInsets.all(8),
            color: AppTheme.primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskDetails(task: this.widget.task)
                    ));
                },
                child: Text(
                  widget.task.title,
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                widget.task.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 34,
            width: 69,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed:(){
                toggleDoneStatus();
              },
              icon: Icon(
                Icons.check,
                size: 32,
                color: AppTheme.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 4,
            margin: EdgeInsets.all(8),
            color: AppTheme.green,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  widget.task.description,
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 34,
            width: 69,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: (){
                toggleDoneStatus();
                },
                icon: Icon(
                Icons.undo,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleDoneStatus() {
    setState(() {
       isDone = !isDone; // Toggle between the default and done widgets
    });
  }
}