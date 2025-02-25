import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';

class GroupWrapper extends StatelessWidget {
  const GroupWrapper({
    super.key,
    required this.child,
    this.label,
    this.error,
    this.isRequired = false,
  });

  final Widget child;
  final String? label;
  final String? error;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final label = this.label;
    final error = this.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label.isNotEmpty)
          OptimusFieldLabel(label: label, isRequired: isRequired),
        child,
        if (error != null && error.isNotEmpty) OptimusFieldError(error: error),
      ],
    );
  }
}
