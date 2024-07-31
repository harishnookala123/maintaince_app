import 'package:flutter/material.dart';
import 'package:maintaince_app/splashscreen.dart';
import 'package:provider/provider.dart';
import 'Admin/changeprovider/adminprovider.dart';
import 'Admin/changeprovider/apartmentdetails.dart';
import 'Admin/changeprovider/userregistration.dart';
import 'login.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AdminRegistrationModel()),
      ChangeNotifierProvider(create: (context)=> ApartDetails()),
      ChangeNotifierProvider(create: (context)=> Userregistration())
    ],
     child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        routes: {
          '/login': (context) => const Login(),
        },
      home: const SplashScreen()
    );
  }
}


