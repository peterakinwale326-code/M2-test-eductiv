import 'package:edutiv/screens/course/my_course_screen.dart';
import 'package:flutter/material.dart';

class DisabledEnrollBottomBar extends StatelessWidget {
  const DisabledEnrollBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyCourseScreen(),
              ),
            );
          },
          child: const Text('ALREADY ENROLLED'),
        ),
      ),
    );
  }
}
