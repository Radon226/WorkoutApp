import 'package:radons_workout_app/essentials/exercise.dart';

//mainly use to make workout for the DAY
//example: want to make a workout list for upper body for day 1 and lower body for day 2
//another example is workout list for test day
//should be a list of exercises and nothing else

//often, there is rest between each set and each exercise
//perhaps a method that automatically adds a rest "exercise" between each set and exercise
//instead of having to manually add them
//however, when working out, we want the app to move to one element(exercise) to the next
//need to make a concept of when user is doing exercise that requires sets and reps
class Workout {
  String _name;
  int _restPerSet;
  late int _lengthOfWork;

  DateTime _date;

  bool _isFinished = false;

  Workout(this._name, this._restPerSet, this._date);

  List<Exercise> _listOfWarmups = [
    Exercise.timeOnly('Jumping Jacks', 0, 60),
    Exercise.repsOnly('Arm Circles', 2, 20),
    Exercise.timeOnly('Side Planks', 2, 45) //45s each side, hence 2 sets
  ];

  List<Exercise> _listOfExerc = [];

  List<Exercise> _listOfStretches = [];

  void addExercise(Exercise exercise) {
    _listOfExerc.add(exercise);
  }

  void addWarmup(Exercise exercise) {
    _listOfWarmups.add(exercise);
  }

  void addStretch(Exercise exercise) {
    _listOfStretches.add(exercise);
  }

  //return workout list
  List getExerc() => _listOfExerc;
  List getWarmup() => _listOfWarmups;
  List getStretch() => _listOfStretches;

  String getName() => _name;
  int getRestPerSet() => _restPerSet;
  DateTime getDate() => _date;
  bool getStateOfWorkout() => _isFinished;

  void finishWorkout() {
    _isFinished = true;
  }

  void setDate(DateTime date) {
    _date = date;
  }

  void setName(String name) {
    _name = name;
  }

  void printWorkout() {
    int length = _listOfExerc.length;
    print('Workout: $_name || $length');
    for (int i = 0; i < length; i++) {
      print('$i ' + _listOfExerc[i].getName());
    }
  }
}
