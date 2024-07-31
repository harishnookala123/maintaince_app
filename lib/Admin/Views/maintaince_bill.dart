import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:maintaince_app/Admin/Model/bills.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import '../../styles/basicstyles.dart';
import '../Model/apartmentdetails.dart';

class MaintainceBill extends StatefulWidget {
  final String? apartcode;
  final String? userid;
  Bills? maintaince;
  String? maintainceamount;
  MaintainceBill({
    super.key,
    this.apartcode,
    this.userid,
    this.maintaince,
    this.maintainceamount,
  });

  @override
  State<MaintainceBill> createState() => _MaintainceBillState();
}

class _MaintainceBillState extends State<MaintainceBill> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amount = TextEditingController();
  Future<Bills?>? billsFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    billsFuture = ApiService().getDefaultAmount(widget.apartcode);
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Maintaince Bill',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF003366),
        elevation: 0,
      ),
      body: Container(
        child: FutureBuilder<Bills?>(
          future: billsFuture,
          builder: (context,snap){
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.purple),
              );
            }
            else if (!snap.hasData || snap.data == null) {
              return buildForm();
            }
            else if(snap.hasData){
              var bills = snap.data;
              return Container(
                child: buildDetailsView(bills),
              );
            }

            return Container();
          },
        ),
      )
    );
  }

   postData(String? userid, String? apartcode) async {
    String maintainceamount = amount.text.replaceAll(",", "");

    var value = await ApiService().getApartmentDetails(apartcode);
    if (value != null && value.isNotEmpty) {
      Map<String, dynamic> data = {
        "apartment_name": value[0].apartmentName,
        "apartment_code": value[0].apartmentCode,
        "admin_id": userid,
        "amount": int.parse(maintainceamount),
        "date": DateTime.now().toString(),
      };
      amount.clear();
      await ApiService().setDefaultmaintainceAmount(data);
    }
  }

  String getDate(String? maintenanceDate) {
    DateTime utcDateTime = DateTime.parse(maintenanceDate!);
    DateTime localDateTime = utcDateTime.toLocal();
    return DateFormat('yyyy-MM-dd').format(localDateTime);
  }

  Widget buildForm() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Enter Maintenance Bill Amount",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.pink.shade400,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                controller: amount,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.3),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.red, width: 1.9),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                     var data =  postData(widget.userid, widget.apartcode);
                     Future.delayed(const Duration(milliseconds: 20), () {
                       Navigator.pop(context);
                     });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade300,
                  minimumSize: const Size(120, 50),
                  textStyle: GoogleFonts.acme(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsView(Bills? bills) {
    return Container(
      alignment: Alignment.topLeft,
      height: MediaQuery.of(context).size.height/3.5,
        child: FutureBuilder<List<ApartmentDetails>?>(
            future: ApiService().getApartmentDetails(widget.apartcode),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.purple,
                );
              } else if (snapshot.hasData) {
                var data = snapshot.data;
                return Container(
                  margin: const EdgeInsets.all(17.4),
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.all(12.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Apartment name: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                data![0].apartmentName!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              const Text(
                                "Maintenance Amount: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                bills!.maintenance_amount.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),

                          Row(
                            children: [
                              const Text(
                                "Generate Date: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                getDate(bills.generate_date)!,
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(120, 40),
                                backgroundColor: Colors.purple,
                              ),
                              onPressed: () {},
                              child: BasicText(
                                title: "Edit",
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }));
  }
}
