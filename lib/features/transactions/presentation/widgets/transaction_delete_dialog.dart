import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/shared/presentation/widgets/confirmation_dialog.dart';

class TransactionDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const TransactionDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ConfirmationDialog(
      icon: Icons.warning_rounded,
      iconColor: AppColors.warning,
      title: l10n.confirmDelete,
      message: l10n.confirmDeleteMessage,
      cancelLabel: l10n.cancel,
      cancelColor: AppColors.info,
      confirmLabel: l10n.delete,
      confirmColor: AppColors.error,
      onConfirm: onConfirm,
    );
  }
}