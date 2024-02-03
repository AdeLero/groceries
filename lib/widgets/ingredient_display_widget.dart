import 'package:flutter/cupertino.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';
import 'package:provider/provider.dart';

class IngredientDisplayWidget extends StatelessWidget {
  const IngredientDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Inventory>(
        builder: (context, inventoryProvider, child) {
          if(inventoryProvider.ingredients.isNotEmpty){
            return ListView.builder(
                itemCount: inventoryProvider.ingredients.length,
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
                  );
                }
            );
          }else{
            return Text("Empty inventory");
          }
        }
    );
  }
}

