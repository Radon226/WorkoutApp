import 'package:radons_workout_app/essentials/workout.dart';
import 'package:radons_workout_app/essentials/exercise.dart';

//should only be created once a week
class WeeklyRoutine {
  List<Workout> _weekRoutine = [];
  final int _week;
  final DateTime _dateCreated;

  WeeklyRoutine(this._week, this._dateCreated);

  //name, restPerSet
  late Workout _upperBody1;
  late Workout _lowerBody2;
  late Workout _rest3;
  late Workout _upperBody4;
  late Workout _lowerBody5;
  late Workout _rest6;
  late Workout _test7;

  //assigns workout to corresponding day
  void createWorkouts(int sets, hardReps, mediumReps, easyReps, double time) {
    _upperBody1 = Workout('UPPER', 60, _dateCreated);
    _lowerBody2 =
        Workout('LOWER', 60, _dateCreated.add(const Duration(days: 1)));
    _rest3 = Workout('REST', 0, _dateCreated.add(const Duration(days: 2)));
    _upperBody4 =
        Workout('UPPER', 60, _dateCreated.add(const Duration(days: 3)));
    _lowerBody5 =
        Workout('LOWER', 60, _dateCreated.add(const Duration(days: 4)));
    _rest6 = Workout('REST', 0, _dateCreated.add(const Duration(days: 5)));
    _test7 = Workout('TEST', 60, _dateCreated.add(const Duration(days: 6)));

    addUpperExercises(_upperBody1, sets, hardReps, mediumReps, easyReps, time);
    addUpperExercises(_upperBody4, sets, hardReps, mediumReps, easyReps, time);

    addLowerExercises(_lowerBody2, sets, hardReps, mediumReps, easyReps, time);
    addLowerExercises(_lowerBody5, sets, hardReps, mediumReps, easyReps, time);

    _weekRoutine = [
      _upperBody1,
      _lowerBody2,
      _rest3,
      _upperBody4,
      _lowerBody5,
      _rest6,
      _test7,
    ];
  }

  void addUpperExercises(
      Workout workout, int sets, hardReps, mediumReps, easyReps, double time) {
    //UPPER BODY EXERCISES (7)
    workout.addExercise(Exercise('Pushups', sets, mediumReps, time));
    workout.addExercise(Exercise('Dips', sets, mediumReps, time));
    workout.addExercise(Exercise('Rows', sets, hardReps, time));
    workout.addExercise(Exercise('Pullups', sets, hardReps, time));
    workout.addExercise(Exercise('Chinups', sets, hardReps, time));
    workout.addExercise(Exercise.timeOnly('Planks', sets, time));

    //STRECHES AFTER UPPER WORKOUT (5)
    workout.addStretch(Exercise.timeOnly('Arm And Wrist Stretch', 2, time / 2));
    workout.addStretch(Exercise.timeOnly('Child Pose', 0, time));
    workout.addStretch(Exercise.timeOnly('Cobra Pose', 0, time));
    workout.addStretch(Exercise.timeOnly('Bicep Stretch', 0, time));
    workout.addStretch(Exercise.timeOnly('Tricep Stretch', 0, time));
  }

  void addLowerExercises(
      Workout workout, int sets, hardReps, mediumReps, easyReps, double time) {
    //LOWER BODY EXERCISES (6)
    workout.addExercise(Exercise('Calf Raises', sets, mediumReps, time));
    workout.addExercise(Exercise('Glute Bridges', sets, easyReps, time));
    workout.addExercise(Exercise('Squats', sets, mediumReps, time));
    workout.addExercise(Exercise('Split Squats', sets, hardReps, time));
    workout.addExercise(Exercise('Lateral Lunges', sets, mediumReps, time));
    workout.addExercise(Exercise('Bicycle Crunches', sets, mediumReps, time));

    //STRETCHES AFTER LOWER WORKOUT (4)
    workout.addStretch(Exercise.timeOnly('Quad Stretch', 2, time / 2));
    workout.addStretch(Exercise.timeOnly('Side Lunge Stretch', 2, time / 2));
    workout.addStretch(Exercise.timeOnly('Hamstring Stretch', 2, time / 2));
    workout.addStretch(Exercise.timeOnly('Butterfly', 0, time));
  }

  List<Workout> getWeekRoutine() => _weekRoutine;
  int getWeek() => _week;
}
