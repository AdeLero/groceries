import 'dart:async';
import 'package:flutter/material.dart';
import 'package:groceries/customization/colors.dart';

class MealTimeCountdown extends StatefulWidget {
  final TimeOfDay breakfastTime;
  final TimeOfDay lunchTime;
  final TimeOfDay dinnerTime;

  const MealTimeCountdown({
    Key? key,
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
  }) : super(key: key);

  @override
  _MealTimeCountdownState createState() => _MealTimeCountdownState();
}

class _MealTimeCountdownState extends State<MealTimeCountdown> {
  late String _mealType;
  late DateTime _nextMealTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeMealType();
    _updateNextMealTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeMealType() {
    _updateMealType();

    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _updateMealType();
    });
  }

  void _updateMealType() {
    DateTime now = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.fromDateTime(now);


    if (currentTime.hour < widget.breakfastTime.hour ||
        (currentTime.hour == widget.breakfastTime.hour &&
            currentTime.minute < widget.breakfastTime.minute)) {
      setState(() {
        _mealType = 'Breakfast';
      });
    } else if (currentTime.hour < widget.lunchTime.hour ||
        (currentTime.hour == widget.lunchTime.hour &&
            currentTime.minute < widget.lunchTime.minute)) {
      setState(() {
        _mealType = 'Lunch';
      });
    } else if (currentTime.hour < widget.dinnerTime.hour ||
        (currentTime.hour == widget.dinnerTime.hour &&
            currentTime.minute < widget.dinnerTime.minute)) {
      setState(() {
        _mealType = 'Dinner';
      });
    } else {
      setState(() {
        _mealType = 'Breakfast';
      });
    }
  }

  void _updateNextMealTime() {
    DateTime now = DateTime.now();

    switch (_mealType) {
      case 'Breakfast':
        _nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.breakfastTime.hour,
          widget.breakfastTime.minute,
        );
        break;
      case 'Lunch':
        _nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.lunchTime.hour,
          widget.lunchTime.minute,
        );
        break;
      case 'Dinner':
        _nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.dinnerTime.hour,
          widget.dinnerTime.minute,
        );
        break;
      default:
        _nextMealTime = DateTime.now();
        break;
    }

    if (_nextMealTime.isBefore(now)) {
      _nextMealTime = _nextMealTime.add(Duration(days: 1));
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _updateNextMealTime();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.lightGreen,
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time Until Next $_mealType:',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20),
          _buildCountdownTimer(),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer() {
    Duration timeDifference = _nextMealTime.difference(DateTime.now());

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${timeDifference.inHours}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              'hr',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              '${timeDifference.inMinutes.remainder(60)}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              ' min',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              '${timeDifference.inSeconds.remainder(60)}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              ' sec',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
