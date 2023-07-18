import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:radons_workout_app/essentials/exercise.dart';

// REQUIREMENTS:
// one workout represents one day
// a workout contains a list of exercises, one list for warmups, one for main, and one for stretching

//mainly use to make workout for the DAY
//example: want to make a workout list for upper body for day 1 and lower body for day 2
//another example is workout list for test day
//should be a list of exercises and nothing else

//often, there is rest between each set and each exercise
//perhaps a method that automatically adds a rest "exercise" between each set and exercise
//instead of having to manually add them
//however, when working out, we want the app to move to one element(exercise) to the next
//need to make a concept of when user is doing exercise that requires sets and reps

class WorkoutFields {
  static final List<String> values = [name, restPerSet, date, listOfExercs];

  static const String name = 'name';
  static const String restPerSet = 'restPerSet';
  static const String date = 'date';
  static const String listOfExercs = 'listOfExercs';
  static const String isFinished = 'isFinished';
}

class Workout {
  String name;
  final int restPerSet;
  DateTime date;
  bool isFinished = false;
  List<Exercise> listOfExcercs;

  Workout
  ({required this.name,
    required this.restPerSet,
    required this.date,
    required this.listOfExcercs, 
    required this.isFinished});

  void addExercise(Exercise exercise) {
    listOfExcercs.add(exercise);
  }

  String getName() => name;
  int getRestPerSet() => restPerSet;
  DateTime getDate() => date;
  List<Exercise> getListOfExercs() => listOfExcercs;
  bool getStateOfWorkout() => isFinished;

  void finishWorkout() {
    isFinished = true;
  }

  void setDate(DateTime date) {
    date = date;
  }

  void setName(String name) {
    name = name;
  }

  Map<String, Object?> toJson() {
    List<Map> _listOfExcercs = listOfExcercs.map((i) => i.toJson()).toList();

    //converts date object to a formatted string
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);

    final map = {
      WorkoutFields.name: name,
      WorkoutFields.date: formattedDate,
      WorkoutFields.restPerSet: restPerSet,
      WorkoutFields.isFinished: isFinished,
      WorkoutFields.listOfExercs: _listOfExcercs,
    };

    return map;
  }

  factory Workout.fromJson(Map<String, Object?> json) {
    //converts json to map list
    var exercJsonToList = (json[WorkoutFields.listOfExercs]) as List;

    List<Exercise> _listOfExercs =
        exercJsonToList.map((i) => Exercise.fromJson(i)).toList();

    //log('workout - fromJson(): called Exercise.fromJson');

    var formatter = DateFormat('yyyy-MM-dd'); // Save this to DB
    DateTime date = formatter.parse(json['date'] as String);

    return Workout(
        name: json[WorkoutFields.name] as String,
        restPerSet: json[WorkoutFields.restPerSet] as int,
        date: date,
        listOfExcercs: _listOfExercs,
        isFinished: json[WorkoutFields.isFinished] as bool);
  }
}
