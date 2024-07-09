import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';

import '../Model/usermodel.dart';
class ShowingFlatlist extends StatefulWidget {
  String? blockname;
  String? apartmentcode;
   ShowingFlatlist({super.key,this.blockname,this.apartmentcode });

  @override
  State<ShowingFlatlist> createState() => _ShowingFlatListState();
}

class _ShowingFlatListState extends State<ShowingFlatlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          FutureBuilder<List<String>?>(
              future: ApiService().getFlats(widget.apartmentcode, widget.blockname),
              builder: (context,snap){
                if(snap.hasData){
                  var flats = snap.data;
                  return FutureBuilder<List<Users>?>(
                      future:ApiService().getUsers(widget.apartmentcode!, "Approved", widget.blockname),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          var approved = snapshot.data;
                          return Container(
                            margin: const EdgeInsets.only(left: 12.3,right: 12.3),
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4
                                ),
                                shrinkWrap: true,
                                itemCount: flats!.length,
                                itemBuilder:(context,index){
                                  getData(approved);
                                  return Card(
                                    elevation: 2.0,
                                    color: getDetails(approved,flats[index])==flats[index]?
                                        getUsertype(approved,flats[index])=="Owner"?Colors.green:Colors.yellow:
                                    Colors.white,
                                    child: Container(
                                      child: Center(child: Text(flats[index])),
                                    ),
                                  );
                                } ),
                          );

                        }return Container();
                      });
                }return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                );
              }
          )
        ],
      ),
    );
  }

  List getData(List<Users>? approved) {
   List flats = [];
    for(int i=0;i<approved!.length;i++){
      flats.add(approved[i].flat_no.toString());
    }
    return flats;
  }

  getDetails(List<Users>? approved, String flat) {
    String? flatnumber = "";
    for(int i =0;i<approved!.length;i++){
      if(flat==approved[i].flat_no){
        flatnumber = approved[i].flat_no;
        return flatnumber;
      }
    }
  }

  getUsertype(List<Users>? approved, String flat) {
    for(int i =0;i<approved!.length;i++){
      if(flat == approved[i].flat_no){
        return approved[i].user_type;
      }
    }
  }
}
