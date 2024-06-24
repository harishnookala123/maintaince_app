import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Views/pendingrequests.dart';
import 'package:maintaince_app/Admin/Views/rejectedinfo.dart';
import 'package:maintaince_app/Admin/Views/userinfo.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var id = widget.apartid;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          animationDuration: const Duration(seconds: 3),
          length: 3,
          child: Scaffold(
            appBar: AppBar(
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
                  )),
                  Tab(
                    child: BasicText(
                      title: "Approved",
                    ),
                  ),
                  Tab(
                    child: BasicText(
                      title: "Rejected",
                    ),
                  ),
                ],
              ), // TabBar
              backgroundColor: Colors.blue.shade200,
              centerTitle: true,
              //backgroundColor: Colors.green,
            ), // AppBar,
            body: TabBarView(
              children: [
                PendingRequests(apartid: id),
                Userinfo(apartid: id),
                RejectedInfo(apartid: id),
              ],
            ),
          ),
        ));
  }
}
