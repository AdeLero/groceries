import 'package:flutter/material.dart';
import 'package:groceries/models/ingredient_model.dart';

import '../../models/planned_meal_model.dart';


class Inventory {
  ValueNotifier<List<Ingredient>> ingredients =
  ValueNotifier<List<Ingredient>>([]);

  void addIngredient(Ingredient ingredient) {
    ingredients.value.add(ingredient);
    ingredients.notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients.value.remove(ingredient);
    ingredients.notifyListeners();
  }

  void updateIngredient(Ingredient oldIngredient, Ingredient newIngredient) {
    final index = ingredients.value.indexOf(oldIngredient);
    if (index != -1) {
      ingredients.value[index] = newIngredient;
      ingredients.notifyListeners();
    }
  }

  void updateIngredientQuantities(List<PlannedMeal> mealPlan) {
    for (var plannedMeal in mealPlan) {
      final meal = plannedMeal.selectedMeal;
      if (meal != null) {
        final servings = plannedMeal.servings ?? 0;
        for (var ingredient in meal.mealIngredients) {
          final requiredQuantity = ingredient.quantity * servings;

          final index = ingredients.value.indexWhere((item) => item.ingredientName == ingredient.ingredientName);
          if (index != -1) {
            ingredients.value[index].quantity -= requiredQuantity;
          }
        }
      }
    }
    ingredients.notifyListeners();
  }
}
