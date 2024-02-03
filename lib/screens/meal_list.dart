import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/meal_model.dart';

class MealList extends StatefulWidget {
  final Function(Meal)? onMealSelected;
  const MealList({super.key, this.onMealSelected});

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  final mealList = meals.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: ValueListenableBuilder<List<Meal>>(
          valueListenable: meals,
          builder: (context, meals, child) {
            return ListView.builder(
                itemCount: mealList.length,
                itemBuilder: (BuildContext context, int index) {
                  Meal meal = mealList[index];

                  return GestureDetector(
                    onTap: () {
                      widget.onMealSelected?.call(meal);
                      Navigator.pop(context);
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
                            ) else Container(
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
                }
            );
          },
        ),
      ),
    );
  }
}
