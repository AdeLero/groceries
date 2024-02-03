import 'package:flutter/material.dart';

class MealTimeProvider extends ChangeNotifier {
  late TimeOfDay breakfastTime;
  late TimeOfDay lunchTime;
  late TimeOfDay dinnerTime;

  MealTimeProvider({
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
});

  void setMealTimes({
    required TimeOfDay breakfastTime,
    required TimeOfDay lunchTime,
    required TimeOfDay dinnerTime,
  }) {
    this.breakfastTime = breakfastTime;
    this.lunchTime = lunchTime;
    this.dinnerTime = dinnerTime;
    notifyListeners();
  }
}
