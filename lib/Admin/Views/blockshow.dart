import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/apartmentdetails.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';
class Blockshow extends StatefulWidget {
  List<String>? blocks;
  String? blockname;
   Blockshow({super.key, this.blocks,this.blockname });

  @override
  State<Blockshow> createState() => _BlockshowState();
}

class _BlockshowState extends State<Blockshow> {
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
                          print(apart.apartCode);
                       },
                       child: BasicText(
                         title: "Save",
                         fontSize: 17,
                         color: Colors.white,
                       ))
                 ],
               )
           );
         },
      )
    );
  }
}
