import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/screens/ingredients/add_ingredient_page.dart';
import 'package:groceries/screens/create_meal_page.dart';
import 'package:groceries/screens/ingredients/ingredient_list_screen.dart';
import 'package:groceries/screens/meal_list_screen.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'YOUR MEAL LIST',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'ingredients') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddIngredient(),
                  ),
                );
              } else if (value == 'meals') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMeal(),
                    ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'ingredients',
                child: Text('Ingredients'),
              ),
              PopupMenuItem<String>(
                value: 'meals',
                child: Text('Meals'),
              ),
            ],
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: CustomColors.deepBlue,
              indicatorColor: CustomColors.indigo,
              tabs: [
                Tab(text: 'Meals'),
                Tab(text: 'Ingredients'),
              ],
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.60,
              child: TabBarView(
                children: [
                  MealListScreen(),
                  IngredientListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
