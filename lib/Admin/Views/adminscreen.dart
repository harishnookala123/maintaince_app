import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/Admin/Views/userdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import '../changeprovider/api.dart';
import 'coAdminDetails.dart';
import 'drawerdetails.dart';
import 'flatlist.dart';

class AdminScreen extends StatefulWidget {
  String? userid;
  AdminScreen({super.key, this.userid});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Map<String,dynamic>? data;
  @override
   void initState() {
    getDetails();
    super.initState();
  }
AdminRegistrationModel? adminRegistrationModel = AdminRegistrationModel();
  @override
  Widget build(BuildContext context) {
    print(widget.userid);
    var height = MediaQuery.of(context).size.height/7.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
         centerTitle: true,
          title:  Column(
            children: [
             // SizedBox(height: 15),
               FutureBuilder<Admin?>(
                   future:ApiService().getUserById(widget.userid!) ,
                   builder: (context,snap){
                     if(snap.hasData){
                       var data = snap.data;
                       return Container(
                         margin: const EdgeInsets.only(left: 12.3,),
                         child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                           SizedBox(
                             child: BasicText(
                               fontSize: 19.2,
                              title: data!.apartname,
                              color: Colors.green,),
                           )
                           ],
                         ),
                       );
                     }return Container();
                   }),
            ],
          ),
        ),
        drawer: const Drawer(
          child: DrawerDetails(),
            //backgroundColor: Colors.black,
        ),
       // backgroundColor: Colors.white,
        body: FutureBuilder<Admin?>(
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
               }return const Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 //crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   CircularProgressIndicator(
                     color: Colors.green,
                   )
                 ],
               );
            })
      ),
    );
  }

  getDetails() async {
    final apiService = ApiService();
    final fetchedUser = await apiService.getUserById(widget.userid!);
    print(fetchedUser!.apartname);
    data = {
      "apartname": fetchedUser.apartname
    };


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
     }else if(index==2){
       var adminvalues =  await ApiService().getUserById(widget.id!);
        var apartid = adminvalues!.apartId;
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetails(
         apartid:apartid
       )));
     }
   }
}
