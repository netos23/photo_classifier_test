import 'package:photo_classifier/data/entity/resource.dart';

abstract class IResourceRepository {
  void save(Resource resource);

  Resource? remove(Resource resource);

  Iterable<Resource> removeAllByResourceName(String name);

  Iterable<Resource> clean();

  Iterable<Resource> get resources;
}

class InMemoryResourceRepository implements IResourceRepository {
  final Set<Resource> _collectionsSet = {};

  InMemoryResourceRepository();

  @override
  void save(Resource collection) => _collectionsSet.add(collection);

  @override
  Iterable<Resource> get resources => _collectionsSet;

  @override
  Resource? remove(Resource collection) =>
      _collectionsSet.remove(collection) ? collection : null;

  @override
  List<Resource> removeAllByResourceName(String name) {
    final removed = <Resource>[];

    _collectionsSet.removeWhere((r) {
      final nameFilter = r.resource == name;
      if (nameFilter) {
        removed.add(r);
      }
      return nameFilter;
    });

    return removed;
  }

  @override
  Iterable<Resource> clean() {
    final previousStorage = List.of(_collectionsSet);
    _collectionsSet.clear();
    return previousStorage;
  }
}
