import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/test_config/test_config_widget_model.dart';

class TestConfig extends StatelessWidget {
  const TestConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetModel = context.watch<TestConfigWidgetModel>();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 700,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Настройки теста',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              const Flexible(
                child: Text('Сконфигурируйте тест'),
              ),
              Flexible(
                child: ConstrainedBox(
                  constraints: _buildFormBoxConstraints(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: widgetModel.setQuestionsCount,
                      initialValue: '${widgetModel.state.questionsCount}',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        // todo: error text
                        // errorText: 'test\n\n\ntext',
                        errorMaxLines: 1,
                        label: Text('Количество вопросов'),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ConstrainedBox(
                  constraints: _buildFormBoxConstraints(),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: widgetModel.setMaxVariantsCount,
                      initialValue: '${widgetModel.state.maxVariantsCount}',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        // todo: error text
                        // errorText: 'test\n\n\ntext',
                        errorMaxLines: 1,
                        label: Text('Максимальное количество ответов'),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Показывать ответы'),
                    Checkbox(
                      value: widgetModel.state.showAnswer ?? false,
                      onChanged: widgetModel.showAnswer,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Показать таймер'),
                    Checkbox(
                      value: widgetModel.state.showTimer ?? false,
                      onChanged: widgetModel.showTimer,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: OutlinedButton(
                  onPressed: widgetModel.startTest(
                    onSuccess: () => Navigator.of(context).pushNamed('/test'),
                  ),
                  child: Text('Начать'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxConstraints _buildFormBoxConstraints() {
    return const BoxConstraints(
      maxWidth: 200,
    );
  }
}
