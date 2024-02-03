import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key});

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  TextEditingController _ingredientNameController = TextEditingController();
  TextEditingController _ingredientQuantityController = TextEditingController();
  TextEditingController _ingredientCriticalQuantityController =
      TextEditingController();
  TextEditingController _ingredientUnitOfMeasurementController =
      TextEditingController();
  TextEditingController _ingredientSUOM = TextEditingController();
  TextEditingController _ingredientCF = TextEditingController();
  final Inventory inventory = Inventory();
  void _addIngredient() {
    final ingredientName = _ingredientNameController.text;
    final ingredientQuantity = double.parse(_ingredientQuantityController.text);
    final ingredientCriticalQuantity =
        double.parse(_ingredientCriticalQuantityController.text);
    final ingredientUOM = _ingredientUnitOfMeasurementController.text;
    final ingredientSUOM = _ingredientSUOM.text;
    final ingredientCF = double.parse(_ingredientCF.text);
    final newIngredient = Ingredient(
        ingredientName: ingredientName,
        quantity: ingredientQuantity,
        criticalQuantity: ingredientCriticalQuantity,
        primaryunitOfMeasurement: ingredientUOM,
      secondaryUnitofMeasurement: ingredientSUOM,
      conversionFactor: ingredientCF
    );

    inventory.addIngredient(newIngredient);


    _ingredientUnitOfMeasurementController.clear();
    _ingredientSUOM.clear();
    _ingredientCF.clear();
    _ingredientQuantityController.clear();
    _ingredientCriticalQuantityController.clear();
    _ingredientNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ADD AN INGREDIENT',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _ingredientNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _ingredientQuantityController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Minimum Quantity',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _ingredientCriticalQuantityController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Primary Unit of Measurement',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _ingredientUnitOfMeasurementController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Secondary unit of measurement',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _ingredientSUOM,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          Text(
                            'How many unit of Primary makes one (1) of this?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 80,
                            height: 35,
                            child: TextField(
                              controller: _ingredientCF,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(320, 35),
                ),
                backgroundColor:
                MaterialStateProperty.all(CustomColors.deepBlue),
              ),
              onPressed: () {
                _addIngredient();
                Navigator.of(context).pop();
              },
              child: Text(
                'Create Ingredient',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
