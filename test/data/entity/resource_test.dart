import 'package:flutter_test/flutter_test.dart';
import 'package:photo_classifier/data/entity/resource.dart';
import 'package:photo_classifier/data/repository/resource_repository.dart';

void main() {
  test('Test equals', () {
    final resourceA = Resource(
      type: ResourceType.json,
      resource: '{test: test}',
    );
    final resourceB = Resource(
      type: ResourceType.json,
      resource: '{test: test}',
    );
    expect(true, resourceA == resourceB);
  });

  test('Test hashcode', () {
    final resourceA = Resource(
      type: ResourceType.json,
      resource: '{test: test}',
    );
    final resourceB = Resource(
      type: ResourceType.json,
      resource: '{test: test}',
    );
    expect(true, resourceA.hashCode == resourceB.hashCode);
  });
}
