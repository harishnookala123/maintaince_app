import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/Views/expenserequests.dart';
import 'package:maintaince_app/Admin/Views/users_list.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import '../Model/adminRegistartion.dart';
import '../Model/coadmin.dart';
import 'builddrawer.dart';
import 'coAdmin_list.dart';
import 'complaints_receive.dart';
import 'flatlist.dart';

class HomePage extends StatefulWidget {
  final String? userid;
  final Admin? admin;
  HomePage({super.key, this.userid, this.admin});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List values = [
    "Flat list",
    "Coadmin details",
    "Users",
    "Security Details",
    "Expense requests",
    "Grievance",
    "Visitors Info",
    "Emergency"
  ];

  List<IconData> icons = [
    Icons.apartment,
    Icons.people,
    Icons.person,
    Icons.security,
    Icons.request_page,
    Icons.report_problem,
    Icons.info,
    Icons.warning,
  ];

  @override
  Widget build(BuildContext context) {
    Admin? admin = widget.admin;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 4.0,
          backgroundColor: const Color(0xFF003366),
          title: Row(
            children: [
              Text(
                "Welcome  ",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${admin!.firstName!.toString().toUpperCase()} ",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: screenWidth * 0.047,
                  wordSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: BuildDrawer(userdetails: admin, userid: widget.userid),
        ),
        body: Container(
          margin: const EdgeInsets.all(12.3),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: values.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 12.3,
                  crossAxisSpacing: 12.3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      getNavigate(widget.userid, widget.admin, values[index]);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF0099CC),
                              Color(0xFF214973),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: screenWidth * 0.13,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              values[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getNavigate(String? userid, Admin? admin, String? selectedValue) async {
    var apartmentCode = admin!.apartmentCode;
    if (selectedValue == "Flat list") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlatList(apartmentCode: apartmentCode)));
    }
    if (selectedValue == "Users") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Userlist(apartid: apartmentCode)));
    }
    if (selectedValue == "Expense requests") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Expenserequests(apartid: apartmentCode)));
    }
    if (selectedValue == "Coadmin details") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoAdminlist(apartid: apartmentCode, userid: userid)));
    }
    if (selectedValue == "Grievance") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComplaintsReceived(apartmentCode: widget.admin!.apartmentCode)));
    }
  }
}
