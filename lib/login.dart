import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'Admin/Model/adminRegistartion.dart';
import 'Admin/Views/homepage.dart';
import 'User/Views/homescreen.dart';
import 'mainScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _obscureText = true;
  var formKey = GlobalKey<FormState>();
  String? status;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';
    final RegExp regex = RegExp(passwordPattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, lowercase letter, number, and special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImage(
        child: SizedBox(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: BasicText(
                      title: "Login Page",
                      color: Colors.indigo.shade600,
                      fontSize: 19,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12.3),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: _obscureText,
                            onChanged: (value) {
                              passwordController.value = passwordController.value.copyWith(
                                text: value.replaceAll(' ', ''),
                                selection: TextSelection.collapsed(offset: value.length),
                              );
                            },
                            controller: passwordController,
                            validator: validatePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  size: 20,
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: _toggleObscureText,
                              ),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Password',
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    getPost(
                                      emailController.text,
                                      passwordController.text.replaceAll(' ', ''),
                                    );
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 37,
                                  vertical: 12,
                                ),
                                elevation: 8.0,
                              ),
                              child: BasicText(
                                title: "Login",
                                color: Colors.indigo.shade600,
                                fontSize: getFontSize(context, 18),
                              ),
                            ),
                          ),
                          status != null
                              ? getText()
                              : Container(
                            margin: const EdgeInsets.only(top: 4.3),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.5),
                            child: Wrap(
                              children: [
                               Row(
                                children: [
                                   Text(
                                    "Don't You have an Account?",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: getFontSize(context,15)),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const SelectRegister(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.red.shade900,
                                          fontSize: getFontSize(context, 18),
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.red.shade900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),],),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPost(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    String passwordvalue = password.replaceAll(RegExp(r"\s\b|\b\s"), "");
    var data = json.encode({
      "email": email.trim(),
      "password": passwordvalue,
    });
    var dio = Dio();
    var response = await dio.request(
      '$baseUrl/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    setState(()  async {
      if (response.statusCode == 200) {
        Map<String, dynamic> res = response.data;
        var userid = res["userid"];
        status = res["status"];
        if (status == "Login Successful") {
          var usertype = res["usertype"];
          if (usertype == "Owner" || usertype == "Tenant") {
            ApiService.userData(userid).then((users) {
              if(users!.status == "Pending"){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Userscreen(user_id: userid),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomeScreen(user:users),
                  ),
                );
              }
            });
          } else if (usertype == "admin" || usertype =="Co-admin") {
            if (usertype== "admin" ){
             Admin?admin = await ApiService().getAdminById(userid);
              getNavigate(admin, userid,usertype);
            } else{
              Admin? coAdmin = await ApiService().coAdminById(userid);
              getNavigate(coAdmin, userid, usertype);
            }
          }
        }
      } else {
        status = response.data["status"];
      }

    });
  }

  getText() {
    return Container(
      margin: const EdgeInsets.only(top: 12.3, bottom: 12.3),
      child: Text(
        status!,
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getNavigate(Admin? admin, userid, usertype) {
    // print(admin!.ad.toString() + "Harish is login");
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userid: userid,
          admin: admin,
          usertype:usertype,
        ),
      ),
    );
  }

}
