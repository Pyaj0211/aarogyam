import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PurchaseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!userSnapshot.hasData || userSnapshot.data == null) {
          return Center(child: Text('No user logged in.'));
        }

        String userId = userSnapshot.data!.uid;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Purchase Details',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('Purchase')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No purchase history.'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                  // Calculate the difference in hours between now and the purchase timestamp
                  int differenceInHours = DateTime.now()
                      .difference((data['timestamp'] as Timestamp).toDate())
                      .inHours;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['medicineName'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                  Text('Quantity: ${data['quantity']}',style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15
                                  ), ),
                                  Text(
                                    'Price: ${data['price']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.green,
                                        fontSize: 15
                                    ),
                                  ),
                                  Text('Date: ${DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000).toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                              if (differenceInHours < 24)
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Cancel Order"),
                                          content: Text("Are you sure you want to cancel this order?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Implement cancel order functionality
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userId)
                                                    .collection('Purchase')
                                                    .doc(document.id)
                                                    .delete()
                                                    .then((value) {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Order canceled successfully')),
                                                  );
                                                }).catchError((error) {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Failed to cancel order: $error')),
                                                  );
                                                });
                                              },
                                              child: const Text("Yes"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Cancel Order',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.red),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
