import 'package:flutter/cupertino.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';

class IngredientDisplayWidget extends StatefulWidget {
  const IngredientDisplayWidget({super.key});

  @override
  State<IngredientDisplayWidget> createState() => _IngredientDisplayWidgetState();
}

class _IngredientDisplayWidgetState extends State<IngredientDisplayWidget> {
  final Inventory inventory = Inventory();
  late List<Ingredient> ingredientList = inventory.ingredients.value;
  bool isCritical = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Ingredient>>(
      valueListenable: inventory.ingredients,
      builder: (context, ingredients, child) {
        return ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 320,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ingredients[index].ingredientName,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${ingredients[index].quantity} ${ingredients[index].primaryunitOfMeasurement.toString()}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          if (ingredients[index].isCritical)
                            Text(
                            'critical',
                            style: TextStyle(
                                color: CustomColors.purple, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }
}
