import 'package:flutter/material.dart';
import 'package:test_one/app_theme.dart';

typedef myValidator = String? Function(String?);
// or
// String? Function(String?) validator;

class CustomTextFormField extends StatelessWidget {
  String label;
  myValidator validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;
  CustomTextFormField ({required this.label, required this.validator,
   this.keyboardType= TextInputType.text, required this.controller, this.obscureText = false
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: AppTheme.primaryColor
              ),
            ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: AppTheme.primaryColor
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: AppTheme.red
            ),
          ),
          focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: AppTheme.red,
                width: 3
            ),
          ),
        ),
        validator: validator,
        keyboardType:keyboardType ,
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }

}
