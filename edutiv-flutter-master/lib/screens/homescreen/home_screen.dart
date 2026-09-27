import 'package:edutiv/components/carousel_hero.dart';
import 'package:edutiv/components/data.dart';
import 'package:edutiv/components/logo.dart';
import 'package:edutiv/components/teks_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/category_card.dart';
import '../../components/course_card.dart';
import '../../components/feature_card.dart';
import '../../model/course/course_viewmodel.dart';
import '../../model/profile/profile_viewmodel.dart';
import '../screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<CourseViewModel>(context, listen: false).getAllCourse();
    Provider.of<CourseViewModel>(context, listen: false).getAllCategory();
    Provider.of<ProfileViewModel>(context, listen: false).getEnrolledCourse();
    Provider.of<ProfileViewModel>(context, listen: false).getWhoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const subjects = SecondarySchoolData.subjectCatalog;
    const features = SecondarySchoolData.learningFeatures;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Logo(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CarouselHero(),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF126E64).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Secondary Learning Hub',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${subjects.length}+ subjects • ${features.length}+ smart tools',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubjectScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF126E64),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Explore'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Learning features',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: features.take(12).map((feature) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    feature,
                    style: const TextStyle(
                      color: Color(0xFF126E64),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            const Text(
              'Student dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: const [
                FeatureCard(
                  icon: Icons.school_rounded,
                  title: 'My Classes',
                  subtitle: 'Track weekly lessons and assignments.',
                  color: Color(0xFF126E64),
                ),
                FeatureCard(
                  icon: Icons.quiz_rounded,
                  title: 'Practice Tests',
                  subtitle: 'Mock exams and revision drills.',
                  color: Color(0xFF2E7D32),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentProgressScreen(),
                      ),
                    );
                  },
                  child: const FeatureCard(
                    icon: Icons.timeline_rounded,
                    title: 'Progress',
                    subtitle: 'See improvement over time.',
                    color: Color(0xFF1565C0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TimetableScreen(),
                      ),
                    );
                  },
                  child: const FeatureCard(
                    icon: Icons.calendar_month_rounded,
                    title: 'Timetable',
                    subtitle: 'Your weekly class schedule.',
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SchoolPortalScreen(),
                      ),
                    );
                  },
                  child: const FeatureCard(
                    icon: Icons.groups_rounded,
                    title: 'School Portal',
                    subtitle: 'Parent and teacher view.',
                    color: Color(0xFFB26A00),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssignmentCenterScreen(),
                      ),
                    );
                  },
                  child: const FeatureCard(
                    icon: Icons.fact_check_rounded,
                    title: 'Assignments',
                    subtitle: 'Homeworks and due tasks.',
                    color: Color(0xFF0D47A1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Browse subjects',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '${subjects.length}+ courses',
                  style: const TextStyle(
                    color: Color(0xFF126E64),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              itemCount: subjects.length >= 8 ? 8 : subjects.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return CategoryCard(
                  img: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=400&q=80',
                  title: subject['name'] ?? 'Subject',
                  desc: subject['description'] ?? 'School learning',
                );
              },
            ),
            const SizedBox(height: 18),
            TeksBanner(title: 'Top Course'),
            Consumer<CourseViewModel>(
              builder: (context, courseData, child) {
                if (courseData.isLoading2) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: courseData.allCourse!.length >= 3 ? 3 : 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCourseScreen(
                              courseId: courseData.allCourse?[index],
                            ),
                          ),
                        );
                      },
                      child: CourseCard(
                        courseImage:
                            courseData.allCourse?[index].courseImage ?? '-',
                        courseName:
                            courseData.allCourse?[index].courseName ?? '-',
                        rating: courseData.allCourse?[index].totalRating ?? 0,
                        totalTime:
                            courseData.allCourse?[index].totalTime ?? '-',
                        totalVideo: courseData.allCourse?[index].totalVideo
                                .toString() ??
                            '-',
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
