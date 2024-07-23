import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:intl/intl.dart';
import '../../styles/basicstyles.dart';

class MaintainceBill extends StatefulWidget {
  String? apartcode;
  String? userid;
  MaintainceBill({super.key, this.apartcode, this.userid});

  @override
  State<MaintainceBill> createState() => _MaintainceBillState();
}

class _MaintainceBillState extends State<MaintainceBill> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  String? selectedvalue;

  @override
  void initState() {
    super.initState();
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
        title: Text(
          'Maintaince Bill',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500,
          color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<String>?>(
                future: ApiService().getBlockName(widget.apartcode),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String>? blocknames = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Select Block",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink.shade400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: DropdownButtonFormField2<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a block';
                              }
                              return null;
                            },
                            value: selectedvalue,
                            items: blocknames!
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedvalue = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Select Block',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
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
                      borderSide: const BorderSide(color: Colors.black, width: 1.3),
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
          ),
        ),
      ),
    );
  }

  void postData(String? userid, String? apartcode) async {
    String maintainceamount = amount.text.replaceAll(",", "");

     var value = await ApiService().getApartmentDetails(apartcode);
   Map<String,dynamic>data = {
     "apartment_name":value![0].apartmentName,
     "apartment_code": value[0].apartmentCode,
     "block_name" : selectedvalue,
     "admin_id" : userid,
     "amount" : int.parse(maintainceamount),
     "date" : DateTime.now().toString(),
    };
     amount.clear();
     ApiService().maintainceAmount();
   }
}
