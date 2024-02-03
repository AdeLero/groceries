import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/meal_type_model.dart';
import 'package:groceries/models/planned_meal_model.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';
import 'package:groceries/screens/plan_a_meal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  final plannedMeal = plannedMeals.value;


  String getMealTypeString(MealType mealType) {
    switch (mealType) {
      case MealType.Breakfast:
        return 'Breakfast';
      case MealType.Lunch:
        return 'Lunch';
      case MealType.Dinner:
        return 'Dinner';
      default:
        return '';
    }
  }



  void _createMealPlan (BuildContext context) {
    var inventoryProvider = Provider.of<Inventory>(context,listen: false);
    inventoryProvider.updateMealPlanList(plannedMeals.value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'YOUR MEAL PLAN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
                  builder: (context) => PlanAMeal(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: plannedMeals,
                  builder: (context, plannedMeals, child) {
                    return SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: plannedMeal.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dateText =
                          DateFormat('dd/MM').format(plannedMeal[index].date!);
                          return Container(
                            width: 320,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                if (plannedMeal[index].selectedMeal!.image != null)
                                  Image.file(
                                    File(plannedMeal[index].selectedMeal!.image!),
                                    height: 80,
                                    width: 320,
                                    fit: BoxFit.cover,
                                  )
                                else
                                  Container(
                                    height: 80,
                                    width: 320,
                                    color: CustomColors.landoYellow,
                                  ),
                                Positioned(
                                  right: 0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: CustomColors.deepBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          dateText,
                                          style: TextStyle(
                                            color: CustomColors.deepBlue,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${plannedMeal[index].servings} plates",
                                          style: TextStyle(
                                            color: CustomColors.deepBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          plannedMeal[index].selectedMeal!.mealName,
                                          style: TextStyle(
                                            color: CustomColors.deepBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          getMealTypeString(plannedMeal[index].mealType),
                                          style: TextStyle(
                                            color: CustomColors.deepBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
              ),
              ClipRRect(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanAMeal(),
                          ),
                        );
                      },
                      child: Text(
                        'Plan a meal',
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
                        _createMealPlan(context);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Finish Plan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
