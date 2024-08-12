import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../Model/complaints.dart';
import '../Model/usermodel.dart';
import '../changeprovider/api.dart';

class ComplaintsPending extends StatefulWidget {
  final String? apartmentCode;

  const ComplaintsPending({super.key, this.apartmentCode});

  @override
  State<ComplaintsPending> createState() => _ComplaintsPendingState();
}

class _ComplaintsPendingState extends State<ComplaintsPending> {
  Future<List<Complaints>?>? complaint;

  @override
  void initState() {
    super.initState();
    complaint = ApiService().getComplaint(widget.apartmentCode!, "Pending");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: FutureBuilder<List<Complaints>?>(
            future: ApiService().getComplaint(widget.apartmentCode!, "Pending"),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snap.hasError) {
                return Center(child: Text('Error: ${snap.error}'));
              } else if (!snap.hasData || snap.data!.isEmpty) {
                return Center(
                    child: Text(
                      'No Complaints found.',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 16.5, letterSpacing: 0.6),
                    ));
              } else {
                return Container(
                  margin: const EdgeInsets.all(12.3),
                  child: ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      final complaint = snap.data;
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
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
                                future: ApiService.userData(
                                    complaint![index].user_id!),
                                builder: (context, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snap.hasError) {
                                    return Center(
                                        child: Text('Error: ${snap.error}'));
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
                                  const Text(
                                    "Complaint_type : ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      complaint[index].complaint_type!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(right: 12.3),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Complaint : - ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextSpan(
                                        text: complaint[index].description!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              complaint[index].image!=null?Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _showImageDialog(context, complaint[index].image!),
                                    child: CachedNetworkImage(
                                      cacheManager: CustomCacheManager.instance,
                                      imageUrl: complaint[index].image!,
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.fitWidth,
                                      width: 300,
                                      height: 260,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ):Container(),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(150, 50)
                                    // backgroundColor: Colors.green
                                  ),
                                  onPressed: () {
                                      complaint[index].pressed = !complaint[index].pressed!;
                                      if(complaint[index].pressed!){
                                        setState(() {
                                          ApiService().approveComplaint(
                                              complaint[index].id!,
                                              "Completed");
                                        });
                                      }

                                  },
                                  child: Text(
                                    "Completed",
                                    style: GoogleFonts.acme(
                                      color: Colors.red,
                                      fontSize: 16.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        );
      },
    );
  }
}

class CustomCacheManager {
  static CacheManager instance = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7), // Adjust cache duration as needed
      maxNrOfCacheObjects: 100,
    ),
  );
}
