import 'package:aarogyam/patient/data/models/blog_model.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HealthBlog extends StatefulWidget {
  const HealthBlog({Key? key}) : super(key: key);

  @override
  State<HealthBlog> createState() => _HealthBlogState();
}

class _HealthBlogState extends State<HealthBlog> {
  late final Stream<List<BlogModel>> dataStream;

  @override
  void initState() {
    super.initState();
    dataStream = db.getBlogsStream();
  }

  int currentIndex = 0;
  final db = DatabaseService();
  final MyItems = [
    Image.asset('assets/icons/LabTest/Heart.png'),
    Image.asset('assets/icons/LabTest/Kidneys.png'),
    Image.asset('assets/icons/LabTest/Liver.png'),
    Image.asset('assets/icons/LabTest/Thyroid.png'),
    Image.asset('assets/icons/LabTest/Lung.png'),
    Image.asset('assets/icons/LabTest/Bones.png'),
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
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
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
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: MyItems.map((item) => item).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
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
            StreamBuilder<List<BlogModel>>(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final blog = snapshot.data![index];
                      return _BlogArticle(
                        blogImage: blog.blogImage ?? '',
                        topicName: blog.topicName ?? '',
                        categoryName: blog.categoryName ?? '',
                        description: blog.description ?? '',
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogArticle extends StatelessWidget {
  final String blogImage;
  final String topicName;
  final String categoryName;
  final String description;

  const _BlogArticle({
    required this.blogImage,
    required this.topicName,
    required this.categoryName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Image.network(
                blogImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 5, bottom: 4, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            topicName,
                            maxLines: 3,
                            style:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 5, bottom: 4, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            description,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
