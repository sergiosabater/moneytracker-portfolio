import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/shared/presentation/widgets/custom_dialog.dart';

class TransactionOptionsDialog extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionOptionsDialog({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      icon: Icons.settings,
      iconColor: AppColors.accent,
      title: AppLocalizations.of(context)!.transactionOptions,
      actions: [
        DialogAction(
          label: AppLocalizations.of(context)!.edit,
          color: AppColors.info,
          icon: Icons.edit,
          onTap: () {
            Navigator.pop(context);
            onEdit();
          },
        ),
        DialogAction(
          label: AppLocalizations.of(context)!.delete,
          color: AppColors.error,
          icon: Icons.delete,
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
      ],
    );
  }
}