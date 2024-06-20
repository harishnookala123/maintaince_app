import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../Model/usermodel.dart';
import 'addMember.dart';

class UserDetails extends StatefulWidget {
  String? apartid;
  UserDetails({super.key, this.apartid});
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:  TabBar(
            tabs: [
              Tab(child: BasicText(
                title: "Pending",
                fontSize: 16,
              )),
              Tab(
                child: BasicText(
                  title: "User info",
                  fontSize: 16,
                ),
              ),
              Tab(
                child: BasicText(
                  fontSize: 16,
                  title: "Rejected",
                ),
              ),
            ],
          ), // TabBar
          title: const Text('User Details'),
          backgroundColor: Colors.orangeAccent.shade100,
          centerTitle: true,
          //backgroundColor: Colors.green,
        ), // AppBar,
        body: const TabBarView(
          children: [
            Text("Hai"),
            Text("dgd"),
            Text("Rejected")
          ],
        ),

      ),
    ));
  }
}
