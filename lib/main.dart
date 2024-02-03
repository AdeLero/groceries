import 'package:flutter/material.dart';
import 'package:groceries/screens/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:groceries/screens/meal_time/meal_time_provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
    create: (_) => MealTimeProvider(
      breakfastTime: TimeOfDay(hour: 8, minute: 0),
      lunchTime: TimeOfDay(hour: 14, minute: 0),
      dinnerTime: TimeOfDay(hour: 19, minute: 0),
    ),
      child: const GroceriesApp(),
      ),
  );
}

class GroceriesApp extends StatefulWidget {
  const GroceriesApp({super.key});

  @override
  State<GroceriesApp> createState() => _GroceriesAppState();
}

class _GroceriesAppState extends State<GroceriesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Kavivanar'),
    );
  }
}
