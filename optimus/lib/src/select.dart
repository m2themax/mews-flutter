import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/typography/presets.dart';

typedef CurrentValueBuilder<T> = Widget Function(BuildContext context, T value);

@Deprecated('Use `OptimusSelectInput` instead')
class OptimusSelect<T> extends StatefulWidget {
  @Deprecated('Use `OptimusSelectInput` instead')
  const OptimusSelect({
    super.key,
    this.label,
    this.placeholder = '',
    this.value,
    required this.items,
    required this.builder,
    this.isEnabled = true,
    this.isRequired = false,
    this.prefix,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    required this.onItemSelected,
  });

  final String? label;
  final String placeholder;
  final T? value;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final bool isRequired;
  final Widget? prefix;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final CurrentValueBuilder<T> builder;
  final ValueSetter<T> onItemSelected;

  @override
  State<OptimusSelect<T>> createState() => _OptimusSelectState<T>();
}

class _OptimusSelectState<T> extends State<OptimusSelect<T>> with ThemeGetter {
  final _selectFieldKey = GlobalKey();
  final _node = FocusNode();
  bool _isOpened = false;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OverlayController(
        onItemSelected: widget.onItemSelected,
        focusNode: _node,
        anchorKey: _selectFieldKey,
        items: widget.items,
        onShown: () => setState(() => _isOpened = true),
        onHidden: () => setState(() => _isOpened = false),
        child: GestureDetector(
          onTap: () => widget.isEnabled ? _node.requestFocus() : null,
          child: Focus(
            focusNode: _node,
            child: FieldWrapper(
              fieldBoxKey: _selectFieldKey,
              focusNode: _node,
              label: widget.label,
              error: widget.error,
              isEnabled: widget.isEnabled,
              isRequired: widget.isRequired,
              prefix: widget.prefix,
              suffix: _icon,
              caption: widget.caption,
              secondaryCaption: widget.secondaryCaption,
              children: [
                _SelectedValue(
                  size: widget.size,
                  textStyle: _textStyle,
                  child: _fieldContent,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _fieldContent {
    final value = widget.value;

    return value == null
        ? Text(widget.placeholder, style: _textStyle)
        : DefaultTextStyle.merge(
            style: preset300s,
            child: widget.builder(context, value),
          );
  }

  Icon get _icon => Icon(
        _isOpened ? OptimusIcons.chevron_up : OptimusIcons.chevron_down,
        size: 24,
        color: theme.isDark ? theme.colors.neutral0 : theme.colors.neutral400,
      );

  TextStyle get _textStyle {
    if (widget.value == null) {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200s.copyWith(color: _placeholderColor);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300s.copyWith(color: _placeholderColor);
      }
    } else {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200s.copyWith(color: _textColor);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300s.copyWith(color: _textColor);
      }
    }
  }

  Color get _placeholderColor =>
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

  Color get _textColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
}

class _SelectedValue extends StatelessWidget {
  const _SelectedValue({
    required this.child,
    required this.size,
    required this.textStyle,
  });

  final Widget child;
  final OptimusWidgetSize size;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBorderContainer(),
          ],
        ),
      );

  Widget _buildBorderContainer() => Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: SizedBox(
          height: size.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DefaultTextStyle(
                style: textStyle,
                child: child,
              ),
            ],
          ),
        ),
      );
}
