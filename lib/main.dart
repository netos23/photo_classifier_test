import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/get_started_page.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_model.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_widget_model.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_widget_model.dart';
import 'package:photo_classifier/ui/page/test_page/test_page.dart';
import 'package:photo_classifier/ui/page/test_page/test_page_widget_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocationConfigWidgetModel(),
        ),
        BlocProvider(
          create: (_) => TestConfigWidgetModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GetStartedPage(),
        routes: {
          '/test': reduceTest,
        },
      ),
    );
  }

  Widget reduceTest(BuildContext context) {
    final testConfig = context.read<TestConfigWidgetModel>();
    return FutureBuilder(
      future: Future.sync(() => {
        if(testConfig.validate){

        }
      }),
      builder: (context, snap){
        return BlocProvider(
          create: (ctx) => TestPageWidgetModel.fromConfig(
            locationConfigModel: ctx.read<LocationConfigWidgetModel>().state,
            testConfigModel: ctx.read<TestConfigWidgetModel>().state,
          ),
          child: TestPage(),
        );
      },
    );
  }
}
