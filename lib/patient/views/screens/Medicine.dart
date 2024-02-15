import 'package:aarogyam/patient/views/screens/Brand_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.teal,
        title: const Text(
          'MEDICINES',
          style: TextStyle(fontSize: 18, color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: SearchBar(
                backgroundColor: MaterialStateProperty.all(
                  Colors.white
                ),
                leading: Icon(Icons.search_rounded),
                hintText: 'Search tests & packages',
                hintStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.teal)
                ),
              )
            ),

            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProduct("assets/images/Onetouch2.webp",
                        "OneTouch Select Plus Simple Glucometer", "875", "4.8"),
                    _buildProduct("assets/images/Onetouch1.jpg",
                        "OneTouch Select Plus Test Strips", "799", "4.9"),
                    _buildProduct("assets/images/Veseline.webp",
                        "Vaseline Deep Moisture Body Lotion", "304", "4.8"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SKIN CARE BY CARE VE',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProduct(
                        "assets/images/Ceareve1.webp",
                        "CareVe Moisturising Cream for Dry to Very Dry Skin",
                        "1600",
                        "4.5"),
                    _buildProduct(
                        "assets/images/Cerave2.webp",
                        "CareVe Foaming Daily Gel Cleanser for Normal Skin",
                        "1550",
                        "4.6")
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //BRANDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SHOP BY BRANDS',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(const BrandList());
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.teal,
                        size: 20,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard('assets/images/logos/Pampers.png'),
                    _buildCard('assets/images/logos/Vaseline.jpeg'),
                    _buildCard('assets/images/logos/Onetouch.png'),
                    _buildCard('assets/images/logos/Whisper.png'),
                    _buildCard('assets/images/logos/Nivea.png'),
                    _buildCard('assets/images/logos/Mamypoko.jpeg'),
                    _buildCard('assets/images/logos/Careve.jpeg'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //BRANDS
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SHOP BY CATEGORY',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildcategory(
                        'assets/images/Products/Babycare.webp', "Baby Care"),
                    _buildcategory('assets/images/Products/HealthDevices.webp',
                        "Health Devices"),
                    _buildcategory(
                        'assets/images/Products/Ayurveda.png', "Ayurveda"),
                    _buildcategory('assets/images/Products/Personal.webp',
                        "Personal Care"),
                    _buildcategory(
                        'assets/images/Products/WomenCare.webp', "Women Care"),
                    _buildcategory(
                        'assets/images/Products/Chaman.webp', "Chyawanprash"),
                    _buildcategory('assets/images/Products/Protein.webp',
                        "Protein Powder"),
                    _buildcategory(
                        'assets/images/Products/Super.webp', "Superfoods"),
                    _buildcategory('assets/images/Products/Winter.jpeg',
                        "Winter Essentials"),
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

Widget _buildProduct(
    String imagepath, String title, String price, String rating
    ) {
  return Container(
    width: 200,
    height: 210,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ]),
    margin: const EdgeInsets.only(left: 10),
    padding: const EdgeInsets.all(25.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //image
        Image.asset(
          imagepath,
          height: 90,
        ),
        //name
        Text(
          title,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //price + rating
        SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\₹' + price),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    rating,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(String imagepath) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          imagepath,
          width: 100,
          height: 50,
        ),
      ),
    ),
  );
}

Widget _buildcategory(String imagepath, String name) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              imagepath,
              width: 50,
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
