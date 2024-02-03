import 'package:flutter/material.dart';
import 'package:groceries/models/ingredient_model.dart';

import '../../models/planned_meal_model.dart';


class Inventory extends ChangeNotifier{
  List<Ingredient> ingredients =[];
  bool isCritical = false;
  int currentPageIndex = 0;
  List<PlannedMeal> finalMealPlan = [];
  void updateMealPlanList(List<PlannedMeal>meals){
    finalMealPlan=meals;
    notifyListeners();
  }
  void updateTabIndex(int tabIndex){
    currentPageIndex=tabIndex;
    notifyListeners();
  }
  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
   notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients.remove(ingredient);
    notifyListeners();
  }
  void setCriticalStatus(bool isCritical){
    this.isCritical=isCritical;
    notifyListeners();
  }
  void updateIngredient(Ingredient oldIngredient, Ingredient newIngredient) {
    final index = ingredients.indexOf(oldIngredient);
    if (index != -1) {
      ingredients[index] = newIngredient;
      notifyListeners();
    }
  }

  void updateIngredientQuantities(List<PlannedMeal> mealPlan) {
    for (var plannedMeal in mealPlan) {
      final meal = plannedMeal.selectedMeal;
      if (meal != null) {
        final servings = plannedMeal.servings ?? 0;
        for (var ingredient in meal.mealIngredients) {
          final requiredQuantity = ingredient.quantity * servings;

          final index = ingredients.indexWhere((item) => item.ingredientName == ingredient.ingredientName);
          if (index != -1) {
            ingredients[index].quantity -= requiredQuantity;
          }
        }
      }
    }
   notifyListeners();
  }
}
