class TestConfigModel {
  final int? questionsCount;
  final bool? hasAnswer;
  final int? maxVariantsCount;
  final bool? hasTimer;
  final String? output;

  TestConfigModel(
    this.questionsCount,
    this.hasAnswer,
    this.maxVariantsCount,
    this.hasTimer,
    this.output,
  );

  TestConfigModel copyWith({
    int? questionsCount,
    bool? showAnswer,
    int? maxVariantsCount,
    bool? showTimer,
    String? output,
  }) =>
      TestConfigModel(
        questionsCount ?? this.questionsCount,
        showAnswer ?? this.hasAnswer,
        maxVariantsCount ?? this.maxVariantsCount,
        showTimer ?? this.hasTimer,
        output ?? this.output,
      );
}
