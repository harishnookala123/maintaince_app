import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/bills.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:intl/intl.dart';
import 'package:maintaince_app/User/Model/maintaince_bill.dart';
import '../../styles/basicstyles.dart';
import '../Model/apartmentdetails.dart';

class MaintainceBill extends StatefulWidget {
  String? apartcode;
  String? userid;
  Bills? bills;
  MaintainceBill({super.key, this.apartcode, this.userid, this.bills});

  @override
  State<MaintainceBill> createState() => _MaintainceBillState();
}

class _MaintainceBillState extends State<MaintainceBill> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  String? selectedvalue;
  Future<Bills?>? bills;
  @override
  void initState() {
    bills = ApiService().getDefaultAmount(widget.apartcode);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintaince Bill',
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<Bills?>(
            future: bills,
            builder: (context, snap) {
              if (snap.hasData) {
                var bills = snap.data;
                var amount = bills!.maintenance_amount.toString();
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<List<ApartmentDetails>?>(
                        future:
                            ApiService().getApartmentDetails(widget.apartcode),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return Container(
                                margin: const EdgeInsets.all(17.4),
                                child: Card(
                                    child: Container(
                                  margin: const EdgeInsets.all(12.5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Apartment name :- ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            data![0].apartmentName!,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Maintaince Amount :- ",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            bills.maintenance_amount.toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Generate Date : - ",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            getDate(bills.generate_date)!,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(120, 40),
                                              backgroundColor: Colors.purple),
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
                                )));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return buildForm();
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        }),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void postData(String? userid, String? apartcode) async {
    String maintainceamount = amount.text.replaceAll(",", "");

    var value = await ApiService().getApartmentDetails(apartcode);
    Map<String, dynamic> data = {
      "apartment_name": value![0].apartmentName,
      "apartment_code": value[0].apartmentCode,
      "admin_id": userid,
      "amount": int.parse(maintainceamount),
      "date": DateTime.now().toString(),
    };
    amount.clear();
    ApiService().setDefaultmaintainceAmount(data);
  }

  String? getDate(String? maintenanceDate) {
    String? dateTime = maintenanceDate;
    DateTime utcDateTime = DateTime.parse(dateTime!);

    // Convert UTC to local time
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the local date-time
    String formattedDate = DateFormat('yyyy-MM-dd').format(localDateTime);
    return formattedDate;
  }

  buildForm() {
    return Form(
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    postData(widget.userid, widget.apartcode);
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
        ));
  }
}
