import 'package:aarogyam/patient/views/screens/MedicineDetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const AddToCartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
        ),
        body: ListView.builder(
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              var item = widget.cartItems[index];
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineDetailsScreen(
                        medicineDetails: item,
                        addToCartCallback: (Map<String, dynamic> medicineDetails) {
                          // Implement addToCartCallback logic if needed
                        },
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.200,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.12,
                    child: Row(
                      children: [
                        Image.network(
                          item['medImage'], width: 100, height: 100, fit: BoxFit.fill,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['medicineName'], style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),),
                              Text('Dosage Form: ${item['dosageForm']}'),
                              Text('Expiry Date: ${item['expiryDate']}'),
                              Text('Stock Quantity: ${item['stockQuantity']}'),
                              Text('Price: ${item['price']}'),
                              const SizedBox(height: 5,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.cartItems.removeAt(index);
                                  });

                                },
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.teal, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        50), // Border radius
                                  ),
                                  child: const Center(
                                    child: Text('Remove Item'),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );

  }
}
