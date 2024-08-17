import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_one/app_theme.dart';
import 'package:test_one/home_screen.dart';
import 'package:test_one/provider/list_provider.dart';
import 'package:test_one/tabs/task%20list/tasks_tab.dart';
import 'package:test_one/tabs/settings/settings_tab.dart';

import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBdPg5TrTAEVLMLsX6lcoE2L0M3G3weOHA',
      appId: 'com.example.test_one', 
      messagingSenderId: '546201027083', 
      projectId: 'todo-app-fb031')
    
  ):
   await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
    create: (context) => ListProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginSreen.routeName,
      routes: {
        HomeScreen.routeName: (_)=> HomeScreen(),
        Tasks.routeName: (_)=> Tasks(),
        SettingsTab.routeName : (_)=> SettingsTab(),
        RegisterScreen.routeName: (_)=> RegisterScreen(),
        LoginSreen.routeName: (_)=>  LoginSreen()



    },
       theme: AppTheme.lightTheme ,
       darkTheme: AppTheme.darkTheme,
       themeMode: ThemeMode.light
    );
  }
}
      