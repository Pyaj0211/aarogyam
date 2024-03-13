import 'package:aarogyam/patient/views/screens/ecom/PaymentGateWayScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SummaryPage extends StatefulWidget {
  final String medicineName;
  final String manufacturer;
  final double price;

  const SummaryPage({
    Key? key,
    required this.medicineName,
    required this.manufacturer,
    required this.price,
  }) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  double? lat;
  double? long;
  String address = "";
  bool disposed = false; // Flag to track if the state is disposed
  int quantity = 1;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getLatLong() {
    if (disposed) return; // Check if the state is disposed
    Future<Position> data = _determinePosition();
    data.then((value) {
      if (disposed) return; // Check if the state is disposed
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      if (disposed) return; // Check if the state is disposed
      print("Error $error");
    });
  }

  void showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(Icons.location_pin, color: Colors.teal),
            title: const Text("Use current location?"),
          ),
          content: const Text("Do you want to use your current location as the address?"),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                getLatLong();
                if (address.isNotEmpty) {
                  addressController.text = '$address (Lat: $lat, Long: $long)';
                }
              },
            ),
          ],
        );
      },
    );
  }

  void getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (disposed) return; // Check if the state is disposed
    setState(() {
      address = placemarks[0].street! + " " + placemarks[0].subLocality! + " " + placemarks[0].locality! + " " + placemarks[0].postalCode! + " " + placemarks[0].administrativeArea! + " " + placemarks[0].country!;
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;
    final User? user = FirebaseAuth.instance.currentUser;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('Summary',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.data() == null) {
                          return Container();
                        }

                        Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (userData['address'] != null) {
                                  setState(() {
                                    // Autofill name and email fields if available
                                    addressController.text = userData['address'];
                                    nameController.text = userData['name'] ?? '';
                                    emailController.text = userData['email'] ?? '';
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Saved Address:',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text(userData['address'] ?? ''),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02,),
                          ],
                        );
                      },
                    ),
                    Text(
                      'Medicine: ${widget.medicineName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text(
                      'Manufacturer: ${widget.manufacturer}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text(
                      'Price: \₹${widget.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 15,
                            child: Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text('$quantity',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              quantity++;
                            });

                          },
                          child: CircleAvatar(
                            radius: 15,
                            child: Text("+",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01,),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person, color: Colors.teal,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: addressController,
                      onTap: () {
                        showLocationDialog();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.location_pin, color: Colors.teal,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.teal,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  if (user != null &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          medicineName: widget.medicineName,
                          manufacturer: widget.manufacturer,
                          price: widget.price,
                          name: nameController.text,
                          address: addressController.text,
                          email: emailController.text,
                          quantity: quantity,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Missing Details'),
                          content: const Text('Please fill in all the details.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
