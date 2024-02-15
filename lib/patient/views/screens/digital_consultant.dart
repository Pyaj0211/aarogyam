import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DigitalConsult extends StatefulWidget {
  const DigitalConsult({Key? key}) : super(key: key);

  @override
  State<DigitalConsult> createState() => _DigitalConsultState();
}

class _DigitalConsultState extends State<DigitalConsult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Consult'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                ),
                const Text('Surat'),
              ],
            ),
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
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.teal,
                      ),
                      // border: OutlineInputBorder(),
                      hintText: 'Search Doctors, Specialities & Symptoms',
                      hintStyle: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shadowColor: Colors.green,
                color: Colors.white,
                elevation: 2,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                            height: 15,
                          ),
                          Expanded(
                            child: Text(
                              'Browse by symptoms',
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.orange,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/Cough.png',
                                    width: 45,
                                  ),
                                  const Text(
                                    'Cough',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Nose.png',
                                      width: 45),
                                  const Text(
                                    'Cold',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Stress.png',
                                      width: 45),
                                  const Text(
                                    'Stress',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Throat.png',
                                      width: 45),
                                  const Text(
                                    'Throat',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Specialties for Digital Consult',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      _ConsultTile( 'assets/images/Neurology.jpg', 'Neurology'),
                      const SizedBox(width: 10),
                      _ConsultTile('assets/images/Bariatrics.jpg', 'Bariatrics'),
                      const SizedBox(width: 10),
                      _ConsultTile( 'assets/images/Cardiology.jpg', 'Cardiology'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      _ConsultTile('assets/images/Dermatology.jpg','Dermatology'),
                      const SizedBox(width: 10),
                      _ConsultTile( 'assets/images/Psychiatry_img.jpg', 'Psychiatry'),
                      const SizedBox(width: 10),
                      _ConsultTile('assets/images/Paediatrics.jpg', 'Paediatrics'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      _ConsultTile(  'assets/images/Physiotherapy.jpg', 'Physiotherapy'),
                      const SizedBox(width: 10),
                      _ConsultTile( 'assets/images/Diabetology.jpg', 'Diabetology'),
                      const SizedBox(width: 10),
                      _ConsultTile( 'assets/images/Urology.jpg',  'Urology'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Wellness',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent.shade100,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Psychiatry.png',
                            width: 70,
                            height: 75,
                          ),
                          const Text(
                            'Psychiatry',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent.shade100,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/SexualHealth.png',
                            width: 70,
                            height: 75,
                          ),
                          const Text(
                            'Sexual Health',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              //borderRadius: BorderRadius.circular(40),
                              //color: Colors.red
                              ),
                          height: 60,
                          width: 72,
                          child: Image.asset(
                            'assets/images/chat 1.png',
                          ),
                        ),
                        const Text(
                          'Ask Us!',
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feeling Unwell? ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Take an assessment in less than 3 min',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'and get suggestion on what to do next',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade100,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/medical-report.png',
                                        width: 45),
                                    Text(
                                      'Enter',
                                      style: TextStyle(
                                          color: Colors.orange.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Symptoms',
                                      style: TextStyle(
                                          color: Colors.orange.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.shade100,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/symptoms.png',
                                        width: 45),
                                    Text(
                                      'Understand',
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'causes',
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent.shade100,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/medical-staff.png',
                                        width: 45),
                                    //  Image.asset('assets/images/Clinic.png', width: 28),
                                    Text(
                                      'Book',
                                      style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Consultant',
                                      style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(15),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _ConsultTile (String imagepath , String title) {
  return  Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal, width: 2),
      ),
      child: Column(
        children: [
          Image.asset(
            imagepath,
            width: 115,
            height: 75,
            fit: BoxFit.cover,
          ),
           Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
