import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_widgets/alert_dialogs.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: error,
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
    }
  }
}
