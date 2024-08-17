import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_utils.dart';
import '../models/task_model.dart';

class ListProvider extends ChangeNotifier{
  //data when changed affect on more than widget
  // function modify data changed
  List <TaskModel> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFirestore() async{
    QuerySnapshot<TaskModel> querySnapshot= await FirebaseUtils.getTasksCollection().get();
    // from querysnapshot to list of tasks
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();

    }).toList();
    //filter tasks based on selected date
    tasksList =tasksList.where((task) {
      if (selectDate.day== task.dateTime.day && selectDate.month== task.dateTime.month && selectDate.year== task.dateTime.year){
        return true;
      }
        return false;

    }).toList();

    //sorting tasks

    tasksList.sort((TaskModel task1 , TaskModel task2 ){
      return task1.dateTime.compareTo(task2.dateTime);

    }

    );

    notifyListeners();
  }
  void changeSelectedDate(DateTime newSelectDate){
    selectDate= newSelectDate;
    getAllTasksFromFirestore();

  }
}