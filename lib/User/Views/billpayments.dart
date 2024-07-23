
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/User/Views/maintaincehistory.dart';

import 'monthbills.dart';
class UserBills extends StatefulWidget {
  String? userid;
   UserBills({super.key, this.userid });
  @override
  State<UserBills> createState() => _UserBillsState();
}

class _UserBillsState extends State<UserBills> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintaince'),
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(child: Text("Maintenance Bill",
             style: GoogleFonts.poppins(
               fontSize: 16.5,
               fontWeight: FontWeight.w500
             ),
            ),

            ),
             Tab(child: Text("History",
              style: GoogleFonts.poppins(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500
              ),
            ),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MaintenanceBill(userid:widget.userid),
          MaintainceHistory(userid:widget.userid,),
        ],
      ),
    );
  }
}
