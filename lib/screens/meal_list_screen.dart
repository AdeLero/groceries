import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/meal_model.dart';
import 'package:groceries/screens/create_meal_page.dart';
import 'package:groceries/screens/edit_meal_screen.dart';

class MealListScreen extends StatefulWidget {
  final Function(Meal)? onMealSelected;
  const MealListScreen({super.key, this.onMealSelected});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  void _navigateToEditMealScreen(Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMeal(meal: meal),
      ),
    );
  }

  final mealList = meals.value;

  @override
  Widget build(BuildContext context) {
    return mealList != null && mealList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<List<Meal>>(
              valueListenable: meals,
              builder: (context, meals, child) {
                return ListView.builder(
                    itemCount: mealList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Meal meal = mealList[index];
                      return GestureDetector(
                        onTap: () {
                          _navigateToEditMealScreen(meal);
                        },
                        child: Container(
                          color: CustomColors.deepBlue,
                          child: Row(
                            children: [
                              if (meal.image != null)
                                Image.file(
                                  File(meal.image!),
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              else
                                Container(
                                  height: 80,
                                  width: 80,
                                  color: CustomColors.landoYellow,
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  meal.mealName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                  'You have Not created any meals yet',
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
                        builder: (context) => CreateMeal(),
                      ),
                    );
                  },
                  child: Text(
                    'Create a meal',
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
