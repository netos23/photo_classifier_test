class TestConfigModel {
  final int? questionsCount;
  final bool? showAnswer;
  final int? maxVariantsCount;
  final bool? showTimer;

  TestConfigModel(
    this.questionsCount,
    this.showAnswer,
    this.maxVariantsCount,
    this.showTimer,
  );

  TestConfigModel copyWith({
    int? questionsCount,
    bool? showAnswer,
    int? maxVariantsCount,
    bool? showTimer,
  }) =>
      TestConfigModel(
        questionsCount ?? this.questionsCount,
        showAnswer ?? this.showAnswer,
        maxVariantsCount ?? this.maxVariantsCount,
        showTimer ?? this.showTimer,
      );
}
