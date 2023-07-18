import 'package:radons_workout_app/essentials/workout.dart';
import 'exercise.dart';

class WorkoutCreator {

  //assigns workout to corresponding day and adds them to array weekRoutine
  List<Workout> createWorkouts(int sets, hardReps, mediumReps, easyReps, double time) {
    Workout upperBody1;
    Workout lowerBody2;
    Workout rest3;
    Workout upperBody4;
    Workout lowerBody5;
    Workout rest6;
    Workout test7;

    DateTime today = DateTime.now();

    upperBody1 = createWorkout('UPPER', 60, today, 0);
    lowerBody2 = createWorkout('LOWER', 60, today.add(const Duration(days: 1)), 1);
    rest3 = createWorkout('REST', 0, today.add(const Duration(days: 2)), 3);
    upperBody4 = createWorkout('UPPER', 60, today.add(const Duration(days: 3)), 0);
    lowerBody5 = createWorkout('LOWER', 60, today.add(const Duration(days: 4)), 1);
    rest6 = createWorkout('REST', 0, today.add(const Duration(days: 5)), 3);
    test7 = createWorkout('TEST', 60, today.add(const Duration(days: 6)), 2);

    return <Workout>[
      upperBody1,
      lowerBody2,
      rest3,
      upperBody4,
      lowerBody5,
      rest6,
      test7,
    ];
  }

  //returns workout object
  //workoutType: 0 if upper, 1 if lower, 2 if test, 3 or any other number is rest
  //Exercise(this._name, this._type, this._sets, this._reps, this._time);
  Workout createWorkout(String name, int restTime, DateTime date, int workoutType) 
  {
    List<Exercise> upperExercises = createUpperExercises(5, 5, 5, 5, 5);
    List<Exercise> lowerExercises = createLowerExercises(5, 5, 5, 5, 5);
    List<Exercise> testExercises = 
    [
      //warmups
      Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
      Exercise(name: 'Arm Circles', type: 0, sets: 0, reps: 2, time: 20),
      Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

      //main UPPER BODY EXERCISES (6)
      Exercise(name: 'Pushups', type: 1, sets: 1, reps: 0, time: 60),
      Exercise(name: 'Pullups', type: 1, sets: 1, reps: 0, time: 60),

      Exercise(name: 'Squats', type: 1, sets: 1, reps: 0, time: 60),
      Exercise(name: 'Split Squats', type: 1, sets: 1, reps: 0, time: 60)
    ];
    List<Exercise> restExercises = [Exercise(name: 'Rest', type: 0, sets: 0, reps: 0, time: 9999)];

    if (workoutType == 0) {
      return Workout(
          name: name,
          restPerSet: restTime,
          date: date,
          listOfExcercs: upperExercises,
          isFinished: false);
    }

    if (workoutType == 1) {
      return Workout(
          name: name,
          restPerSet: restTime,
          date: date,
          listOfExcercs: lowerExercises,
          isFinished: false);
    }

    if (workoutType == 2)
    {
      return Workout(
        name: name,
        restPerSet: restTime,
        date: date,
        listOfExcercs: testExercises,
        isFinished: false);
    }

    return Workout(
        name: name,
        restPerSet: restTime,
        date: date,
        listOfExcercs: restExercises,
        isFinished: false);
  }

  //returns a custom list of exercises
  List<Exercise> createUpperExercises(int sets, hardReps, mediumReps, easyReps, double time) =>
  [
    //warmups
    Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
    Exercise(name: 'Arm Circles', type: 0, sets: 2, reps: 20, time: 0),
    Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

    //main UPPER BODY EXERCISES (6)
    Exercise(name: 'Pushups', type: 1, sets: sets, reps: mediumReps, time: time),
    Exercise(name: 'Dips', type: 1, sets: sets, reps: mediumReps, time: time),
    Exercise(name: 'Rows', type: 1, sets: sets, reps: hardReps, time: time),
    Exercise(name: 'Pullups', type: 1, sets: sets, reps: hardReps, time: time),
    Exercise(name: 'Chinups', type: 1, sets: sets, reps: hardReps, time: time),
    Exercise(name: 'Planks', type: 1, sets: sets, reps: 0, time: time),
    Exercise(name: 'Bicycle Crunches', type: 1, sets: sets, reps: mediumReps, time: time),

    //STRETCHES AFTER UPPER WORKOUT (5)
    Exercise(name: 'Arm Wrist Stretch', type: 2, sets: 2, reps: 0, time: time / 2),
    Exercise(name: 'Child Pose', type: 2, sets: 0, reps: 0, time: time),
    Exercise(name: 'Cobra Pose', type: 2, sets: 0, reps: 0, time: time),
    Exercise(name: 'Bicep Stretch', type: 2, sets: 0, reps: 0, time: time),
    Exercise(name: 'Tricep Stretch', type: 2, sets: 0, reps: 0, time: time),
  ];

  List<Exercise> createLowerExercises(int sets, hardReps, mediumReps, easyReps, double time) =>
  [
    //warmups
    Exercise(name: 'Jumping Jacks', type: 0, sets: 0, reps: 0, time: 60),
    Exercise(name: 'Arm Circles', type: 0, sets: 2, reps: 20, time: 0),
    Exercise(name: 'Side Planks', type: 0, sets: 2, reps: 0, time: 45),

    //main LOWER BODY EXERCISES (6)
    Exercise(name: 'Calf Raises', type: 1, sets: sets, reps: mediumReps, time: time),
    Exercise(name: 'Glute Bridges', type: 1, sets: sets, reps: easyReps, time: time),
    Exercise(name: 'Squats', type: 1, sets: sets, reps: mediumReps, time: time),
    Exercise(
        name: 'Split Squats',
        type: 1,
        sets: sets,
        reps: hardReps,
        time: time),
    Exercise(
        name: 'Lateral Lunges',
        type: 1,
        sets: sets,
        reps: mediumReps,
        time: time),

    //STRETCHES AFTER LOWER WORKOUT (4)
    Exercise(
        name: 'Quad Stretch', type: 2, sets: 2, reps: 0, time: time / 2),
    Exercise(
        name: 'Side Lunge Stretch',
        type: 2,
        sets: 2,
        reps: 0,
        time: time / 2),
    Exercise(
        name: 'Hamstring Stretch',
        type: 2,
        sets: 2,
        reps: 0,
        time: time / 2),
    Exercise(name: 'Butterfly', type: 2, sets: 0, reps: 0, time: time),
  ];
}