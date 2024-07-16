import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:intl/intl.dart';
import '../../styles/basicstyles.dart';

class MaintainceBill extends StatefulWidget {
  String? apartcode;
  String?userid;
  MaintainceBill({super.key, this.apartcode,this.userid});

  @override
  State<MaintainceBill> createState() => _MaintainceBillState();
}

class _MaintainceBillState extends State<MaintainceBill> {
  TextEditingController amount = TextEditingController();

  String? selectedvalue;
 @override
  void initState() {
    super.initState();
    amount.addListener(_formatNumber);
 }
  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12.3, left: 16.3),
            child: FutureBuilder<List<String>?>(
              future: ApiService().getBlockName(widget.apartcode),
              builder: (context, snap) {
                if (snap.hasData) {
                  List<String>? blocknames = snap.data;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: BasicText(
                            title: "Select Block : -",
                            fontSize: 16,
                            color: Colors.pinkAccent.shade400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.35,
                          child: DropdownButtonFormField2<String>(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 22),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15.4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.4),
                              ),
                            ),
                            hint: const Text(
                              'Select Block',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: selectedvalue,
                            items: blocknames!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item.toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select block.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedvalue = value.toString();
                              });
                            },
                            onSaved: (value) {
                              selectedvalue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              iconSize: 25,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 12,
                              maxHeight:
                                  MediaQuery.of(context).size.height / 2.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          selectedvalue!=null?SizedBox(
            width: MediaQuery.of(context).size.width / 1.15,
            child: Column(
              children: [
                const SizedBox(height: 18,),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                      left: 20.3, right: 20.3, bottom: 8.3),
                  child: BasicText(
                    fontSize: 16,
                    title: "Enter maintaince Bill amount : - ",
                    color: Colors.pink.shade500,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.3),
                  child: SizedBox(
                    child: TextFormField(

                      onChanged: (value){},
                      controller: amount,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter amount";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        hintStyle: const TextStyle(fontSize: 13.9),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15.0),
                        fillColor: Colors.pink,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red, width: 1.9),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: const OutlineInputBorder()),
                    )
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300,
                      minimumSize: const Size(120, 50)
                    ),
                    onPressed: () {
                      setState(() {
                        postData(widget.userid,widget.apartcode);
                      });
                    },
                    child: Text(
                      "Submit",
                      style: GoogleFonts.acme(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          letterSpacing: 0.4,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) :Container(),
        ],
      ),
    );
  }

  void _formatNumber() {
    String text = amount.text.replaceAll(',', '');
    if (text.isEmpty) return;

    final number = int.tryParse(text);
    if (number == null) return;

    final formattedText = NumberFormat('#,###').format(number);
    amount.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

   postData(String? userid, String? apartcode) async {
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
     ApiService().maintainceAmount(data,selectedvalue,apartcode);
   }
}
