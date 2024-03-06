import 'package:aarogyam/patient/views/screens/AddToCart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'MedicineDetailsScreen.dart';

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  int? _tappedIndex;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Text(
          'MEDICINES',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search medicines',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VALUE DEALS FOR YOU',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('medicineDetails').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No data available'),
                  );
                }
                List<DocumentSnapshot> medicines = snapshot.data!.docs.where((medicine) {
                  var data = medicine.data() as Map<String, dynamic>;
                  return data['medicineName'].toLowerCase().contains(_searchQuery) ||
                      data['dosageForm'].toLowerCase().contains(_searchQuery) ||
                      data['expiryDate'].toLowerCase().contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    var medicine = medicines[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              MedicineDetailsScreen(medicineDetails: medicine),));
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.200,
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Row(
                            children: [
                              Image.network(medicine['medImage'], width: 100, height: 100, fit: BoxFit.fill,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(medicine['medicineName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text('Dosage Form: ${medicine['dosageForm']}'),
                                    Text('Expiry Date: ${medicine['expiryDate']}'),
                                    Text('Stock Quantity: ${medicine['stockQuantity']}'),
                                    Text('Price: ${medicine['price']}'),
                                    const SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddToCartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
