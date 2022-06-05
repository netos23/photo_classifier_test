import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/directory_picker_widget.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_model.dart'
    as model;
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_widget_model.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/topic_filter_widget.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_model.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_widget.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_widget_model.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HDS',
          style: Theme.of(context).textTheme.headline2,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LocationConfigWidgetModel(),
          ),
          BlocProvider(
            create: (_) => TestConfigWidgetModel(),
          ),
        ],
        child: Center(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return ListView(
                scrollDirection: orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  DirectoryPicker(),
                  _buildDivider(
                    context: context,
                    orientation: orientation,
                  ),
                  TopicFilter(),
                  _buildDivider(
                    context: context,
                    orientation: orientation,
                  ),
                  TestConfig(),
                ],
              );
            },
          ),
        ),
        // child: SingleChildScrollView(
        //   child: Wrap(
        //     children: const [
        //       DirectoryPicker(),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget _buildDivider({
    required BuildContext context,
    required Orientation orientation,
  }) {
    return orientation == Orientation.landscape
        ? const VerticalDivider(
            indent: 100,
            endIndent: 100,
          )
        : const Divider(
            indent: 100,
            endIndent: 100,
          );
  }
}
