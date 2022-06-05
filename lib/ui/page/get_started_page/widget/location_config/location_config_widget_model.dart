import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_config_model.dart';

class LocationConfigWidgetModel extends Cubit<LocationConfigModel> {

  LocationConfigWidgetModel()
      : super(
          LocationConfigModel(
            directories: [],
            filters: [],
          ),
        );

  VoidCallback removeDirectory(int index) {
    // todo: remove
    return () {};
  }

  void addDirectory() {}

  ValueChanged<bool?>? setFilter(int index) {
    return (bool? val) {};
  }
}
