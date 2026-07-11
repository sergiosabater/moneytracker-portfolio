import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/shared/presentation/widgets/confirmation_dialog.dart';

class NoDescriptionDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const NoDescriptionDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ConfirmationDialog(
      icon: Icons.warning_rounded,
      iconColor: AppColors.warning,
      title: l10n.noDescriptionTitle,
      message: l10n.noDescriptionMessage,
      cancelLabel: l10n.cancel,
      cancelColor: AppColors.error,
      confirmLabel: l10n.add,
      confirmColor: AppColors.info,
      onConfirm: onConfirm,
    );
  }
}