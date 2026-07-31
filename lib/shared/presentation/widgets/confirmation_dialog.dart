import 'package:flutter/material.dart';
import 'package:moneytracker/shared/presentation/widgets/custom_dialog.dart';

class ConfirmationDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String cancelLabel;
  final Color cancelColor;
  final String confirmLabel;
  final Color confirmColor;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.cancelLabel,
    required this.cancelColor,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      icon: icon,
      iconColor: iconColor,
      title: title,
      message: message,
      actions: [
        DialogAction(
          label: cancelLabel,
          color: cancelColor,
          onTap: () => Navigator.pop(context),
        ),
        DialogAction(
          label: confirmLabel,
          color: confirmColor,
          onTap: () {
            Navigator.pop(context);
            onConfirm();
          },
        ),
      ],
    );
  }
}