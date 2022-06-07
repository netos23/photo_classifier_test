import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_model.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_model.dart';
import 'package:photo_classifier/ui/page/test_page/test_widget_model.dart';
import 'package:photo_classifier/utils/structures.dart';

class TestPageWidgetModel extends Cubit<TestPageModel> {
  static final RegExp regExp = RegExp(
    '\\.(gif|jpe?g|tiff?|png|webp|bmp)',
    caseSensitive: false,
  );

  TestPageWidgetModel(TestPageModel initialState) : super(initialState);

  factory TestPageWidgetModel.fromConfig({
    required LocationConfigModel locationConfigModel,
    required TestConfigModel testConfigModel,
  }) {
    final maxQuestions = testConfigModel.questionsCount ?? 10;
    final questions = <Question>[];
    final variants = <Pair<String, List<File>>>[];

    locationConfigModel.filters
        .where(
          (element) => element.include,
        )
        .where(
          (element) => element.itemsCount > 0,
        )
        .forEach(
          (element) => variants.add(
            Pair(
              element.topicName,
              Directory(element.path)
                  .listSync()
                  .where((element) => regExp.hasMatch(element.path))
                  .map((e) => e as File)
                  .toList(),
            ),
          ),
        );

    final maxVariants =
        min(testConfigModel.maxVariantsCount ?? 4, variants.length);
    final random = Random();

    for (int i = 0; i < maxQuestions; i++) {
      var index = random.nextInt(variants.length);
      final correct = variants[index];
      final answers = <String>[];

      if (maxVariants != variants.length) {
        for (int j = 0; j < maxVariants; j++) {
          final nextIndex = ((random.nextInt(variants.length) ^ index) +
                  (DateTime.now().millisecondsSinceEpoch ^ index)) %
              variants.length;
          answers.add(variants[nextIndex].key);
        }
        answers.add(correct.key);
      } else {
        for (var element in variants) {
          answers.add(element.key);
        }
      }

      answers.shuffle();
      questions.add(Question(
        image: correct.value[random.nextInt(correct.value.length)],
        answers: answers,
        correctIndex: correct.key.hashCode,
      ));
    }

    return TestPageWidgetModel(
      TestPageModel(
        questions: questions,
        current: 0,
        hasTimer: testConfigModel.hasTimer ?? false,
        hasAnswer: testConfigModel.hasAnswer ?? false,
        output: testConfigModel.output ?? '',
      ),
    );
  }

  File get image => state.questions[state.current].image;

  Question get currentQuestion {
    final questions = state.questions;
    var question = questions[state.current];

    if (question.beginTimestamp == null) {
      question = Question(
        image: question.image,
        answers: question.answers,
        correctIndex: question.correctIndex,
        beginTimestamp: DateTime.now().millisecondsSinceEpoch,
      );

      questions[state.current] = question;
      emit(
        TestPageModel(
          questions: questions,
          current: state.current,
          hasTimer: state.hasTimer,
          hasAnswer: state.hasAnswer,
          output: state.output,
        ),
      );
    }

    return question;
  }

  bool get finished => state.current >= state.questions.length;

  String get timeSinceStart {
    if (isClosed || finished) {
      return '';
    }
    var nowTime = DateTime.now().millisecondsSinceEpoch;
    final delta =
        nowTime - (state.questions[state.current].beginTimestamp ?? nowTime);
    if (state.lastUpdate == null) {
      emit(
        TestPageModel(
          questions: state.questions,
          current: state.current,
          hasTimer: state.hasTimer,
          hasAnswer: state.hasAnswer,
          output: state.output,
        ),
      );
    }
    Future.delayed(
      Duration(milliseconds: 900),
      () => timeSinceStart,
    );

    final dateTime = DateTime(0, 0, 0, 0, 0, 0, delta, 0);
    return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }

  bool get hasTimer => state.hasTimer;

  bool get hasAnswer => state.hasAnswer && state.current > 0;

  bool get lastCorrect {
    final question = state.questions[state.current - 1];
    return question.answers[question.actualIndex ?? 0].hashCode ==
        question.correctIndex;
  }

  VoidCallback answer(int index) {
    return () {
      final questions = state.questions;
      var question = questions[state.current];
      question = Question(
          image: question.image,
          answers: question.answers,
          correctIndex: question.correctIndex,
          actualIndex: index,
          beginTimestamp: question.beginTimestamp,
          endTimestamp: DateTime.now().millisecondsSinceEpoch);
      questions[state.current] = question;
      emit(
        TestPageModel(
          questions: questions,
          current: state.current + 1,
          hasAnswer: state.hasAnswer,
          hasTimer: state.hasTimer,
          output: state.output,
        ),
      );

      if (finished) {
        final output = File(state.output);
        final text = StringBuffer();
        for (var question in questions) {
          final delta =
              (question.endTimestamp ?? 0) - (question.beginTimestamp ?? 0);
          final correct =
              question.answers[question.actualIndex ?? 0].hashCode ==
                  question.correctIndex;
          text.write('${delta} ');
          text.write('${correct} ');
          text.write('${question.image.path} ');
          text.writeln('${question.answers[question.actualIndex ?? 0]} ');
        }
        output.writeAsString(text.toString());
      }
    };
  }
}
