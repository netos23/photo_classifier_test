import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_classifier/ui/page/get_started_page/widget/location_config/location_config_widget_model.dart';

class TopicFilter extends StatelessWidget {
  const TopicFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetModel = context.watch<LocationConfigWidgetModel>();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 700,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Колекции',
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
              child: Text('Выбирите колекцие которые стоит включить в тест'),
            ),
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 1000,
                    minHeight: 300,
                    maxWidth: 400,
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: widgetModel.state.filters.length,
                      itemBuilder: (context, index) {
                        final filter = widgetModel.state.filters[index];
                        return ListTile(
                          title: Text(filter.topicName),
                          subtitle: Text(
                            'Количество изображений: ${filter.itemsCount}',
                          ),
                          trailing: Checkbox(
                            value: filter.include,
                            onChanged: widgetModel.setFilter(index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
