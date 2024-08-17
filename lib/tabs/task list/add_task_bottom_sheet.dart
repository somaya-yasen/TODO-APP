import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_one/firebase_utils.dart';
import 'package:test_one/models/task_model.dart';
import '../../provider/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late ListProvider listProvider;
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title ='';
  String description ='';

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('Add new task'),
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter title';
                      }
                      return null;
                    },
                    onChanged: (text){
                      title = text;
                    },
                    decoration: InputDecoration(hintText: 'enter task title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 3,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter description';
                      }
                      return null;
                    },
                    onChanged: (text){
                      description = text;
                    },
                    decoration:
                        InputDecoration(hintText: 'enter task description'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Text(
                      'select date',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                        '${selectedDate.day}/ ${selectedDate.month}/${selectedDate.year}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      'submit',

                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      TaskModel task = TaskModel(
          title: title,
          description: description,
          dateTime: selectedDate);

      FirebaseUtils.addTaskToFireStore(task).timeout(Duration(seconds: 1),
      onTimeout :(){
        print('task added sucess');
        listProvider.getAllTasksFromFirestore();
        Navigator.pop(context);
      }
      );


    }
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
