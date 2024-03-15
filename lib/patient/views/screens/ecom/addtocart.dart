import 'package:aarogyam/patient/views/screens/ecom/medicinedetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(_auth.currentUser!.uid)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No items in cart'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Container(
                    child: Stack(
                      children: [
                       ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicineDetails(
                                  medicineName: doc['medicineName'],
                                  dosageForm: doc['dosageForm'],
                                  expiryDate: doc['expiryDate'],
                                  price: doc['price'],
                                  medImage: doc['medImage'],
                                  manufacturer: doc['manufacturer'],
                                  medDescription: doc['medDescription'],
                                  stockQuantity: doc['stockQuantity'],
                                  strength: doc['strength'],
                                  useInfo: doc['useInfo'],
                                  docid: doc.id,

                                ),
                              ),
                            );

                          },
                          leading: Image.network(
                            doc['medImage'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(doc['medicineName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dosage Form: ${doc['dosageForm']}'),
                              Text('Stock Quantity: ${doc['stockQuantity']}'),
                              Text('Price: \₹${doc['price']}',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                doc.reference.delete();
                              });
                            },
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
    );
  }
}
