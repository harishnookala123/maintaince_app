
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          tabs: const [
            Tab(child: Text("Maintenance Bill"),

            ),
            Tab(child: Text("History"),),
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
