import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Model/complaints.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

class ComplaintsReceived extends StatefulWidget {
  final Users? user;
  final String? apartmentCode;

  ComplaintsReceived({Key? key, this.user, required this.apartmentCode }) : super(key: key);

  @override
  ComplaintsReceivedState createState() => ComplaintsReceivedState();
}

class ComplaintsReceivedState extends State<ComplaintsReceived> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0099CC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF003366),
        centerTitle: true,
        title: BasicText(
          title: 'Complaints Box',
          fontSize: 19,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366), // Darker blue color at the top
              Color(0xFF0099CC), // Lighter blue color at the bottom
            ],
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<Complaints>>(
          future: ApiService().getComplaint(widget.apartmentCode!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No complaints found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final complaint = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blue.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Users?>(
                            future: ApiService.userData(complaint.user_id!),
                            builder: (context, snap) {
                              if (snap.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snap.hasError) {
                                return Center(child: Text('Error: ${snap.error}'));
                              } else if (snap.hasData) {
                                Users? user = snap.data;
                                return Text(
                                  'Name: ${user!.first_name!}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("Complaint_type : ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(complaint.complaint_type!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),

                          const Text(
                            'Complaint : -',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            ' ${complaint.description}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
