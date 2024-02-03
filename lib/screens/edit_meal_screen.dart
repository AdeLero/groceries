import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/models/meal_model.dart';
import 'package:groceries/screens/ingredients/ingredient_list.dart';
import 'package:image_picker/image_picker.dart';

class EditMeal extends StatefulWidget {
  final Meal meal;
  const EditMeal({super.key, required this.meal});

  @override
  State<EditMeal> createState() => _EditMealState();
}

class _EditMealState extends State<EditMeal> {
  List<Ingredient> mealIngredients = [];
  final TextEditingController mealNameController = TextEditingController();
  List<TextEditingController> quantityControllers = [];
  List<Meal> mealList = meals.value;
  File? _mealImage;

  @override
  void initState() {
    super.initState();

    mealNameController.text = widget.meal.mealName;

    for(var ingredient in widget.meal.mealIngredients) {
      mealIngredients.add(ingredient);
      quantityControllers.add(TextEditingController(text: ingredient.quantity.toString()));
    }

    if (widget.meal.image !=null) {
      _mealImage = File(widget.meal.image!);
    }
  }

  void _updateMeal() {
    widget.meal.mealName = mealNameController.text;

    List<Ingredient> updatedIngredients = [];

    for (int i = quantityControllers.length; i <mealIngredients.length; i++) {
      quantityControllers.add(TextEditingController());
    }
    for (int i = 0; i < mealIngredients.length; i++) {

      if (i < quantityControllers.length) {
        widget.meal.mealIngredients[i].quantity = double.tryParse(quantityControllers[i].text) ?? 0.0;
      } else {
        widget.meal.mealIngredients[i].quantity = 0.0;
      }

      Ingredient updatedingredient = Ingredient(
          ingredientName: mealIngredients[i].ingredientName,
          quantity: mealIngredients[i].quantity,
          primaryunitOfMeasurement: mealIngredients[i].primaryunitOfMeasurement
      );
      updatedIngredients.add(updatedingredient);
    }


    widget.meal.mealIngredients = List.from(updatedIngredients);
    widget.meal.image = _mealImage?.path;

    meals.value = List.from(meals.value);
  }


  Future<void> _getImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _mealImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'CREATE A MEAL',
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    controller: mealNameController,
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
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: _getImage,
                    child: Text(
                      'Browse',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _mealImage != null
                      ? Image.file(
                    _mealImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IngredientList(
                                onIngredientSelected: (selectedIngredient) {
                                  setState(() {
                                    mealIngredients.add(selectedIngredient);
                                    quantityControllers
                                        .add(TextEditingController());
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: mealIngredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(mealIngredients[index].ingredientName),
                        onDismissed: (direction) {
                          setState(() {
                            if (index < quantityControllers.length) {
                              quantityControllers[index].dispose();
                              quantityControllers.removeAt(index);
                            }
                            mealIngredients.removeAt(index);
                          });
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: CustomColors.indigo,
                          child: Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mealIngredients[index].ingredientName,
                              ),
                              Container(
                                width: 80,
                                height: 35,
                                child: TextField(
                                  controller: quantityControllers[index],
                                  keyboardType: TextInputType.number,
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
                              Text(
                                mealIngredients[index].primaryunitOfMeasurement,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
                  _updateMeal();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Update Meal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
