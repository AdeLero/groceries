import 'package:flutter/material.dart';
import 'package:groceries/screens/meal_time/meal_time_settings.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealTimeSettings(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Meal Time Settings'),
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
