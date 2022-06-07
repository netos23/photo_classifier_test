import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_model.dart';

class TestConfigWidgetModel extends Cubit<TestConfigModel> {
  TestConfigWidgetModel()
      : super(
    TestConfigModel(10, false, 4, false, ''),
  );

  String get output {
    var outputPath = state.output ?? '';
    if (outputPath.length > 10) {
      outputPath = File(outputPath).uri.pathSegments.last;
    }

    return outputPath;
  }

  bool get validate {
    if (state.output == '') {
      return false;
    }

    if (state.questionsCount == null || (state.questionsCount ?? 0) <= 0) {
      return false;
    }
    if (state.maxVariantsCount == null || (state.maxVariantsCount ?? 0) <= 0) {
      return false;
    }

    return true;
  }


  void setOutput() {
    FilePicker.platform.saveFile(
      dialogTitle: 'Выбиррете фаил для сохранения:',
      allowedExtensions: ['txt'],
    ).then((value) {
      if (value == null) return;
      emit(state.copyWith(output: value));
    });
  }

  VoidCallback startTest({VoidCallback? onSuccess}) {
    return () {
      if (onSuccess != null) {
        onSuccess.call();
      }
    };
  }

  void showTimer(bool? value) {
    emit(state.copyWith(showTimer: value));
  }

  void showAnswer(bool? value) {
    emit(state.copyWith(showAnswer: value));
  }

  void setMaxVariantsCount(String value) {
    final count = int.tryParse(value);
    if (count != null) {
      emit(
        state.copyWith(
          questionsCount: count,
        ),
      );
    }
  }

  void setQuestionsCount(String value) {
    var count = int.tryParse(value);
    if (count != null) {
      emit(
        state.copyWith(
          questionsCount: count,
        ),
      );
    }
  }
}
