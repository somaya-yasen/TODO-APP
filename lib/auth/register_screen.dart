import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_one/app_theme.dart';
import 'package:test_one/auth/text_form_field.dart';
import 'package:test_one/dialog_show.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerـscreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppTheme.grey,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Create Account',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  CustomTextFormField(
                    label: 'User Name',
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'please enter valid email';
                        }
                        return null;
                      }),
                  CustomTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6 character';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter confirm password';
                      }
                      if (text != passwordController.text) {
                        return 'confirmed password does not match password';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(onPressed:
                        (){
                      register();

                        },
                        child: Text(
                          'Create Account'
                        )),
                  )
                ]),
              ),
            ))
      ],
    );
  }

  void register() async{
    if(
    formKey.currentState?.validate() == true) {
      // register
      //todo: show loading
      DialogUtils.showLoading(context: context, message: 'loading...');

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // todo:hide loading
        // show message for user
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          // todo:hide loading
          // show message for user
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          //todo: hide loading
          // show message for user
        }
      } catch (e) {
        // todo:hide loading
        // show message for user

        print(e);

      }

    }


  }
}
