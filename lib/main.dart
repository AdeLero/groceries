import 'package:flutter/material.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';
import 'package:groceries/screens/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:groceries/screens/meal_time/meal_time_provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider<MealTimeProvider>( create: (context) =>  MealTimeProvider(
          breakfastTime: TimeOfDay(hour: 8, minute: 0),
          lunchTime: TimeOfDay(hour: 14, minute: 0),
          dinnerTime: TimeOfDay(hour: 19, minute: 0),
        )),
        ChangeNotifierProvider<Inventory>( create: (context) =>  Inventory()),
      ],
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
