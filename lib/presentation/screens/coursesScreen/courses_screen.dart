import 'package:fablearner_app/business/model/course_model.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({
    Key? key,
    required this.appController,
    required this.token,
  }) : super(key: key);

  final AppController appController;
  final String token;

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool _showCard = true;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.appController.isLoading.value
          ? const Center(
              child: LoadingAnimation(),
            )
          : (widget.appController.error.value != null)
              ? Center(
                  child: Text(
                    'Error loading courses. Please try again.',
                    style: AppStyles.errorTextStyle,
                  ),
                )
              : Column(
                  children: [
                    if (widget.appController.savedLessonId != null && _showCard)
                      savedLessonCard(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.appController.courseList.length,
                        itemBuilder: (context, index) {
                          final course = widget.appController.courseList[index];
                          return courseCard(course);
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  SizedBox courseCard(Course course) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(course.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListTile(
                title: Text(course.name, style: AppStyles.courseCardTitleStyle),
                trailing: Text(
                  '${course.sections.where((section) => section.percent == 100).length}/${course.sections.length}',
                  style: AppStyles.courseCardTitleStyle.copyWith(
                    color: successGreen,
                  ),
                ),
                onTap: () async {
                  // Set state to hide the card after navigation
                  setState(() {
                    _showCard = false;
                  });
                  Get.to(
                      () => SectionsScreen(
                            token: widget.token,
                            courseId: course.id,
                          ),
                      duration: 800.milliseconds,
                      transition: Transition.rightToLeft);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector savedLessonCard() {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => LessonDetailsScreen(
            token: widget.token,
            lessonId: widget.appController.savedLessonId!,
          ),
          duration: 800.milliseconds,
          transition: Transition.rightToLeft,
        )?.then((value) {
          // Set state to hide the card after navigation
          setState(() {
            _showCard = false;
          });
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.shade400,
                  primaryRed,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Text(
                      'Continue Where You Left Off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/* 

Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continue Learning',
                          style: AppStyles.subtitleStyle,
                          textAlign: TextAlign.left,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              () => LessonDetailsScreen(
                                token: widget.token,
                                lessonId: widget.appController.savedLessonId!,
                              ),
                              duration: 800.milliseconds,
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Text(
                            'Continue',
                            style: AppStyles.subtitleStyle.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
 */

/* 
activites slider:
Row(
  children: [
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.04,
    ),
    Text(
      'Activities',
      style: AppStyles.subtitleStyle,
      textAlign: TextAlign.left,
    ),
  ],
),
const SizedBox(
  height: 8,
),
ActivitiesSlider(
  token: token,
),
const SizedBox(
  height: 8,
), 
*/
