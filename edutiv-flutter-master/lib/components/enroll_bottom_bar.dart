import 'package:edutiv/model/course/course_viewmodel.dart';
import 'package:edutiv/model/profile/profile_viewmodel.dart';
import 'package:edutiv/screens/course/my_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrollBottomBar extends StatefulWidget {
  const EnrollBottomBar({Key? key}) : super(key: key);

  @override
  State<EnrollBottomBar> createState() => _EnrollBottomBarState();
}

class _EnrollBottomBarState extends State<EnrollBottomBar> {
  bool _isEnrolling = false;

  Future<void> _enroll() async {
    if (_isEnrolling) return;

    final course = Provider.of<CourseViewModel>(context, listen: false);
    final user = Provider.of<ProfileViewModel>(context, listen: false);

    int? userId;
    int? courseId;
    try {
      userId = user.userData.id;
      courseId = course.courseData.id;
    } catch (_) {
      _showMessage('Unable to enroll right now. Please try again.');
      return;
    }

    if (userId == null || courseId == null) {
      _showMessage('Unable to enroll right now. Please try again.');
      return;
    }

    setState(() => _isEnrolling = true);
    try {
      await course.enrollCourse(userId, courseId);
      await user.getEnrolledCourse();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyCourseScreen(),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      _showMessage('Failed to enroll in this course.');
    } finally {
      if (mounted) {
        setState(() => _isEnrolling = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    final canEnroll = !_isEnrolling && !course.isLoading && !user.isLoading;

    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(62, 158, 158, 158),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: canEnroll ? _enroll : null,
          child: _isEnrolling
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('ENROLL COURSE'),
        ),
      ),
    );
  }
}
