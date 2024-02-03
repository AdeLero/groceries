import 'package:flutter/material.dart';
import 'package:groceries/models/meal_model.dart';
import 'package:groceries/models/meal_type_model.dart';

class PlannedMeal {
  MealType mealType;
  Meal? selectedMeal;
  double? servings;
  DateTime? date;
  String? note;

  PlannedMeal({
    required this.mealType,
    required this.selectedMeal,
    required this.servings,
    required this.date,
    this.note,
});
}

ValueNotifier<List<PlannedMeal>> plannedMeals = ValueNotifier<List<PlannedMeal>>([]);

ValueNotifier<List<PlannedMeal>> finalMealPlan = ValueNotifier<List<PlannedMeal>>([]);
