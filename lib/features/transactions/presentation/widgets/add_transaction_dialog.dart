import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';
import 'package:moneytracker/features/transactions/presentation/providers/transactions_notifier.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/no_description_dialog.dart';

class AddTransactionDialog extends ConsumerStatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  ConsumerState<AddTransactionDialog> createState() =>
      _AddTransactionDialogState();
}

class _AddTransactionDialogState extends ConsumerState<AddTransactionDialog>
    with SingleTickerProviderStateMixin {
  TransactionType type = TransactionType.income;
  double amount = 0.0;
  String description = '';

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final ScrollController _scrollController = ScrollController();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _amountFocusNode.addListener(() {
      if (_amountFocusNode.hasFocus) {
        _scrollToMakeButtonVisible();
      }
    });
    _descriptionFocusNode.addListener(() {
      if (_descriptionFocusNode.hasFocus) {
        _scrollToMakeButtonVisible();
      }
    });

    _animationController.forward();
  }

  void _scrollToMakeButtonVisible() async {
    await Future.delayed(const Duration(milliseconds: 50));

    int attempts = 0;
    while (attempts < 20) {
      if (!mounted) return;
      if (MediaQuery.of(context).viewInsets.bottom > 0) break;
      await Future.delayed(const Duration(milliseconds: 50));
      attempts++;
    }

    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final renderBox =
          _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final buttonPosition = renderBox.localToGlobal(Offset.zero);
      final buttonBottom = buttonPosition.dy + renderBox.size.height;

      final screenHeight = MediaQuery.of(context).size.height;
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      final availableHeight = screenHeight - keyboardHeight;

      if (buttonBottom > availableHeight) {
        final offsetNeeded = buttonBottom - availableHeight + 20;

        _scrollController.animateTo(
          _scrollController.offset + offsetNeeded,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    _amountFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  bool get _isValid => amount > 0;

  void _handleSave() {
    if (!_isValid) return;

    if (description.trim().isEmpty) {
      _showNoDescriptionDialog();
      return;
    }

    _saveTransaction();
  }

  void _showNoDescriptionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context)!.dismiss,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return NoDescriptionDialog(
          onConfirm: () {
            _saveTransaction();
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  void _saveTransaction() {
    final transaction = Transaction(
      type: type,
      amount: type == TransactionType.expense ? -amount : amount,
      description: description.trim().isEmpty
          ? AppLocalizations.of(context)!.noDescription
          : description,
      dateTime: DateTime.now(),
    );

    ref.read(transactionsNotifierProvider.notifier).addTransaction(transaction);

    final messenger = ScaffoldMessenger.of(context);
    final localizations = AppLocalizations.of(context)!;

    Navigator.pop(context);

    messenger.showSnackBar(
      SnackBar(
        content: Text(localizations.transactionAdded),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.income,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final dividerColor = Theme.of(context).dividerColor;
    final secondaryColor =
        textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              height: 5,
              width: 40,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: dividerColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: secondaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    AppLocalizations.of(context)!.newTransaction,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TypeSelector(
                          selectedType: type,
                          onTypeChanged: (newType) {
                            setState(() => type = newType);
                          },
                        ),
                        const SizedBox(height: 32),
                        _AmountField(
                          controller: _amountController,
                          focusNode: _amountFocusNode,
                          type: type,
                          onChanged: (value) {
                            final valueWithoutDollarSign = value.replaceAll(
                              '\$',
                              '',
                            );
                            final valueWithoutCommas = valueWithoutDollarSign
                                .replaceAll(',', '');
                            setState(() {
                              amount = double.tryParse(valueWithoutCommas) ?? 0.0;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        _DescriptionField(
                          controller: _descriptionController,
                          focusNode: _descriptionFocusNode,
                          onChanged: (value) {
                            setState(() => description = value);
                          },
                        ),
                        const SizedBox(height: 32),
                        _SaveButton(
                          key: _buttonKey,
                          isEnabled: _isValid,
                          onPressed: _handleSave,
                        ),
                        SizedBox(height: keyboardHeight > 0 ? 40 : 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onTypeChanged;

  const _TypeSelector({
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TypeOption(
            icon: Icons.arrow_downward,
            label: AppLocalizations.of(context)!.income,
            color: AppColors.accent,
            isSelected: selectedType == TransactionType.income,
            onTap: () => onTypeChanged(TransactionType.income),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TypeOption(
            icon: Icons.arrow_upward,
            label: AppLocalizations.of(context)!.expense,
            color: AppColors.expense,
            isSelected: selectedType == TransactionType.expense,
            onTap: () => onTypeChanged(TransactionType.expense),
          ),
        ),
      ],
    );
  }
}

class _TypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedBackground = theme.colorScheme.surface;
    final unselectedBorder = theme.dividerColor;
    final unselectedText =
        theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : unselectedBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : unselectedBorder,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : unselectedText.withValues(alpha: 0.6),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? color : unselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TransactionType type;
  final ValueChanged<String> onChanged;

  const _AmountField({
    required this.controller,
    required this.focusNode,
    required this.type,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        type == TransactionType.income ? AppColors.accent : AppColors.expense;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.amount,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            focusNode: focusNode,
            inputFormatters: [
              CurrencyTextInputFormatter.currency(symbol: '\$'),
            ],
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            decoration: InputDecoration.collapsed(
              hintText: '\$0.00',
              hintStyle: TextStyle(color: color.withValues(alpha: 0.3)),
            ),
            keyboardType: TextInputType.number,
            autofocus: false,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _DescriptionField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final borderColor = theme.dividerColor;
    final labelColor = theme.textTheme.bodyLarge?.color ?? Colors.grey.shade700;
    final hintColor =
        theme.textTheme.bodyMedium?.color ?? Colors.grey.shade400;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: labelColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            focusNode: focusNode,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration.collapsed(
              hintText: AppLocalizations.of(context)!.enterDescription,
              hintStyle: TextStyle(color: hintColor),
            ),
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const _SaveButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final disabledColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    final color = isEnabled ? AppColors.info : disabledColor;

    return InkWell(
      onTap: isEnabled ? onPressed : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.add,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}