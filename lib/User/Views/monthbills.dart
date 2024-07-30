import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Model/maintaince_bill.dart';
import 'package:maintaince_app/User/Views/payments.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

class MaintenanceBill extends StatefulWidget {
  final String? userid;
  MaintenanceBill({Key? key, this.userid}) : super(key: key);

  @override
  State<MaintenanceBill> createState() => _MaintenanceBillState();
}

class _MaintenanceBillState extends State<MaintenanceBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<MaintainceBill?>(
          future: ApiService().getMaintainceBill(widget.userid, "Unpaid"),
          builder: (context, snap) {
            if (snap.hasData) {
              var bills = snap.data!.result;
              return bills!.isNotEmpty
                  ? ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  return buildMaintainceBill(bills, index);
                },
              )
                  : const Center(
                child: Text(
                  "No Dues",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          },
        ),
      ),
    );
  }

  Widget buildMaintainceBill(List<Result> bills, int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicText(
                  title: "Bill Amount",
                  fontSize: 16,

                ),
                const SizedBox(height: 8),
                BasicText(
                  title: "₹ ${bills[index].amount}",
                  fontSize: 19,
                  color: Colors.pink,

                ),
                const SizedBox(height: 16),
                BasicText(
                  title: "Generate Date",
                  fontSize: 16,

                ),
                const SizedBox(height: 8),
                BasicText(
                  title: getDate(bills[index].maintenanceDate) ?? "N/A",
                  fontSize: 19,

                ),
                const SizedBox(height: 16),
                BasicText(
                  title: "Due Date",
                  fontSize: 16,

                ),
                const SizedBox(height: 8),
                BasicText(
                  title: "2024-08-01",
                  fontSize: 19,

                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        ApiService().statusUpdate(widget.userid, "Paid");
                      });
                    },
                    child: BasicText(
                      title: "Pay",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getDate(String? date) {
    if (date == null) {
      return "N/A"; // Or any default value or handling you prefer
    }

    DateTime utcDateTime = DateTime.parse(date);

    // Convert UTC to local time
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the local date-time
    String formattedDate = DateFormat('yyyy-MM-dd').format(localDateTime);
    return formattedDate;
  }
}
