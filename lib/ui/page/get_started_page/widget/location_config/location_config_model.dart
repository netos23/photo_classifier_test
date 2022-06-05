class LocationConfigModel {
  final List<String> directories;
  final List<TopicFilter> filters;

  LocationConfigModel({
    required this.directories,
    required this.filters,
  });
}

class TopicFilter {
  final String topicName;
  final int itemsCount;
  final bool include;

  TopicFilter({
    required this.topicName,
    required this.itemsCount,
    required this.include,
  });
}
