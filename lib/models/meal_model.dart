import 'package:flutter/material.dart';
import 'package:groceries/models/ingredient_model.dart';

class Meal {
  String mealName;
  List<Ingredient> mealIngredients;
  String? image;

  Meal({
    required this.mealName,
    required this.mealIngredients,
    this.image,
  });


}

ValueNotifier<List<Meal>> meals = ValueNotifier<List<Meal>>([]);
