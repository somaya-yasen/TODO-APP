import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_one/app_theme.dart';
import 'package:test_one/auth/register_screen.dart';
import 'package:test_one/auth/text_form_field.dart';
import 'package:test_one/dialog_show.dart';

import '../home_screen.dart';

class LoginSreen extends StatelessWidget {
  static const String routeName = 'login_screen';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                'Login',
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Welcome Back !',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: () {
                              login(context);
                            },
                            child: Text('Login')),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            'OR Create Account',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))
                    ]),
              ),
            ))
      ],
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
        // login
      //show loading
      DialogUtils.showLoading(context: context, message: 'loading...');

        try {
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context, message: 'login success',
              title: 'success',
              posActionName: 'ok',
              posAction: (){
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }
          );
          print(credential.user?.uid??" ");
        }
        on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showMessage(context: context, message: 'No user found for that email.');
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showMessage(context: context, message: 'No user found for that email.');
            print('Wrong password provided for that user.');
          }
        } catch (e) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context, message: e.toString());
          print(e);
        }

      }
    }
  }

