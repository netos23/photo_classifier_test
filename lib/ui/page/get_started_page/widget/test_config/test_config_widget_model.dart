import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_model.dart';

class TestConfigWidgetModel extends Cubit<TestConfigModel> {
  TestConfigWidgetModel() : super(TestConfigModel(10, false, 4, false, ''));

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
