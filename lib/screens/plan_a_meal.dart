import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';
import 'package:groceries/models/meal_model.dart';
import 'package:groceries/models/meal_type_model.dart';
import 'package:groceries/models/planned_meal_model.dart';
import 'package:groceries/screens/create_meal_page.dart';
import 'package:groceries/screens/meal_list.dart';
import 'package:groceries/widgets/calendar_button.dart';
import 'package:intl/intl.dart';

class PlanAMeal extends StatefulWidget {
  const PlanAMeal({super.key});

  @override
  State<PlanAMeal> createState() => _PlanAMealState();
}

class _PlanAMealState extends State<PlanAMeal> {
  List<PlannedMeal> plannedMealList = plannedMeals.value;

  Meal? _selectedMeal;
  late DateTime? selectedDay = DateTime.now();
  late String _dateText;
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<MealType> mealTypes = [
    MealType.Breakfast,
    MealType.Lunch,
    MealType.Dinner,
  ];

  MealType _selectedMealType = MealType.Breakfast;


  void _showMealBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MealList(
            onMealSelected: (meal) {
              setState(() {
                _selectedMeal = meal;
              });
            },
          );
        });
  }

  void _showCalendarBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CalendarButton(
              selectedDay: selectedDay,
              onDateSelected: (newDate) {
                if (newDate != null) {
                  setState(() {
                    selectedDay = newDate;
                    _dateText = DateFormat('dd/MM/yyyy (E)').format(newDate);
                  });
                }
                Navigator.pop(context);
              });
        });
  }

  void _createPlannedMeal() {
    if (_selectedMeal == null) {
      return;
    }
    final selectedMealType = _selectedMealType;
    final selectedMeal = _selectedMeal;
    double serving = double.parse(_servingsController.text);
    final dates = selectedDay;
    final notes = _notesController.text;

    PlannedMeal newPlannedMeal = PlannedMeal(
      mealType: selectedMealType,
      selectedMeal: selectedMeal,
      servings: serving,
      date: dates,
      note: notes,
    );

    plannedMealList.add(newPlannedMeal);

    plannedMeals.value = List.from(plannedMeals.value);

    selectedDay = null;
    _selectedMeal = null;
    _notesController.clear();
    _servingsController.clear();
  }

  @override
  void initState() {
    super.initState();
    _dateText = DateFormat('dd/MM/yyyy (E)').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'PLAN A MEAL',
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
                  builder: (context) => CreateMeal(),
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal Type',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(mealTypes.length, (index) {
                      final _isSelected = _selectedMealType == mealTypes[index];
                      final meal = mealTypes[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMealType = meal;
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: _isSelected
                                ? CustomColors.deepBlue
                                : CustomColors.landoYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              meal.toString().split('.').last,
                              style: TextStyle(
                                color: _isSelected
                                    ? Colors.white
                                    : CustomColors.deepBlue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Serving',
                  ),
                  TextField(
                    controller: _servingsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'How many Plates?'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal',
                  ),
                  if (_selectedMeal == null)
                    GestureDetector(
                      child: TextField(
                        onTap: () {
                          _showMealBottomSheet();
                        },
                        decoration: InputDecoration(
                          hintText: 'Choose a meal',
                        ),
                        readOnly: true,
                      ),
                    ),
                  if (_selectedMeal != null)
                    Dismissible(
                      key: Key(_selectedMeal!.mealName),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: CustomColors.indigo,
                        child: Icon(
                          Icons.delete_sweep,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          _selectedMeal = null;
                        });
                      },
                      child: Stack(
                        children: [
                          if (_selectedMeal?.image != null)
                            Image.file(
                              File(_selectedMeal!.image!),
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
                            bottom: 0,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                _selectedMeal!.mealName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateText,
                      ),
                      IconButton(
                        onPressed: _showCalendarBottomSheet,
                        icon: Icon(
                          Icons.calendar_today_sharp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                  ),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: 'Anything to note?',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredients',
                  ),
                  if (_selectedMeal != null)
                    Container(
                      height: 150,
                      child: ListView.builder(
                        itemCount: _selectedMeal?.mealIngredients.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final ingredient =
                              _selectedMeal?.mealIngredients[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ingredient!.ingredientName,
                                ),
                                Text(
                                  '${ingredient.quantity * double.parse(_servingsController.text)} ${ingredient.primaryunitOfMeasurement}',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
                  _createPlannedMeal();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Create Meal',
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

//TODO The value of the servings doesn't automatically update the ingredients in multiplication;
