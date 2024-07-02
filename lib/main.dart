import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/coadminprovider.dart';
import 'package:maintaince_app/splashscreen.dart';
import 'package:provider/provider.dart';
import 'Admin/changeprovider/adminprovider.dart';
import 'Admin/changeprovider/apartmentdetails.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AdminRegistrationModel()),
      ChangeNotifierProvider(create: (context)=> CoAdmin()),
      ChangeNotifierProvider(create: (context)=> Details())
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen()
    );
  }
}


