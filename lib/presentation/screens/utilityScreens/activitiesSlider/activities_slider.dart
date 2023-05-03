import 'package:fablearner_app/constants/colors.dart';
import 'package:fablearner_app/constants/styles.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/presentation/screens/lessonDetailsScreen/lesson_details_screen.dart';
import 'package:fablearner_app/business/services/course_activities_api.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ActivitiesSlider extends StatelessWidget {
  const ActivitiesSlider({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String token;

  @override
  Widget build(BuildContext context) {
    print("activites");
    return FutureBuilder<CarouselSlider>(
      future: _getCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const LoadingAnimation();
      },
    );
  }

  Future<CarouselSlider> _getCourses() async {
    final courses = await ActivitiesCourseApi.getCourses(token);
    final name = courses['name'];
    final image = courses['image'];
    final sections = courses['sections'];

    print("Name: $name");
    print("Image: $image");
    print("Sections:");
    for (final section in sections) {
      final sectionTitle = section['title'];
      final sectionItems = section['items'];
      print("- $sectionTitle:");
      for (final item in sectionItems) {
        final itemType = item['type'];
        final itemTitle = item['title'];
        final itemId = item['id'];
        print("  * $itemType: $itemTitle Id:($itemId)");
      }
    }

    List<Widget> cardWidgets = [];
    for (final section in sections) {
      final sectionItems = section['items'];
      for (final item in sectionItems) {
        final itemTitle = item['title'];
        final itemId = item['id'];
        cardWidgets.add(
          GestureDetector(
            onTap: () {
              print("Item $itemTitle with id $itemId was tapped");
              /* Get.to(
                  () => LessonDetailsScreen(
                        lessonId: itemId,
                        token: token,
                      ),
                  duration: 800.milliseconds,
                  transition: Transition.rightToLeft); */
            },
            child: Card(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Image.network(
                    courses['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(
                      itemTitle,
                      style: AppStyles.cardTitleStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: cardWidgets,
    );
  }
}
