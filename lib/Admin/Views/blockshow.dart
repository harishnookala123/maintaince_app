import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/apartmentdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocknames.dart';
class Blockshow extends StatefulWidget {
  List<String>? blocks;
  String? blockname;
  int? index;
   Blockshow({super.key, this.blocks,this.blockname,this.index,
   });

  @override
  State<Blockshow> createState() => _BlockshowState();
}

class _BlockshowState extends State<Blockshow> {
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    var blocks = widget.blocks;
    return Scaffold(
      appBar: AppBar(
        title: BasicText(
          title: widget.blockname,
        ),
        centerTitle: true ,
      ),
      body: Consumer<ApartDetails>(
         builder: (context,apart,child){
           return Container(
               margin: const EdgeInsets.all(16.5),
               child: Column(
                 children: [
                   Expanded(child:GridView.builder(
                       itemCount: blocks!.length,
                       shrinkWrap: true,
                       physics: const BouncingScrollPhysics(),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 4,
                           mainAxisSpacing: 12.0,
                           crossAxisSpacing: 3.0
                       ),
                       itemBuilder: (context,index){
                         return Container(
                           color: Colors.deepOrange.shade300,
                           child: Column(
                             children: [
                               const SizedBox(height: 15,),
                               Container(
                                 child: Text(blocks[index]),
                               ),
                             ],
                           ),
                         );
                       }),
                   ),
                   ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.purple,
                           minimumSize: Size(120, 45)
                       ),
                       onPressed: (){
                          print(blocks);
                          postApartmentDetails(blocks,apart);
                       },
                       child: BasicText(
                         title: "Save",
                         fontSize: 17,
                         color: Colors.white,
                       )),
                   const SizedBox(height: 20,),
                 ],
               )
           );
         },
      )
    );
  }

   postApartmentDetails(List<String> blocks, ApartDetails apart,) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     final encodedList = json.encode(widget.blockname);
      var data = prefs.getStringList("blockname");
      if(data!=null){
        for(int i=0;i<data.length;i++){
          list.insert(i, data[i]);
        }
        list.add(widget.blockname!);
      }else{
        list.insert(widget.index!, widget.blockname!);
        print(list);
      }
     await prefs.setStringList("blockname",list);
      var remain = prefs.getStringList("blockname");
      Dio dio = Dio();
     var headers = {
       'Content-Type': 'application/json'
     };
     for(int i=0;i<blocks.length;i++){
      Map<String,dynamic> data = {
        "apartment_code":apart.apartCode,
        "apartment_name" :apart.apartName,
        'block_name' : widget.blockname,
        'flat_no' : blocks[i].toString(),
        "address" : "ddg",
      };
      try {
        var response = await dio.request(
          'http://192.168.29.231:3000/saveBlockName',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );
        print('Response status: ${response.statusCode}');
        print('Response data: ${response.data}');
      } catch (e) {
        print('Error: $e');
      }
    }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockName()));

   }




}
