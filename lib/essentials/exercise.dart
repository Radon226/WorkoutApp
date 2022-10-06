//an exercise should be an exercise
//exercise can be many things
/*
  ex:
  rest for 1 min
  3 sets of 10 pushups 
  3 sets of pushups until failure
  3 sets of 1 min plank
*/
//should be an animation and name for all exercises
// _variable sets it to private
// no underline means public
class Exercise {
  var _animation;
  String _name;
  late double _time;
  late int _reps;
  late int _sets;

  //make exercise that uses time (3 sets of 1 min plank), time in seconds
  Exercise(this._name, this._sets, this._reps, this._time);
  Exercise.timeOnly(this._name, this._sets, this._time);
  Exercise.repsOnly(this._name, this._sets, this._reps);

  String getName() {
    return _name;
  }

  double getTime() {
    return _time;
  }

  int getReps() {
    return _reps;
  }

  int getSet() {
    return _sets;
  }
}
