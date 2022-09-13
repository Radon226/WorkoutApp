class Exercise {
  var animation;
  String name;
  bool untilFailure = false;
  int time;
  int reps;
  int sets;

  Exercise(
      {required this.animation,
      required this.name,
      required this.untilFailure,
      required this.time,
      required this.sets,
      required this.reps});
}
