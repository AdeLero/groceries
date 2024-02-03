import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/ingredient_model.dart';
import 'package:groceries/models/meal_type_model.dart';
import 'package:groceries/models/planned_meal_model.dart';
import 'package:groceries/screens/create_meal_page.dart';
import 'package:groceries/screens/ingredients/ingredients_inventory.dart';
import 'package:groceries/screens/lists_page.dart';
import 'package:groceries/screens/meal_plan_page.dart';
import 'package:groceries/screens/meal_time/meal_time_countdown.dart';
import 'package:groceries/screens/meal_time/meal_time_provider.dart';
import 'package:groceries/screens/more_screen.dart';
import 'package:groceries/screens/stats_screen.dart';
import 'package:groceries/widgets/ingredient_display_widget.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Inventory>(
        builder: (context, inventoryProvider, child) {
          return Scaffold(
            body: <Widget>[
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HI USER,',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateMeal(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                size: 36,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Here's what's on the menu...",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MealPlanPage(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (inventoryProvider.finalMealPlan.isNotEmpty)
                          SizedBox(
                            height: 150,
                            child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: inventoryProvider.finalMealPlan.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.violet,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (inventoryProvider.finalMealPlan[index]
                                            .selectedMeal!
                                            .image !=
                                            null)
                                          Image.file(
                                            File(inventoryProvider.finalMealPlan[index]
                                                .selectedMeal!
                                                .image!),
                                            height: 95,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          )
                                        else
                                          Container(
                                            width: 150,
                                            height: 95,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: CustomColors.landoYellow,
                                            ),
                                          ),
                                        Positioned(
                                          bottom: 0,
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      getMealTypeString(
                                                          inventoryProvider.finalMealPlan[index]
                                                              .mealType),
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Popular',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        color: CustomColors
                                                            .lightBrown,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      inventoryProvider.finalMealPlan[index]
                                                          .selectedMeal!
                                                          .mealName,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${inventoryProvider.finalMealPlan[index].servings.toString()} servings',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 8),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Center(
                            child: Text(
                              'You have not Planned any meals yet',
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<MealTimeProvider>(
                            builder: (context, mealTimeProvider, child) {
                              return MealTimeCountdown(
                                breakfastTime: mealTimeProvider.breakfastTime,
                                lunchTime: mealTimeProvider.lunchTime,
                                dinnerTime: mealTimeProvider.dinnerTime,
                              );
                            }
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealPlanPage(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                            MaterialStateProperty.all(CustomColors.lightgrey),
                            side: MaterialStateProperty.all(
                              BorderSide(color: CustomColors.violet),
                            ),
                            fixedSize: MaterialStateProperty.all(
                              Size(320, 30),
                            ),
                          ),
                          child: Text(
                            'Plan your meals',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.deepBlue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Here's your Grocery List",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (inventoryProvider.ingredients.isNotEmpty)
                          Container(
                            height: 150,
                            child: IngredientDisplayWidget(),
                          )
                        else
                          Center(
                            child: Text(
                              'You have not entered any groceries',
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Days till next shopping trip',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CustomColors.deepBlue,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '00',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                  Text(
                                    'days',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Lists(),
              StatsScreen(),
              MoreScreen(),
            ][inventoryProvider.currentPageIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: CustomColors.violet,
              unselectedItemColor: CustomColors.purple,
              currentIndex: inventoryProvider.currentPageIndex,
              showUnselectedLabels: true,
              iconSize: 20,
              onTap: (int index) {
                inventoryProvider.updateTabIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month_sharp,
                  ),
                  label: 'Plan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.set_meal,
                  ),
                  label: 'Meals',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.query_stats,
                  ),
                  label: 'Stats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  label: 'More',
                ),
              ],
            ),
          );
        }
    );
  }


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
}

