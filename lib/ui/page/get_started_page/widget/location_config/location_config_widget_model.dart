import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/domain/test_service.dart';

import 'location_config_model.dart';

class LocationConfigWidgetModel extends Cubit<LocationConfigModel> {
  final TestService _testService = TestService.service;
  final RegExp regExp = RegExp(
    '\\.(gif|jpe?g|tiff?|png|webp|bmp)',
    caseSensitive: false,
  );

  LocationConfigWidgetModel()
      : super(
          LocationConfigModel(
            directories: [],
            filters: [],
          ),
        );

  VoidCallback removeDirectory(int index) {
    // todo: remove
    return () {
      final directories = List.of(state.directories);
      final removeDir = Directory(directories[index]);
      directories.removeAt(index);
      final filters = List.of(state.filters);
      final deleteFilters = removeDir.listSync().map(
        (e) {
          final pathSegments = e.uri.pathSegments;
          return pathSegments[max(pathSegments.length - 2, 0)];
        },
      );
      filters.removeWhere(
        (element) => deleteFilters.contains(element.topicName),
      );
      emit(LocationConfigModel(
        directories: directories,
        filters: filters,
      ));
    };
  }

  void addDirectory() {
    FilePicker.platform.getDirectoryPath().then(
      (selectedPath) {
        if (selectedPath == null || state.directories.contains(selectedPath)) {
          return;
        }

        final directories = List.of(state.directories);
        directories.add(selectedPath);
        final filters = List.of(state.filters);
        final directory = Directory('$selectedPath/');
        final listSync = directory.listSync();
        listSync.forEach((candidateDir) {
          if (candidateDir is Directory) {
            final images = candidateDir.listSync();
            images.removeWhere(
              (element) => !regExp.hasMatch(element.path),
            );

            final pathSegments = candidateDir.uri.pathSegments;
            filters.add(
              TopicFilter(
                topicName: pathSegments[max(pathSegments.length - 2, 0)],
                itemsCount: images.length,
                include: true,
                path: candidateDir.path,
              ),
            );
          }
        });

        emit(LocationConfigModel(
          directories: directories,
          filters: filters,
        ));
      },
    );
  }

  ValueChanged<bool?>? setFilter(int index) {
    return (bool? val) {
      final directories = List.of(state.directories);
      final filters = List.of(state.filters);
      final target = filters[index];
      filters[index] = TopicFilter(
        topicName: target.topicName,
        itemsCount: target.itemsCount,
        include: val ?? false,
        path: target.path,
      );

      emit(
        LocationConfigModel(
          directories: directories,
          filters: filters,
        ),
      );
    };
  }
}
