import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story searchFieldStory = Story(
  name: 'Forms/Search field',
  builder: (context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: SearchStory(context.knobs),
  ),
);

class SearchStory extends StatefulWidget {
  const SearchStory(this.knobs, {super.key});

  final KnobsBuilder knobs;

  @override
  State<SearchStory> createState() => _SearchStoryState();
}

class _SearchStoryState extends State<SearchStory> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onValueChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onValueChanged)
      ..dispose();
    super.dispose();
  }

  void _onValueChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;

    return OptimusSearch<String>(
      controller: _controller,
      items: _characters
          .where(
            (c) => c.toLowerCase().contains(_controller.text.toLowerCase()),
          )
          .map(
            (c) => ListDropdownTile(
              value: c,
              title: Text(c),
              subtitle: Text('Subtitle #$c'),
            ),
          )
          .toList(),
      onChanged: (_) {},
      label: k.text(label: 'Label', initial: 'Search field'),
      placeholder: k.text(
        label: 'Placeholder',
        initial: 'Start typing something',
      ),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      isRequired: k.boolean(label: 'Required'),
      caption: Text(k.text(label: 'Caption', initial: '')),
      secondaryCaption: Text(k.text(label: 'Secondary caption', initial: '')),
      size: k.options(
        label: 'Size',
        initial: OptimusWidgetSize.large,
        options: sizeOptions,
      ),
      isUpdating: k.boolean(label: 'Updating', initial: false),
      isClearEnabled: k.boolean(label: 'Clear enabled', initial: false),
      error: k.text(label: 'Error', initial: ''),
      groupBy: k.boolean(label: 'Grouped', initial: false)
          ? (item) => item.split(' ')[1][0].toLowerCase()
          : null,
    );
  }
}

const _characters = [
  'Jon Snow',
  'Ned Stark',
  'Robb Stark',
  'Sansa Stark',
  'Daenerys Targaryen',
];
