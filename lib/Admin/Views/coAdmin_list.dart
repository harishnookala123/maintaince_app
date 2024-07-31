import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/apartmentdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'dart:convert';

import '../../styles/basicstyles.dart';
import '../Model/coadmin.dart';

class CoAdminlist extends StatefulWidget {
  final String? apartid;
  final String? userid;
  const CoAdminlist({super.key, this.apartid, this.userid});

  @override
  State<CoAdminlist> createState() => _CoAdminlistState();
}

class _CoAdminlistState extends State<CoAdminlist> {
  Future<List<CoAdmin>>? futureCoAdmins;

  @override
  void initState() {
    super.initState();
    futureCoAdmins = ApiService().fetchCoAdmins(widget.apartid!, widget.userid!);
  }


  @override
  Widget build(BuildContext context) {
    print(widget.userid);
    return Scaffold(
      backgroundColor: const Color(0xFF0099CC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF003366),
        title: Text(
          "CoAdmin List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366), // Darker blue color at the top
              Color(0xFF0099CC), // Lighter blue color at the bottom
            ],
          ),
        ),
        child: FutureBuilder<List<CoAdmin>>(
          future: futureCoAdmins,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: BasicText(
                  title: "No CoAdmin Found",
                  color: Colors.black,
                  fontSize: 14.5,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildCard(snapshot.data![index]);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildCard(CoAdmin coAdmin) {
    return Card(
      elevation: 3.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<ApartmentDetails>?>(
                future: ApiService().getApartmentDetails(coAdmin.apartment_code),
                builder: (context,snap){
                  if(snap.hasData){
                    var apartmentdetails = snap.data;
                    return Container(
                      child:  Text(
                        "ApartmentName: ${apartmentdetails![0].apartmentName}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }return Container();
                }),
            const SizedBox(height: 8),
            Text(
              "Name: ${coAdmin.first_name}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),

            Text(
              "Phone: ${coAdmin.phone}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              "Email: ${coAdmin.email}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

}
