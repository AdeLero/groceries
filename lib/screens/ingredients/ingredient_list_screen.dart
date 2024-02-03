import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/screens/ingredients/add_ingredient_page.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';

class IngredientListScreen extends StatefulWidget {
  const IngredientListScreen({super.key});

  @override
  State<IngredientListScreen> createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  final Inventory inventory = Inventory();
  late List<Ingredient> ingredientList = inventory.ingredients.value;

  @override
  Widget build(BuildContext context) {
    return ingredientList != null && ingredientList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder(
              valueListenable: inventory.ingredients,
              builder: (context, ingredient, child) {
                return ListView.builder(
                    itemCount: ingredientList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ingredientList[index].ingredientName,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${ingredientList[index].quantity} ${ingredient[index].primaryunitOfMeasurement.toString()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                if (ingredientList[index].isCritical)
                                  Text(
                                    'critical',
                                    style: TextStyle(
                                        color: CustomColors.purple, fontSize: 10),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have Not created any Ingredients yet',
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(320, 35),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      BorderSide(color: CustomColors.deepBlue),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddIngredient(),
                      ),
                    );
                  },
                  child: Text(
                    'Create an ingredient',
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomColors.violet,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
