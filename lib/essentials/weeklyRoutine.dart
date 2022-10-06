import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/exercise.dart';

class WeeklyRoutine {
  List<Workout> _weekRoutine = [];
  late int _timeSpentExerc; //weekly time spent working out
  late int _week;

  WeeklyRoutine();

  //name, restPerSet
  Workout _upperBody = Workout('UPPER', 60);
  Workout _lowerBody = Workout('LOWER', 60);
  Workout _rest = Workout('REST', 0);
  Workout _test = Workout('TEST', 60);

  //assigns workout to corresponding day
  void createWorkouts(int sets, hardReps, mediumReps, easyReps, double time) {
    //name, sets, reps, time
    //UPPER BODY EXERCISES (7)
    _upperBody.addExercise(Exercise('Pushups', sets, mediumReps, time));
    _upperBody.addExercise(Exercise('Dips', sets, mediumReps, time));
    _upperBody.addExercise(Exercise('Rows', sets, hardReps, time));
    _upperBody.addExercise(Exercise('Pullups', sets, hardReps, time));
    _upperBody.addExercise(Exercise('Chinups', sets, hardReps, time));
    _upperBody.addExercise(Exercise('Bicycle Crunches', sets, easyReps, time));
    _upperBody.addExercise(Exercise.timeOnly('Planks', sets, time));

    //LOWER BODY EXERCISES (6)
    _lowerBody.addExercise(Exercise('Calf Raises', sets, mediumReps, time));
    _lowerBody.addExercise(Exercise('Glute Bridges', sets, easyReps, time));
    _lowerBody.addExercise(Exercise('Squats', sets, mediumReps, time));
    _lowerBody.addExercise(Exercise('Split Squats', sets, hardReps, time));
    _lowerBody.addExercise(Exercise('Lateral Lunges', sets, mediumReps, time));
    _lowerBody
        .addExercise(Exercise('Bicycle Crunches', sets, mediumReps, time));

    //STRECHES AFTER UPPER WORKOUT (5)
    _upperBody
        .addStretch(Exercise.timeOnly('Arm And Wrist Stretch', 2, time / 2));
    _upperBody.addStretch(Exercise.timeOnly('Child Pose', 0, time));
    _upperBody.addStretch(Exercise.timeOnly('Cobra Pose', 0, time));
    _upperBody.addStretch(Exercise.timeOnly('Bicep Stretch', 0, time));
    _upperBody.addStretch(Exercise.timeOnly('Tricep Stretch', 0, time));

    //STRETCHES AFTER LOWER WORKOUT (4)
    _lowerBody.addStretch(Exercise.timeOnly('Quad Stretch', 2, time / 2));
    _lowerBody.addStretch(Exercise.timeOnly('Side Lunge Stretch', 2, time / 2));
    _lowerBody.addStretch(Exercise.timeOnly('Hamstring Stretch', 2, time / 2));
    _lowerBody.addStretch(Exercise.timeOnly('Butterfly', 0, time));

    print('I created and assigned the exercises');

    _weekRoutine = [
      _upperBody,
      _lowerBody,
      _rest,
      _upperBody,
      _lowerBody,
      _rest,
      _test,
    ];
  }

  List<Workout> getRoutine() => _weekRoutine;

  void printWeekRoutine() {
    print('Routine:');
    _upperBody.printWorkout();
    print('');
    _lowerBody.printWorkout();
    print('');
    _test.printWorkout();
  }
}
