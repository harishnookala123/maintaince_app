import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import '../Model/usermodel.dart';

class ShowingFlatList extends StatefulWidget {
  String? blockname;
  String? apartmentcode;

  ShowingFlatList({super.key, this.blockname, this.apartmentcode});

  @override
  State<ShowingFlatList> createState() => _ShowingFlatListState();
}

class _ShowingFlatListState extends State<ShowingFlatList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: ApiService().getFlats(widget.apartmentcode, widget.blockname),
      builder: (context, snap) {
        if (snap.hasData) {
          var flats = snap.data;
          return FutureBuilder<List<Users>?>(
            future: ApiService().getUsers(widget.apartmentcode!, "Approved", widget.blockname),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var approved = snapshot.data;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 12.3, right: 12.3),
                    child: GridView.builder(
                      physics: const ScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.3,
                        mainAxisExtent: 120,
                      ),
                      shrinkWrap: true,
                      itemCount: flats!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 2.0,
                            color: getDetails(approved, flats[index]) == flats[index]
                                ? getUsertype(approved, flats[index]) == "Owner"
                                ? Colors.green
                                : Colors.orange
                                : Colors.white,
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  flats[index],
                                  style: GoogleFonts.acme(
                                    fontSize: 18,
                                    color: getDetails(approved, flats[index])
                                        == flats[index]?Colors.white:Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Text(
                                  'Harish',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),),
                              ],
                            )
                        );
                      },
                    ),
                  ),
                );
              }
              return Container();
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      },
    );
  }

  List getData(List<Users>? approved) {
    List flats = [];
    for (int i = 0; i < approved!.length; i++) {
      flats.add(approved[i].flat_no.toString());
    }
    return flats;
  }

  getDetails(List<Users>? approved, String flat) {
    String? flatnumber = "";
    for (int i = 0; i < approved!.length; i++) {
      if (flat == approved[i].flat_no) {
        flatnumber = approved[i].flat_no;
        return flatnumber;
      }
    }
  }

  getUsertype(List<Users>? approved, String flat) {
    for (int i = 0; i < approved!.length; i++) {
      if (flat == approved[i].flat_no) {
        return approved[i].user_type;
      }
    }
  }
}