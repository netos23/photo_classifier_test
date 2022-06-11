enum ResourceType {
  directory,
  json,
  selfDirectory,
}

class Resource {
  final ResourceType type;
  final String resource;

  Resource({
    required this.type,
    required this.resource,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resource &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          resource == other.resource;

  @override
  int get hashCode => type.hashCode ^ resource.hashCode;
}
