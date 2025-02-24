import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldError extends StatelessWidget {
  const OptimusFieldError({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) => OptimusCaption(
        child: Text(
          error,
          style: TextStyle(color: OptimusTheme.of(context).colors.danger500),
        ),
      );
}
