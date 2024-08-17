import 'package:flutter/material.dart';
import 'package:test_one/tabs/task%20list/add_task_bottom_sheet.dart';
import 'package:test_one/tabs/task%20list/tasks_tab.dart';
import 'package:test_one/tabs/settings/settings_tab.dart';
import 'app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [Tasks(), SettingsTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          textAlign: TextAlign.left,
        ),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        padding: EdgeInsets.all(7),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 32,
                ),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 32,
                ),
                label: 'Settings',
              ),
            ]),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(6),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(context: context,
             builder: (_)=>AddTaskBottomSheet());
          },
          child: Icon(
            Icons.add,
            size: 32, 
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
