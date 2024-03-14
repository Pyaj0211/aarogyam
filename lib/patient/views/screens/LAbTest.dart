import 'package:aarogyam/patient/views/screens/HealthPackage.dart';
import 'package:aarogyam/patient/views/screens/Unhealthy.dart';
import 'package:aarogyam/patient/views/screens/WomenCare.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'AllTest.dart';

class Labtest extends StatefulWidget {
  const Labtest({super.key});

  @override
  State<Labtest> createState() => _LabtestState();
}

class _LabtestState extends State<Labtest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.teal,
        title: const Text(
          'Lab Test',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.teal,
                      ),
                      // border: OutlineInputBorder(),
                      hintText: 'Search tests & packages',
                      hintStyle: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Doctor Created Health Checks (21)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const AllTest());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/FullBody.png', 'Body'),
                  _testCard('assets/icons/LabTest/Diabetes.png', 'Diabetes'),
                  _testCard('assets/icons/LabTest/Women.png', 'Women'),
                  _testCard('assets/icons/LabTest/Thyroid.png', 'Thyroid'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Fever.png', 'Fever'),
                  _testCard('assets/icons/LabTest/Vitamins.png', 'Vitamins'),
                  _testCard('assets/icons/LabTest/Liver.png', 'Liver'),
                  _testCard('assets/icons/LabTest/Harifall.png', 'Hairfall'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Kidneys.png', 'Kidney'),
                  _testCard('assets/icons/LabTest/Hormones.png', 'Hormon'),
                  _testCard('assets/icons/LabTest/Dengue.png', 'Dengue'),
                  _testCard('assets/icons/LabTest/Heart.png', 'Heart'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                // margin: EdgeInsets.only(right: 200),
                shadowColor: Colors.green,
                elevation: 0,
                color: Colors.blue.shade100,
                child: ListTile(
                  leading: Image.asset('assets/images/medical-report.png',
                      width: 45),
                  title: const Text(
                    'Upload Prescription to Order',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Text(
                    '25% OFF',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    weight: 20,
                    size: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Unhealthy Lifestyle (9)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const Unhealthy());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Alcohol.png', 'Alcohol'),
                  _testCard('assets/icons/LabTest/Smoking.png', 'Smoking'),
                  _testCard('assets/images/Stress.png', 'Stress'),
                  _testCard('assets/icons/LabTest/Junkfood.png', 'BadMeal'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Aarogyam Health Packages (12)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const HealthPackage());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/FullBody.png', 'Full Body'),
                  _testCard('assets/icons/LabTest/Diabetes.png', 'Diabetes Package'),
                  _testCard('assets/icons/LabTest/Women.png', 'Women Wellness'),
                  _testCard('assets/images/Lab_reports.png', 'Blood Studies'),
                ],
              ),
            ),
            // women care
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Women Care (5)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const WomenCare());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/pcod.png', 'PCOD'),
                  _testCard('assets/icons/LabTest/Pregnancy.png', 'Pregnancy'),
                  _testCard('assets/images/Lab_reports.png', 'Blood study'),
                ],
              ),
            ),
            //vital organs
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vital Organs (6)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_circle_down_sharp,
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Thyroid.png', 'Thyroid'),
                  _testCard('assets/icons/LabTest/Bones.png', 'Bones'),
                  _testCard('assets/icons/LabTest/Kidneys.png', 'Kidney'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Heart.png', 'Heart'),
                  _testCard('assets/icons/LabTest/Liver.png', 'Liver'),
                  _testCard('assets/icons/LabTest/Lung.png', 'Lungs'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _testCard(String imagepath, String title) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                imagepath,
                width: 100,
                height: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
//1207 code
