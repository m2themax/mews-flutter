import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/icon/icons_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story allIconsStory = Story(
  name: 'Media And Icons/Icons/All Icons',
  builder: (context) => GridView.builder(
    itemCount: optimusIcons.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
    ),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(spacing100),
      child: Column(
        children: [
          OptimusIcon(iconData: optimusIcons[index].data),
          Text(
            optimusIcons[index].name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  ),
);
