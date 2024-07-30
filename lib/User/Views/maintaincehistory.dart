import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Admin/changeprovider/api.dart';
import '../../styles/basicstyles.dart';
import '../Model/maintaince_bill.dart';

class MaintainceHistory extends StatefulWidget {
  String? userid;
  MaintainceHistory({super.key, this.userid});

  @override
  State<MaintainceHistory> createState() => MaintainceHistoryState();
}

class MaintainceHistoryState extends State<MaintainceHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<MaintainceBill?>(
          future: ApiService().getMaintainceBill(widget.userid, "paid"),
          builder: (context, snap) {
            if (snap.hasData) {
              List<Result>? bills = snap.data!.result;
              return bills!.isNotEmpty
                  ? ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    return buildMaintainceBill(bills, index);
                  })
                  : const Center(
                child: Text(
                  "No Payments has done",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
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
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Card(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(3.5),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BasicText(
                        title: "Bill Amount :-",
                        fontSize: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12.3),
                        child: BasicText(
                            fontSize: 19,
                            color: Colors.pink,
                            title: "₹ ${bills[index].amount}"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BasicText(
                        title: "Generate Date : -",
                        fontSize: 16,
                      ),
                      BasicText(
                        title: getDate(bills[index].maintenanceDate),
                        fontSize: 19,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     BasicText(
                  //       title: "Paid Date : -",
                  //       fontSize: 16,
                  //     ),
                  //     BasicText(
                  //       title: getDate(bills[index].paid_date),
                  //       fontSize: 19,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
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
