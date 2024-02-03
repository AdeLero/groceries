import 'package:flutter/material.dart';
import 'package:groceries/screens/meal_time/meal_time_provider.dart';
import 'package:provider/provider.dart';

class MealTimeSettings extends StatefulWidget {
  const MealTimeSettings({super.key});

  @override
  State<MealTimeSettings> createState() => _MealTimeSettingsState();
}

class _MealTimeSettingsState extends State<MealTimeSettings> {
  late TimeOfDay breakfastTime;
  late TimeOfDay lunchTime;
  late TimeOfDay dinnerTime;

  @override
  void initState() {
    super.initState();
    breakfastTime = TimeOfDay.now();
    lunchTime = TimeOfDay.now();
    dinnerTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMealTimeRow('Breakfast', breakfastTime, (time) {
              setState(() {
                breakfastTime = time;
              });
            }),
            _buildMealTimeRow('Lunch', lunchTime, (time) {
              setState(() {
                lunchTime = time;
              });
            }),
            _buildMealTimeRow('Dinner', dinnerTime, (time) {
              setState(() {
                dinnerTime = time;
              });
            }),
            ElevatedButton(
              onPressed: () {
                Provider.of<MealTimeProvider>(context, listen: false)
                    .setMealTimes(
                  breakfastTime: breakfastTime,
                  lunchTime: lunchTime,
                  dinnerTime: dinnerTime,
                );
                Navigator.pop(context);
              },
              child: Text('Save Meal Times'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTimeRow(
      String label, TimeOfDay time, Function(TimeOfDay) onTimeSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          TextButton(
            onPressed: () => _selectTime(context, time, onTimeSelected),
            child: Text(time.format(context)),
          ),
        ],
      ),
    );
  }
}
