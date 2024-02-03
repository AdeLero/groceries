import 'package:flutter/material.dart';
import 'package:groceries/models/planned_meal_model.dart';

class Ingredient {
  String ingredientName;
  double quantity;
  double? criticalQuantity;
  String primaryunitOfMeasurement;
  String? secondaryUnitofMeasurement;
  double? conversionFactor;

  Ingredient({
    required this.ingredientName,
    required this.quantity,
    this.criticalQuantity,
    required this.primaryunitOfMeasurement,
    this.secondaryUnitofMeasurement,
    this.conversionFactor,
});
  bool get isCritical => criticalQuantity != null && quantity <= criticalQuantity!;
}


