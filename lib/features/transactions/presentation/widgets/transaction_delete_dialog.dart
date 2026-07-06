import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/custom_dialog.dart';

class TransactionDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const TransactionDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      icon: Icons.warning_rounded,
      iconColor: AppColors.warning,
      title: AppLocalizations.of(context)!.confirmDelete,
      message: AppLocalizations.of(context)!.confirmDeleteMessage,
      actions: [
        DialogAction(
          label: AppLocalizations.of(context)!.cancel,
          color: AppColors.info,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DialogAction(
          label: AppLocalizations.of(context)!.delete,
          color: AppColors.error,
          onTap: () {
            Navigator.pop(context);
            onConfirm();
          },
        ),
      ],
    );
  }
}