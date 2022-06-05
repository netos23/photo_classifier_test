import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_config_model.dart';
import 'location_config_widget_model.dart';

class DirectoryPicker extends StatelessWidget {
  const DirectoryPicker({Key? key}) : super(key: key);

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
                    'Директории',
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
              child: Text('Добавьте папки в которых находятся колекции'),
            ),
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 600,
                    minHeight: 300,
                    maxWidth: 400,
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: widgetModel.state.directories.length,
                      itemBuilder: (context, index) {
                        final directory = widgetModel.state.directories[index];
                        return ListTile(
                          title: Text(directory),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: widgetModel.removeDirectory(index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: FloatingActionButton(
                onPressed: widgetModel.addDirectory,
                child: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
