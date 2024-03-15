
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HealthBlog extends StatefulWidget {
  const HealthBlog({super.key});

  @override
  State<HealthBlog> createState() => _HealthBlogState();
}

class _HealthBlogState extends State<HealthBlog> {
  int currentIndex = 0;
  // ignore: non_constant_identifier_names
  final Myitems = [
    Image.asset('assets/icons/helthblog/Heart.png'),
    Image.asset('assets/icons/helthblog/Kidneys.png'),
    Image.asset('assets/icons/helthblog/Liver.png'),
    Image.asset('assets/icons/helthblog/Thyroid.png'),
    Image.asset('assets/icons/helthblog/Lung.png'),
    Image.asset('assets/icons/helthblog/Bones.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Health BLOG",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Searchbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.orangeAccent,
                      ),

                      hintText: 'Search Articles',
                      hintStyle: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Healthy Organs',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.teal, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 70,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollPhysics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) => {
                          setState(() {
                            currentIndex = index;
                          }),
                        },
                      ),
                      items: Myitems),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Articles',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal.shade700),
                  ),
                ],
              ),
            ),
            _BlogArticle(
                'assets/images/Cardiology.jpg',
                "General Health",
                "General Health is about your health so be confident about is no worry about it",
                " General Health is about  your health so be confident about is General Health is about your health so be confident about your health so be confident about is General Health is about your health so be confident about is ",
                "4 min read"),
            _BlogArticle(
                'assets/images/Physiotherapy.jpg',
                "Special Condition",
                "It is dangerous to wake a SleepWalker?",
                "Sleepwalking or somnambulism,involves getting up and while in a state of sleep.",
                "3 min read"),
            _BlogArticle(
                'assets/images/Physiotherapy.jpg',
                "Special Condition",
                "It is dangerous to wake a SleepWalker?",
                "Sleepwalking or somnambulism,involves getting up and while in a state of sleep.",
                "3 min read"),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _BlogArticle(String imagepath, String category, String title,
    String subtitle, String timeline) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),

      ),
      child: Column(
        children: [
          //Image
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Image.asset(
              imagepath,
              fit: BoxFit.cover,
            ),
          ),
          //text of general health
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 5, bottom: 4, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
                //subtitle
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 5, bottom: 4, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                //timeline
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        timeline,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
