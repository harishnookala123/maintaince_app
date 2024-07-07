import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/Admin/changeprovider/coadminprovider.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';
import 'Admin/Views/adminscreen.dart';
import 'Admin/Views/apart_details.dart';
import 'Admin/Views/registrationsecondpage.dart';
import 'Admin/Views/userdetails.dart';
import 'Co_admin/Views/registration.dart';
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
  String?validateEmail(String? value){
    if(value==null || value.isEmpty){
      return'Please enter  email';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter  Password';
    }
    const String passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';
    final RegExp regex = RegExp(passwordPattern);

    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, lowercase letter, number, and special character';
    }

    return null; // Return null if the password is valid
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
                  //margin: const EdgeInsets.only(bottom: 15.3),
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
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Email',
                              // labelText: 'Enter UserName',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _obscureText,
                            onChanged: (value){
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
                                    _obscureText ? Icons.visibility_off : Icons.visibility
                                ),
                                onPressed: _toggleObscureText,
                              ),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Password',
                              // prefixIcon:  const Icon(Icons.lock),
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child:ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  getPost(emailController.text,
                                      passwordController.text.replaceAll(' ', ''));
                                }
                                // onPressed handler
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 37, vertical: 12),
                                elevation: 4.0, // Adjust padding as needed
                              ),
                              child: BasicText(
                                title: "Login",
                                color: Colors.indigo.shade600,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          status!=null?getText():Container(
                            margin: const EdgeInsets.only(top: 4.3),
                          ),
                          //const SizedBox(height: 20,),
                          Row(
                            children: [
                              const Text(
                                "Don't You have an Account?",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SelectRegister()));
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      )
    ));
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
       'http://192.168.1.7:3000/login',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
     //  var value = Provider.of<CoAdmin>(context, listen: false) ;

         Map<String,dynamic> res = response.data;
         print(res);
         var userid = res["userid"];
         print(userid);
         status =  res["status"];
         if(status == "Login Successful"){
           emailController.clear();
           passwordController.clear();
           var usertype = res["usertype"];
           status = "";
           print(usertype);
           if(usertype=="Owner"||usertype=="Tenant"){
             print(usertype);
             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Userscreen(
               user_id: userid
             )));
           }else if(usertype=="admin"){

            Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) => UserDetails(userid: userid)));
           }
         }
     }
     else {
       setState(() {
         status = response.data;
       });
     }
  }

  getText() {
    print(status);
    return Container(
      margin: const EdgeInsets.only(top: 12.3,bottom: 12.3),
      child: Text(status!,
        style: const TextStyle(color: Colors.red,
            fontSize: 18
        ),
      ),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
