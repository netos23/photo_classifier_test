import 'package:photo_classifier/data/entity/resource.dart';

class Collection {
  final bool enable;
  final String name;
  final Resource resource;

  Collection({
    required this.enable,
    required this.name,
    required this.resource,
  });

  Collection switchState() => Collection(
        enable: !enable,
        name: name,
        resource: resource,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collection &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          resource == other.resource;

  @override
  int get hashCode => name.hashCode ^ resource.hashCode;
}
