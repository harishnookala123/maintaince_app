
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import '../changeprovider/api.dart';
import 'coAdminDetails.dart';
import 'flatlist.dart';
class AdminScreen extends StatefulWidget {
  String? userid;
  AdminScreen({super.key, this.userid});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
   void initState() {
    getDetails();
    // TODO: implement initState
    super.initState();
  }
AdminRegistrationModel? adminRegistrationModel = AdminRegistrationModel();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/7.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
         centerTitle: true,
          title: const Column(
            children: [
             // SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Apartment Name',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                '20,000',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        drawer: const Drawer(
            //backgroundColor: Colors.black,
        ),
       // backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          children: [
            FutureBuilder<Admin?>(
                future: ApiService().getUserById(widget.userid!),
                builder:(context,snap){
               if(snap.hasData){
                 var value = snap.data;
                 return  Container(
                   margin: const EdgeInsets.all(15.3),
                   child: GridView.builder(
                     shrinkWrap: true,
                     physics: const ScrollPhysics(),
                     gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2, // Number of columns
                         mainAxisSpacing: 10,
                         crossAxisSpacing: 13,
                         mainAxisExtent: height,
                         childAspectRatio: 12
                     ),
                     itemCount: 10, // Number of items in the grid
                     itemBuilder: (context, index) {
                       return GridItem(index: index,id:widget.userid,adminvalues:value);
                     },
                   ),
                 );
               }return Container();
            })
          ],
        ),
      ),
    );
  }

  getDetails() async {
    print("Harei");
    final apiService = ApiService();
    final fetchedUser = await apiService.getUserById(widget.userid!);
    return fetchedUser;
  }

}

class GridItem extends StatefulWidget {
  final int index;
  String? id;
  Admin? adminvalues;
   GridItem({super.key, required this.index,this.id,this.adminvalues });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  final List<String> names = [
    'Flat List',
    'Co-Admin',
    'Users',
    'Security Details',
    'Expense Request',
    'Complaints',
    'Visitor Info',
    'Reports',
    'Announcements',
    'Emergency'
  ];
 @override
   void initState() {
   // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:  InkWell(
        onTap: (){
          getNavigate(widget.index,widget.adminvalues);
        },
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.deepOrange.shade100,
          // color: Colors.orange.shade300,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: BasicText(
              title: names[widget.index],
              fontSize: 15,
            )
          ),
        ),
      ),
    );
  }


  getNavigate(int index, Admin? adminvalues) async {
   var flats = adminvalues!.noOfFlats;
   var admindetails = adminvalues;
     if(index==0){
       Navigator.push(context, MaterialPageRoute(builder:
           (context)=> FlatList(noOfFlats: flats, adminvalues:admindetails)));
     }else if(index==1){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CoAdminDetails()));
     }
   }
}
