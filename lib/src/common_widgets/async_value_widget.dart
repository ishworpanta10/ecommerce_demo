import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (err, st) => Center(child: ErrorMessageWidget(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
