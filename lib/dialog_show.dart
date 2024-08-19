import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading({required BuildContext context, required String message}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Loading'
              ),
            )
          ]
        ),
      );

        });

  }
  static void hideLoading ({required BuildContext context}){
    Navigator.pop(context);
  }
  static void showMessage ({required BuildContext context , required String message,
    String title= '',
    String? posActionName,
    Function? posAction
  }){
    List <Widget> actions =[];
    if(posActionName != null){
      actions.add(TextButton(
          onPressed: (){
            Navigator.pop(context);
            if(posAction != null){
              posAction.call();
            }
          },
          child: Text (posActionName)));
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(
              message
            ),
            title: Text(
              title
            ),
            actions: [

            ],

          );
        }
    );
  }

}