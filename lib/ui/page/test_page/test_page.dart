import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/test_page/test_page_widget_model.dart';
import 'package:photo_classifier/ui/page/test_page/test_widget_model.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetModel = context.watch<TestPageWidgetModel>();
    return Scaffold(
      appBar: !widgetModel.finished
          ? AppBar(
              title: widgetModel.hasTimer
                  ? Text(widgetModel.timeSinceStart)
                  : null,
              actions: [
                if (widgetModel.hasAnswer)
                  Container(
                    color: widgetModel.lastCorrect ? Colors.green : Colors.red,
                    child: Center(
                      child: Text(
                          widgetModel.lastCorrect ? 'Правильно' : 'Неправильно'),
                    ),
                  )
              ],
            )
          : null,
      body: Center(
        child: widgetModel.finished
            ? _buildResult(context)
            : _buildTest(widgetModel),
      ),
    );
  }

  Column _buildTest(TestPageWidgetModel widgetModel) {
    final question = widgetModel.currentQuestion;
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Image(
            image: FileImage(widgetModel.image),
          ),
        ),
        Flexible(
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: question.answers.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: widgetModel.answer(index),
                child: Text(question.answers[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResult(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('Тест завершен.'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/'),
          child: Text('На главную'),
        ),
      ],
    );
  }
}
