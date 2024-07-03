import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Views/setupblock.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../changeprovider/apartmentdetails.dart';

class BlockName extends StatefulWidget {
   const BlockName({super.key});

  @override
  State<BlockName> createState() => _BlockNameState();
}

class _BlockNameState extends State<BlockName> {
  var blockname = TextEditingController();
  var nooffloors = TextEditingController();
  int? blocks;
//  List blocknames = [];

  @override
  void initState() {
    super.initState();
  }


List value = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Block Set up",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ApartDetails>(
              builder: (context, details, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 12.0 / 5.0,
                  ),
                  itemCount: details.block,
                  itemBuilder: (context, index) {
                    //value.insert(index, 'Setup ${String.fromCharCode(65 + index)}');
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.3),
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                            backgroundColor: Colors.white
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetUpblocks(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: FutureBuilder(
                             future: loadData(index),
                            builder: (context,snap){
                               if(snap.hasData){
                                 var  data = snap.data;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(child:Container(
                                        child: Text(data.toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              letterSpacing: 0.7
                                          ),
                                        ),
                                      ),
                                      ),
                                      Container(
                                        child: const Icon(Icons.check_circle,
                                          color: Colors.green,
                                          size: 27,
                                        ),
                                      )
                                    ],
                                  );
                               }else{
                                 return Text(
                                   'Setup ${String.fromCharCode(65 + index)}',
                                   style: GoogleFonts.poppins(
                                     color: Colors.black,
                                     fontWeight: FontWeight.w500,
                                     fontSize: 16,
                                   ),
                                 );
                               }return Container();
                            },
                          )
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  loadData(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getStringList("blockname");
    print(data);
    var value = data![index];
    return value;
  }
}
