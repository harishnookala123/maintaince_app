import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../Co_admin/Views/registration.dart';
import '../Model/adminRegistartion.dart';
import 'addMember.dart';
class DrawerDetails extends StatefulWidget {
  String?adminid;
   DrawerDetails({super.key,this.adminid});

  @override
  State<DrawerDetails> createState() => _DrawerDetailsState();
}

class _DrawerDetailsState extends State<DrawerDetails> {
  var apartId;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.4),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(1.0)
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(2.5),
                        child: Icon(Icons.person_outline,
                            size: 45,
                            color: Colors.green.shade400
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12.4),
                      child:FutureBuilder<Admin?>(
                        future: ApiService().getUserById(widget.adminid!),
                        builder: (context,snap){
                          if(snap.hasData){
                            var admin = snap.data;
                            apartId = admin!.apartId!;
                            return Column(
                              children: [
                                BasicText(
                                  title: "Name :  ${admin.adminname!}",
                                  fontSize: 16,
                                ),
                                const SizedBox(height: 5,),
                                BasicText(
                                  title: "Apart Id :   ${admin.apartId!}",
                                  fontSize: 16,
                                )
                              ],
                            );
                          }return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
          TextButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddMember()));
          } , child:  BasicText(
             title: "Add Member",
            fontSize: 16,
          )),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CoRegistration(
              adminId:widget.adminid,apartId:apartId
            )));
          },
              child: BasicText(
                 title: "Add Co-Admin",
              ))
        ],
      ),
    );
  }
}
