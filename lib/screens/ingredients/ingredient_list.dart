import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';
import 'package:groceries/screens/ingredients/add_ingredient_page.dart';
import 'package:provider/provider.dart';

class IngredientList extends StatefulWidget {
  final Function(Ingredient) onIngredientSelected;
  const IngredientList({super.key, required this.onIngredientSelected});

  @override
  State<IngredientList> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Inventory>(
        builder: (context, inventoryProvider, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'CHOOSE INGREDIENT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop;
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddIngredient(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  itemCount: inventoryProvider.ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onIngredientSelected(inventoryProvider.ingredients[index]);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 320,
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                inventoryProvider.ingredients[index].ingredientName,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${inventoryProvider.ingredients[index].quantity} ${inventoryProvider.ingredients[index].primaryunitOfMeasurement.toString()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (inventoryProvider.ingredients[index].isCritical)
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
                      ),
                    );
                  }),
            ),
          );
        }
    );
  }
}

// TODO fix the issue regarding the implementation of the inventory