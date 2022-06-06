import 'dart:io';

class Question {
  final File image;
  final List<String> answers;
  final int correctIndex;
  final int? actualIndex;
  final int? beginTimestamp;
  final int? endTimestamp;

  Question({
    required this.image,
    required this.answers,
    required this.correctIndex,
    this.actualIndex,
    this.beginTimestamp,
    this.endTimestamp,
  });
}

class TestPageModel {
  final List<Question> questions;
  final int current;
  final int? lastUpdate;
  final bool hasTimer;
  final bool hasAnswer;
  final String output;

  TestPageModel({
    required this.questions,
    required this.current,
    required this.hasTimer,
    required this.hasAnswer,
    required this.output,
    this.lastUpdate,
  });
}
