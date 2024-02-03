import 'package:flutter/cupertino.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';

class IngredientDisplayWidget extends StatefulWidget {
  const IngredientDisplayWidget({super.key});

  @override
  State<IngredientDisplayWidget> createState() => _IngredientDisplayWidgetState();
}

class _IngredientDisplayWidgetState extends State<IngredientDisplayWidget> {
  List<Ingredient> ingredientList = ingredients.value;
  bool isCritical = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Ingredient>>(
      valueListenable: ingredients,
      builder: (context, ingredient, child) {
        return ListView.builder(
            itemCount: ingredients.value.length,
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
                        ingredient[index].ingredientName,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${ingredient[index].quantity} ${ingredient[index].primaryunitOfMeasurement.toString()}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          if (ingredient[index].isCritical)
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
