// lib/core/widgets/custom_snackbar_helper.dart (o el archivo que uses)

import 'package:flutter/material.dart';

// --- Tus funciones de construcción existentes ---

SnackBar buildSuccessSnackbar(String message) {
  // ... (código existente) ...
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.check_circle_outline, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(child: Text(message)),
      ],
    ),
    backgroundColor: Colors.green.shade700,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 2),
  );
}

SnackBar buildErrorSnackbar(String message) {
  // ... (código existente) ...
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(child: Text(message)),
      ],
    ),
    backgroundColor: Colors.red.shade700,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
  );
}


class SnackbarHelper {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        buildSuccessSnackbar(message)
    );
  }

  static void showError(
      BuildContext context,
      String message,
      {String? actionLabel,
        VoidCallback? onActionPressed,
        Duration duration = const Duration(seconds: 3)
      }) {

    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBarAction? action;
    if (actionLabel != null && onActionPressed != null) {
      action = SnackBarAction(
        label: actionLabel,
        textColor: Colors.white,
        onPressed: onActionPressed,
      );
    }


    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: duration,
      action: action,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
