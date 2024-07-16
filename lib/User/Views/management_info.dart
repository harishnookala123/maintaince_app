import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import '../../Admin/Model/adminRegistartion.dart';
import '../../Admin/Model/usermodel.dart';


class ManagementInfoScreen extends StatelessWidget {
  
  final Users? user;
  const ManagementInfoScreen({super.key,this.user});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: SizedBox(
            width:double.infinity,
            height:MediaQuery.of(context).size.height / 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 FutureBuilder<Admin?>(
                     future:ApiService().getAdminById(user!.admin_id!),
                     builder: (context,snap){
                        if(snap.hasData){
                          var admin = snap.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                  'Name: ${admin?.firstName ?? ''}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height:8),
                                Text(
                                  'Email: ${admin?.email ?? ''}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              const SizedBox(height:8),
                              Text(
                                'Phone: ${admin?.phone ?? ''}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        }
                        return Container();
                     }),
                  const SizedBox(height: 8.0),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
