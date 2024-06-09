import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminRegistrationModel>(
         builder: (context,register,child){
           return Container(
             margin: const EdgeInsets.all(30),
             child: Text("${register.name} ${register.noOfFlats}"),
           );
         },
      ),
    );
  }
}
