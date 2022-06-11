import 'package:flutter_test/flutter_test.dart';
import 'package:photo_classifier/data/entity/resource.dart';
import 'package:photo_classifier/data/repository/resource_repository.dart';

void main() {
  late IResourceRepository repository;

  late Resource directoryResource;
  late Resource jsonResource;
  late Resource selfDirectoryResource;

  setUp(() {
    repository = InMemoryResourceRepository();

    directoryResource = Resource(
      type: ResourceType.directory,
      resource: './test',
    );
    jsonResource = Resource(
      type: ResourceType.json,
      resource: '{test: "test"}',
    );
    selfDirectoryResource = Resource(
      type: ResourceType.selfDirectory,
      resource: './testSelf',
    );

    repository.save(directoryResource);
    repository.save(jsonResource);
    repository.save(selfDirectoryResource);
  });

  test('get multiple resources', () {
    final resources = repository.resources;

    final resourceSet = {
      directoryResource,
      jsonResource,
      selfDirectoryResource,
    };

    expect(
      resources.fold<bool>(
        true,
        (previousValue, element) =>
            previousValue && resourceSet.contains(element),
      ),
      true,
    );
  });

  test('remove resource by object', () {
    repository.remove(jsonResource);

    final resources = repository.resources;

    final resourceSet = {
      directoryResource,
      selfDirectoryResource,
    };

    expect(
      resources.fold<bool>(
        true,
        (previousValue, element) =>
            previousValue && resourceSet.contains(element),
      ),
      true,
    );

    expect(resources.contains(jsonResource), false);
  });

  test('remove resource by name', () {
    repository.removeAllByResourceName(jsonResource.resource);

    final resources = repository.resources;

    final resourceSet = {
      directoryResource,
      selfDirectoryResource,
    };

    expect(
      resources.fold<bool>(
        true,
        (previousValue, element) =>
            previousValue && resourceSet.contains(element),
      ),
      true,
    );

    expect(false, resources.contains(jsonResource));
  });

  test('remove resource by name', () {
    repository.removeAllByResourceName(jsonResource.resource);

    final resources = repository.resources;

    final resourceSet = {
      directoryResource,
      selfDirectoryResource,
    };

    expect(
      resources.fold<bool>(
        true,
        (previousValue, element) =>
            previousValue && resourceSet.contains(element),
      ),
      true,
    );

    expect(false, resources.contains(jsonResource));
  });

  test('clean', () {
    final resources = repository.clean();

    final resourceSet = {
      directoryResource,
      jsonResource,
      selfDirectoryResource,
    };

    expect(
      resources.fold<bool>(
        true,
        (previousValue, element) =>
            previousValue && resourceSet.contains(element),
      ),
      true,
    );

    expect(repository.resources, equals([]));
  });
}
