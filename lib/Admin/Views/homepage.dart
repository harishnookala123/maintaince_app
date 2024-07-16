import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/Views/expenserequests.dart';
import 'package:maintaince_app/Admin/Views/users_list.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import '../Model/adminRegistartion.dart';
import '../Model/coadmin.dart';
import 'builddrawer.dart';
import 'coAdmin_list.dart';
import 'flatlist.dart';

class HomePage extends StatefulWidget {
  String? userid;
  Admin? admin;
  HomePage({super.key, this.userid, this.admin});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List values = [
    "Flat list",
    "Coadmin details",
    "Users",
    "Security Details",
    "Expense requests",
    "Complaints",
    "Visitors Info",
    "Emergency"
  ];
  @override
  Widget build(BuildContext context) {
    Admin? admin = widget.admin;
    print(admin!.admin_id);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          backgroundColor: Colors.orangeAccent,
          title: Row(
            children: [
              Text(
                "Welcome ,  ",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 18.5,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${"${admin!.firstName!.toString().toUpperCase()} "}"
                "${admin.lastName.toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 18.5,
                    wordSpacing: 1.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: DrawerHeader(
            child: BuildDrawer(userdetails: admin, userid: widget.userid),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(12.3),
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: values.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 150,
                    mainAxisSpacing: 12.3,
                    crossAxisSpacing: 12.3,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Card(
                        child: Center(
                            child: TextButton(
                             onPressed: () {
                              getNavigate(widget.userid, widget.admin,values[index]);
                             }, child: Text(
                            values[index].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 15.7,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  getNavigate(String? userid, Admin? admin, String? selectedValue) async {
    var apartmentCode = admin!.apartmentCode;
    print(userid);
    if (selectedValue == "Flat list") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          FlatList(apartmentCode: apartmentCode)
      ));
    }
    if (selectedValue == "Users") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          Userlist(apartid: apartmentCode)
      ));
    }
    if (selectedValue == "Expense requests") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          Expenserequests(apartid: apartmentCode)
      ));
    }
    if (selectedValue == "Coadmin details") {
      print(apartmentCode.toString()+"hejhjagdcjagdadaygjaggfjhahjas");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CoAdminlist(apartid: apartmentCode,userid: userid)
      ));
    }
  }

}
