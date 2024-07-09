import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/Admin/Views/userdetails.dart';
class BuildDrawer extends StatefulWidget {
  Admin? userdetails;
  String? userid;
   BuildDrawer({super.key, this.userdetails,this.userid  });

  @override
  State<BuildDrawer> createState() => BuildDrawerState();
}

class BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    Admin?admin = widget.userdetails;

    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 12.4),
                  child: const Icon(Icons.perm_identity_sharp,
                   size: 35,
                  )),
              Text("${admin!.firstName!}  ${admin.lastName}",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.pinkAccent.shade200
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          TextButton(onPressed: (){
            print(widget.userid);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                UserDetails(userid: widget.userid,)));
          }, child:  Text("User Requests",
             style: GoogleFonts.poppins(
               fontSize: 16,
               fontWeight: FontWeight.w500
             ),
          ))
        ],
      ),

    );
  }
}
