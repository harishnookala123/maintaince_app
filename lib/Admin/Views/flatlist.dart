import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
class FlatList extends StatefulWidget {
  int?noOfFlats;
  Admin? adminvalues;
   FlatList({super.key,this.noOfFlats,this.adminvalues  });
  @override
  State<FlatList> createState() => _FlatListState();
}

class _FlatListState extends State<FlatList> {
  @override
  Widget build(BuildContext context) {
    Admin?useradmin = widget.adminvalues;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40,),
          BasicText(
            title: useradmin!.apartname,
            color: Colors.purple,
            fontSize: 18,
          ),
          Expanded(child:GridView.builder(
              physics: const ScrollPhysics(),
              itemCount: widget.noOfFlats,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 2.3,
                // childAspectRatio: 12.0
              ),
              itemBuilder: (context,index){
                return Container(
                  margin: const EdgeInsets.all(12.3),
                  width: 200.0,  // Specify the width of the container
                  height: 150.0, // Specify the height of the container
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black87, // Border color
                      width: 1.0,         // Border width
                    ),
                    borderRadius: BorderRadius.circular(15.0), // Optional: for rounded corners
                  ),
                child: Center(child: TextButton(
                  style: TextButton.styleFrom(

                  ),
                  child: Text(index.toString()),
                  onPressed: (){

                  },
                )),
                );
              })
          )
        ],
      ),
    );

  }
}
