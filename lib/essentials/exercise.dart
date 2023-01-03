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
import 'dart:developer';

class Exercise {
  //var _animation;
  final String name;

  //warmup 0, main exercise 1, stretch 2
  final int type;
  final int sets;
  final int reps;
  final double time;

  //make exercise that uses time (3 sets of 1 min plank), time in seconds
  Exercise({required this.name,
            required this.type,
            required this.sets,
            required this.reps,
            required this.time});

  String getName() => name;
  int getType() => type;
  int getSet() => sets;
  int getReps() => reps;
  double getTime() => time;

  //will have to figure out how to convert a gif file or anim file into json later
  //parameters must be in exact order of the constructor that was made
  Map<String, Object?> toJson() => {
        'name': name,
        'type': type,
        'sets': sets,
        'reps': reps,
        'time': time,
      };

  factory Exercise.fromJson(Map<String, Object?> json) {
    //log('exercise - fromJson(): returning Exercise.fromJson');
    //log('exercise - fromJson(): jsonExercName -> ${json['name']}');

    return Exercise(
      name: json['name'] as String,
      type: json['type'] as int,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      time: json['time'] as double,
    );
  }
}
