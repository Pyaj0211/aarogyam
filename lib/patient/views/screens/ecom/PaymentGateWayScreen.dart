import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String medicineName;
  final String manufacturer;
  final double price;
  final String name;
  final String address;
  final String email;
  final int quantity;

  const PaymentScreen({
    super.key,
    required this.medicineName,
    required this.manufacturer,
    required this.price,
    required this.name,
    required this.address,
    required this.email,
    required this.quantity,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  User? _user;
  String _phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _phoneNumber = user.phoneNumber!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserPhoneNumber();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (kDebugMode) {
      print("Payment Success: ${response.paymentId!}");
    }

    if (_user != null) {
      // Save payment details to user account
      FirebaseFirestore.instance.collection('users').doc(_user!.uid)
          .collection('Purchase').add({
        'medicineName': widget.medicineName,
        'manufacturer': widget.manufacturer,
        'price': widget.price,
        'name': widget.name,
        'address': widget.address,
        'email': widget.email,
        'paymentId': response.paymentId,
        'quantity': widget.quantity,
        'timestamp': FieldValue.serverTimestamp(),
      })
          .then((value) {
        if (kDebugMode) {
          print('Payment details saved successfully');
        }
        // Navigate to the ecom page here
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to save payment details: $error');
        }
      });
      Navigator.popUntil(context, ModalRoute.withName('/EcomMedicine'));

    } else {
      if (kDebugMode) {
        print('User is null');
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      print("Payment Error: ${response.message!}");
    }
    // Handle payment failure here
    // Show an error message to the user
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      print("External Wallet: ${response.walletName!}");
    }
    // Handle external wallet payment here
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_yeHfOtOcrkH5bn',
      'amount': widget.price * widget.quantity * 100, // amount in the smallest currency unit (e.g., 100 cents for $1)
      'name': widget.medicineName,
      'description': widget.manufacturer,
      'prefill': {'contact': _phoneNumber, 'email': 'aarogyam@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text('Payment',style: TextStyle(color: Colors.white),),
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medicine:- ${widget.medicineName}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding:  const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manufacturer:- ${widget.manufacturer}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username:- ${widget.name}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile no:- ${_phoneNumber.substring(3)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email:- ${widget.email}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address:- ${widget.address}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding:  const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity:- ${widget.quantity}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price:- \₹${widget.price * widget.quantity}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03,),
            Center(
              child: InkWell(
                onTap: () {
                  _openCheckout();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.teal,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Center(
                    child: Text(
                      'Pay Now',
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
