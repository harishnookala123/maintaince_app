import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/complaints.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import 'complaints_completed.dart';
import 'complaints_pending.dart';

class ComplaintsReceived extends StatefulWidget {
  final Users? user;
  final String? apartmentCode;

  ComplaintsReceived({Key? key, this.user, required this.apartmentCode})
      : super(key: key);

  @override
  ComplaintsReceivedState createState() => ComplaintsReceivedState();
}

class ComplaintsReceivedState extends State<ComplaintsReceived> with SingleTickerProviderStateMixin {
   late TabController _tabController; // Using late for non-nullable type

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0099CC),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF003366),
          centerTitle: true,
          title: BasicText(
            title: 'Complaints Box',
            fontSize: 19,
            color: Colors.white,
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelStyle:
            GoogleFonts.abel(fontWeight: FontWeight.w900, fontSize: 17),
            labelColor: Colors.deepOrangeAccent,
            indicatorColor: Colors.pink.shade200,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: BasicText(
                  title: "Pending",
                  fontSize: getFontSize(context, 15),
                ),
              ),
              Tab(
                child: BasicText(
                  title: "Completed",
                  fontSize: getFontSize(context, 15),
                ),
              ),
            ],
            controller: _tabController,
          ), // TabBar
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ComplaintsPending(apartmentCode: widget.apartmentCode),
            ComplaintsCompleted(apartmentCode: widget.apartmentCode),
          ],
        ),
      ),
    );
  }
}
